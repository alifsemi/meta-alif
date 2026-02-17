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
#include <errno.h>
#include <stdbool.h>

#define READ_BUFFER_SIZE 256

/* Write test text to the specified file.
 * Returns true on success, false on failure.
 */
static bool write_test_file(const char *filepath, const char *text) {
  FILE *fp = fopen(filepath, "w");
  if (!fp) {
    printf("Failed to open file %s for writing: %s\n", filepath, strerror(errno));
    return false;
  }

  size_t expected_len = strlen(text);
  int written = fprintf(fp, "%s", text);
  if (written < 0 || (size_t)written != expected_len) {
    int saved_errno = errno;
    fclose(fp);
    if (written < 0) {
      printf("Failed to write to file %s: %s\n", filepath, strerror(saved_errno));
    } else {
      printf("Incomplete write to file %s: wrote %d of %zu bytes\n", filepath, written, expected_len);
    }
    return false;
  }

  if (fclose(fp) != 0) {
    printf("Failed to close file %s after writing: %s\n", filepath, strerror(errno));
    return false;
  }

  return true;
}

/* Read and verify the contents of the specified file match expected text.
 * Returns true if content matches, false otherwise.
 */
static bool verify_test_file(const char *filepath, const char *expected_text) {
  FILE *fp = fopen(filepath, "r");
  if (!fp) {
    printf("Failed to open file %s for reading: %s\n", filepath, strerror(errno));
    return false;
  }

  size_t expected_len = strlen(expected_text);
  if (expected_len >= READ_BUFFER_SIZE) {
    fclose(fp);
    printf("Expected text too long (%zu bytes) for buffer size (%d bytes)\n",
           expected_len, READ_BUFFER_SIZE);
    return false;
  }

  char buffer[READ_BUFFER_SIZE];
  if (!fgets(buffer, sizeof(buffer), fp)) {
    int saved_errno = errno;
    if (ferror(fp)) {
      fclose(fp);
      printf("Failed to read from file %s: %s\n", filepath, strerror(saved_errno));
    } else {
      fclose(fp);
      printf("Failed to read from file %s: unexpected EOF\n", filepath);
    }
    return false;
  }

  bool matches = (strcmp(buffer, expected_text) == 0);

  if (fclose(fp) != 0) {
    printf("Warning: Failed to close file after reading: %s\n", strerror(errno));
  }

  if (matches) {
    printf("The text read from the file matches the written content. TEST OK!\n");
  } else {
    printf("The text read from the file does not match the written content. TEST FAIL!\n");
    printf("  Expected (%zu bytes): %s", strlen(expected_text), expected_text);
    printf("  Got (%zu bytes):      %s", strlen(buffer), buffer);
  }

  return matches;
}

int main(void) {
  /* This test will write text to a file in /var/volatile/testfile.txt.
     Then the test will read the file and compare content.
  */
  const char *test_file = "/var/volatile/testfile.txt";
  const char *test_text = "This is a test write to the filesystem.\n";

  printf("This test will write text to a file in %s.\n"
         "Then the test will read the file and compare content.\n\n",
         test_file);

  if (!write_test_file(test_file, test_text)) {
    return 1;
  }

  if (!verify_test_file(test_file, test_text)) {
    return 1;
  }

  return 0;
}
