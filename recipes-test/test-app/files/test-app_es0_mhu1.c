/*
 *
 * Copyright (c) 2019, Arm Limited and Contributors. All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Description:
 * File containing various unit tests for the Corstone-700 test platform.
 * The contents of this file utilize handling of the transmitted commands
 * on respectively the ES and SE sides.
 * Test verification is not performed by this program. Instead, all test
 * variables are printed to the console, which will then be used to externally
 * verify the test.
 * Tests may be selected by providing the test index as an argument of this
 * program.
*/

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

enum test_apps
{
	INVALID,
	ES_RESET,
	ES_MHU,
	NUM_TEST_APPS
};

enum es_command
{
	ES_NONE,
	/* Send the value to the PE, the PE will then increment the value
	 and send it back to here (Host) */
	ES_INC_RETURN,
	/* Send the value to the ES */
};

/* Macros for executing API commands, which will fail the test if the
	command fails. */
#define TRY_OPEN(FD, DEVICE, ...)                                 \
	int FD = open(DEVICE, ##__VA_ARGS__);                         \
	if (FD == -1)                                                 \
	{                                                             \
		printf("Could not open " DEVICE " device, exiting...\n"); \
		return 1;                                                 \
	}

#define TRY_CLOSE(FD, ...)                                                      \
	FD = close(FD, ##__VA_ARGS__);                                              \
	if (FD == -1)                                                               \
	{                                                                           \
		printf("Could not close file descriptor " #FD " device, exiting...\n"); \
		return 1;                                                               \
	}

#define TRY_IOCTL(STATUS, FD, ...)                                                        \
	STATUS = ioctl(FD, ##__VA_ARGS__);                                                    \
	if (STATUS != 0)                                                                      \
	{                                                                                     \
		printf("ioctl on file descriptor '" #FD "' failed with status code: %d", STATUS); \
		return 1;                                                                         \
	}

/**
 * struct rpmsg_endpoint_info - endpoint info representation
 * @name: name of service
 * @src: local address
 * @dst: destination address
 */
struct rpmsg_endpoint_info
{
	char name[32];
	u_int32_t src;
	u_int32_t dst;
};

#define RPMSG_CREATE_EPT_IOCTL _IOW(0xb5, 0x1, struct rpmsg_endpoint_info)
#define RPMSG_DESTROY_EPT_IOCTL _IO(0xb5, 0x2)

#define EXTSYS_CPU_WAIT_DISABLE 0x0

/* MHU test command encoding */
#define BITMASK(x) ((unsigned)-1 >> ((sizeof(int) * CHAR_BIT) - x))
#define CMD_WIDTH 4
#define COMMAND(message) (message & BITMASK(CMD_WIDTH))
#define VALUE(message) ((unsigned)message >> CMD_WIDTH)
#define ENCODE(command, value) ((command & BITMASK(CMD_WIDTH)) | (value << CMD_WIDTH))

/* Desassert the reset signal of the external system#0 harness */
int es_reset_test()
{
	int status;
	/* Bring external system out of reset */
	TRY_OPEN(fd_sdk, "/dev/extsys_ctrl", O_RDWR);
	TRY_IOCTL(status, fd_sdk, EXTSYS_CPU_WAIT_DISABLE, 0);
	TRY_CLOSE(fd_sdk);
	return 0;
}

/* Test MHU connection between HOST <=> ES0 MHU 1 */
int es_mhu_test()
{
	int status;
	int message;
	const int value = 0xABCDEF;

	struct rpmsg_endpoint_info es0mhu1_eptinfo = {"es0mhu1", 0XFFFFFFFF, 0xFFFFFFFF};

	TRY_OPEN(fd, "/dev/rpmsg_ctrl0", O_RDWR);
	/* Create endpoint interfaces for each MHU */
	TRY_IOCTL(status, fd, RPMSG_CREATE_EPT_IOCTL, &es0mhu1_eptinfo); /* /dev/rpmsg2 is created */

	/* create endpoints for each mhu */
	TRY_OPEN(fd_es0mhu1_ept, "/dev/rpmsg1", O_RDWR);
	int epts[1];
	epts[0] = fd_es0mhu1_ept;

	/* Bring external system out of reset */
	es_reset_test();
	/* Await es system boot. Currently there is no signalling mechanism for
	 * this, so revert to sleeping */
	sleep(1);
	/* External system test */
	for (int i = 0; i < 1; i++)
	{
		int ept = epts[i];
		char *name;
		/* ========== ES < = > HOST TESTS ========== */
		/* Make ES echo the value back to host with the incremented value */
		message = ENCODE(ES_INC_RETURN, value);
		printf("Sending message value 0x%x \n", message);
		write(ept, &message, sizeof(message));
		/* External system cannot execute the test command within an interrupt
		 * 		handler. Since no command buffering has been implemented on the ES, a
		 * 				sleep allows the ES to process a command before the host transmits
		 * 						subsequent commands.
		  */
		sleep(1);
		/* Read the data transmitted by the previous command */
		read(ept, &message, sizeof(message));
		printf("Received %x from %s\n", message,
		ept == fd_es0mhu1_ept ? "es0mhu1" : "es0mhu0");
		sleep(1);
	}
	/* destroy endpoints */
	TRY_IOCTL(status, fd_es0mhu1_ept, RPMSG_DESTROY_EPT_IOCTL);
	TRY_CLOSE(fd_es0mhu1_ept);
	TRY_CLOSE(fd);
	return 0;
}


int main(int argc, char *argv[])
{
	if (argc != 2)
	{
		printf("Usage: ./test-app <test app number>\n");
		printf("  test app number : 1 for External System reset.\n");
		printf("    This test resets the External System\n");
		printf("  test app number : 2 for External System MHU 1.\n");

		return 1;
	}

	switch (atoi(argv[1]))
	{
	default:
	case INVALID:
		printf("Invalid test app specified\n");
		printf("%d test apps are available\n", NUM_TEST_APPS - 1);
		break;
	case ES_RESET:
		return es_reset_test();
	case ES_MHU:
		return es_mhu_test();
	}

	return 0;
}
