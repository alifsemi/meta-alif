/* Copyright (C) 2023 Alif Semiconductor - All Rights Reserved.
 * Use, distribution and modification of this code is permitted under the
 * terms stated in the Alif Semiconductor Software License Agreement
 *
 * You should have received a copy of the Alif Semiconductor Software
 * License Agreement with this file. If not, please write to:
 * contact@alifsemi.com, or visit: https://alifsemi.com/license
 *
 */

/**************************************************************************//**
 * @file     MHU_A32_Flasher.c
 * @author   Ganesh Ramani
 * @email    ganesh.ramani@alifsemi.com
 * @version  v0.1
 * @date     23-Oct-2023
 * @brief    A32 MHU Application to Communicate with M55 for Flashing binary.
 * @bug      None.
 * @Note     None
 ******************************************************************************/

#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <errno.h>
#include <pthread.h>
#include <signal.h>
#include <string.h>
#include <sys/mman.h>

#define RPMSG_CREATE_EPT_IOCTL _IOW(0xb5, 0x1, struct rpmsg_endpoint_info)
#define RPMSG_DESTROY_EPT_IOCTL _IO(0xb5, 0x2)
#define MHU_SERVICES_DATA_LOC 0x0827F000
#define MAX_PATH_LEN 4096
#define OSPI1_BASE   0xC0000000
#define OSPI1_SIZE   0xE00000
#define NUM_IMG_LIST 2

struct rpmsg_endpoint_info {
    char name[32];
    u_int32_t src;
    u_int32_t dst;
};

struct ospi1_prm {
    char          file_name[MAX_PATH_LEN];
    long long int file_addr;
    unsigned int  file_len;
};

/*
 * struct rpmsg_endpoint_info - endpoint info representation
 * @name: name of service
 * @src: local address
 * @dst: destination address
 */
struct rpmsg_endpoint_info semhu0_eptinfo = {"m55_he_mhu0",
                                             0XFFFFFFFF,
                                             0xFFFFFFFF};

int fd, fd_semhu0_ept, mem_fd;
uint32_t mapped_size;
FILE *bin_stream;
void *map_base;
struct ospi1_prm ospi1_prm_arr[NUM_IMG_LIST];

extern int errno;

void sigintHandler(int sig_num)
{
    int status;
    if (fclose(bin_stream)) {
        perror("fclose failed");
    }
    status = ioctl(fd_semhu0_ept, RPMSG_DESTROY_EPT_IOCTL);
    if (status == -1) {
        printf("Unable to destroy fd_semhu0_ept endpoint correctly \n");
    }
    close(fd_semhu0_ept);
    if (munmap(map_base, mapped_size) == -1) {
        printf("Unable to unmap the mapped address region \n");
    }
    close(mem_fd);
    close(fd);
    printf("Closed opened files \n");
 }

void display_help(char *pgm_name)
{
    printf("Error: "
    "Files to program in OSPI1 NOR flash are missing\n");
    printf("Syntax:%s -l "
           "<file1_to_program_ospi1>, <ospi1_addr_to_program_file1>"
           " [-l <file2_to_program_ospi1>, <ospi1_addr_to_program_file2>]\n",
           pgm_name);
    printf("Note: OSPI1 NOR flash address range is 0x%x to 0x%x\n",
           OSPI1_BASE, (OSPI1_BASE + OSPI1_SIZE - 1));
}

