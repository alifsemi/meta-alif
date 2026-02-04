/* Copyright (C) 2026 Alif Semiconductor - All Rights Reserved.
 * Use, distribution and modification of this code is permitted under the
 * terms stated in the Alif Semiconductor Software License Agreement
 *
 * You should have received a copy of the Alif Semiconductor Software
 * License Agreement with this file. If not, please write to:
 * contact@alifsemi.com, or visit: https://alifsemi.com/license
 *
 */

#include <stdio.h>
#include <string.h>

int main() {
  /* This test will write text to a file in /var/volatile/testfile.txt.
     Then the test will read the file and compare content.
  */
  const char *test_file = "/var/volatile/testfile.txt";
  const char *test_text = "This is a test write to the filesystem.\n";
  printf("This test will write text to a file in %s.\nThen the test will read "
         "the file and compare content.\n\n",
         test_file);
  FILE *fp = fopen(test_file, "w+");
  if (fp) {
    fprintf(fp, "%s", test_text);
    fflush(fp);
    fseek(fp, 0, SEEK_SET);

    char buffer[128];
    if (fgets(buffer, sizeof(buffer), fp)) {
      // printf("Read text %s from file %s", buffer, test_file);
      if (strcmp(buffer, test_text) == 0) {
        printf("The text read from the file matches the written content. TEST OK!\n");
        fclose(fp);
        return 0;
      } else {
        printf("The text read from the file does not match the written content. TEST FAIL!\n");
        fclose(fp);
        return 1;
      }
    } else {
      printf("Failed to read from file.\n");
      fclose(fp);
      return 1;
    }
  } else {
    printf("Failed to open file /var/volatile/testfile.txt for writing.\n");
    return 1;
  }
}