int main(int argc, char **argv)
{
    uint32_t page_size, mapped_size, offset_in_page;
    uint32_t data[2];
    uint32_t rdata[2];
    void *virt_addr;
    int status, ret = 1, count = 0, f_count = 0, i = 0;
    long int file_size;
    int opt;

    if (argc < 3) {
        display_help(argv[0]);
        return ret;
    }

    while ((opt = getopt(argc, argv, ":l:")) != -1) {
        switch (opt) {
        case 'l':
            if (f_count >= NUM_IMG_LIST) {
                printf("Only %d images can be given for flashing at a time\n",
                NUM_IMG_LIST);
                display_help(argv[0]);
                return ret;
            }
            sprintf(ospi1_prm_arr[f_count].file_name, "%s", optarg);

            char *s_ptr;
            s_ptr = memchr(ospi1_prm_arr[f_count].file_name,
                           ',', MAX_PATH_LEN);
            if (!s_ptr) {
                printf("Delimiter ',' missing in the -l value\n");
                display_help(argv[0]);
                return ret;
            }
            *s_ptr++ = '\0';

            ospi1_prm_arr[f_count].file_addr = strtoll(s_ptr, NULL, 16);
            if ((ospi1_prm_arr[f_count].file_addr == LONG_MAX) ||
               (ospi1_prm_arr[f_count].file_addr == LONG_MIN)) {
                perror("strtoll failed: address given in -l"
                       " option is incorrect");
                display_help(argv[0]);
                return ret;
            }

            if (!((ospi1_prm_arr[f_count].file_addr >= OSPI1_BASE) &&
                 (ospi1_prm_arr[f_count].file_addr <
                                 (OSPI1_BASE + OSPI1_SIZE)))) {
                printf("The address given in -l option should be within"
                       " [0x%x, 0x%x]\n",
                       OSPI1_BASE, (OSPI1_BASE + OSPI1_SIZE - 1));
                display_help(argv[0]);
                return ret;
            }
            printf("The File [%s] Flash Address [0x%llx]\n",
                   ospi1_prm_arr[f_count].file_name,
                   ospi1_prm_arr[f_count].file_addr);
            f_count++;
            break;

        case ':':
            printf("The option -l requires an argument %c\n", optopt);
            display_help(argv[0]);
            return ret;

        case '?':
            printf("Unrecognised option: -%c\n", optopt);
            display_help(argv[0]);
            return ret;

        default:
            printf("Unrecognised option: -%c\n", optopt);
            display_help(argv[0]);
            return ret;
        }
    }

    fd = open("/dev/rpmsg_ctrl0", O_RDWR);
    if (fd == -1) {
        perror("open:/dev/rpmsg_ctrl0");
        printf("Please use the kernel which enabled MHU module\n");
        return ret;
    }

    status = ioctl(fd, RPMSG_CREATE_EPT_IOCTL, &semhu0_eptinfo);
    if (status == -1) {
        perror("ioctl:create rpmsg");
        close(fd);
        return ret;
    }

    /* Create Endpoint to receive/send MHU data */
    fd_semhu0_ept = open("/dev/rpmsg0", O_RDWR);
    if (fd_semhu0_ept == -1) {
        perror("open:/dev/rpmsg0");
        close(fd);
        return ret;
    }

    /*Register signal handler */
    signal(SIGINT, sigintHandler);

    /* Open /dev/mem file and map MHU_SERVICES_DATA_LOC
     * to virtual address to get MHU services from SE */
    mem_fd = open("/dev/mem", (O_RDWR | O_SYNC), 0666);
    if (mem_fd == -1) {
        perror("open:/dev/mem");
        status = ioctl(fd_semhu0_ept, RPMSG_DESTROY_EPT_IOCTL);
        if (status == -1) {
            perror("ioctl:destroy rpmsg");
        }
        close(fd_semhu0_ept);
        close(fd);
        return ret;
    }
    page_size = getpagesize();
    /* Map two pages as services structure can go beyond the size
     * of the page. */
    mapped_size = page_size * 2;

    map_base = mmap(NULL,
                    mapped_size,
                    (PROT_READ | PROT_WRITE),
                    (MAP_SHARED),
                    mem_fd,
                    MHU_SERVICES_DATA_LOC & ~(off_t)(page_size - 1));
    if (map_base == MAP_FAILED) {
        perror("mmap");
        status = ioctl(fd_semhu0_ept, RPMSG_DESTROY_EPT_IOCTL);
        if (status == -1) {
            perror("ioctl:destroy rpmsg");
        }
        close(mem_fd);
        close(fd_semhu0_ept);
        close(fd);
        return ret;
    }
    offset_in_page = (uint32_t) MHU_SERVICES_DATA_LOC & (page_size - 1);

    virt_addr = (char *)map_base + offset_in_page;

    /* message to HE */
    while (count < f_count) {
        /* Subtract 0x0827F000 at HE to get actual ospi1 flash address */
        data[0] = ospi1_prm_arr[count].file_addr + MHU_SERVICES_DATA_LOC;
        data[1] = page_size;

        bin_stream = fopen(ospi1_prm_arr[count].file_name, "r");
        if (!bin_stream) {
            perror("fopen failed");
            goto close;
        }
        /* get the file size */
        status = fseek(bin_stream, 0, SEEK_END);
        if (status < 0) {
            perror("fseek failed");
            goto cleanup;
        }
        file_size = ftell(bin_stream);
        if (file_size < 0) {
            perror("ftell failed");
            goto cleanup;
        }
        ospi1_prm_arr[count].file_len = file_size;
        if ((file_size + ospi1_prm_arr[count].file_addr) >=
            (OSPI1_BASE + OSPI1_SIZE)) {
            printf("The file %s of size %ld does not fit within"
                   " 0x%llx - 0x%x\n", ospi1_prm_arr[count].file_name,
                   file_size, ospi1_prm_arr[count].file_addr,
                   (OSPI1_BASE + OSPI1_SIZE - 1));
            goto cleanup;
        }

        printf("\nPreparing OSPI1 NOR-Flash for %ld Bytes.....\n", file_size);

        status = fseek(bin_stream, 0, SEEK_SET);
        if (status < 0) {
            perror("unable to reset the position");
            goto cleanup;
        }
        for (i = 0 ; i < file_size ;) {
            /* Clear the Memory */
            memset(virt_addr, 0xFF, data[1]);
            status = fread(virt_addr, 1, data[1], bin_stream);
            __asm__ __volatile__("dsb":::"memory");

            if (ferror(bin_stream)) {
                perror("Read less data due to error");
                goto cleanup;
            }
            if (feof(bin_stream)) {
                /* set last remaining bytes of data */
                data[1] = status;
            }
            clearerr(bin_stream);

            status = write(fd_semhu0_ept, &data, sizeof(data));
            if (status < 0) {
                perror("Unable to send MHU data");
                goto cleanup;
            }

            printf("\rFlashing    ======   [%3.0f]%%",
                  ((float)i / (float)file_size) * 100);
            fflush(stdout);
            status = read(fd_semhu0_ept, &rdata[0], sizeof(rdata[0]));
            if (status == -1 && errno == EAGAIN) {
                printf("No data available \n");
            }

            status = read(fd_semhu0_ept, &rdata[1], sizeof(rdata[1]));
            if (status == -1 && errno == EAGAIN) {
                    printf("No data available \n");
            }

            i = i + page_size;
        }
        count++;
    }
    ret = 0;
cleanup:
    if (fclose(bin_stream)) {
        perror("fclose failed");
    }
close:
    status = ioctl(fd_semhu0_ept, RPMSG_DESTROY_EPT_IOCTL);
    if (status == -1) {
        perror("ioctl:destroy rpmsg");
    }
    close(fd_semhu0_ept);
    if (munmap(map_base, mapped_size) == -1) {
        perror("munmap");
    }
    close(mem_fd);
    close(fd);

    printf("\nExiting Flash Programmer....\n");
    return ret;
}
