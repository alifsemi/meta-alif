# Copyright (C) 2022 Alif Semiconductor - All Rights Reserved.
# Use, distribution and modification of this code is permitted under the
# terms stated in the Alif Semiconductor Software License Agreement
#
# You should have received a copy of the Alif Semiconductor Software
# License Agreement with this file. If not, please write to:
# contact@alifsemi.com, or visit: https://alifsemi.com/license

# * @file     CSPI_AES128_ECB.py
# * @author   Manjunath Matti
# * @email    manjunath.matti@alifsemi.com
# * @version  V1.0.0
# * @date     08-October-2021
# * @brief    Python script to encrypt binary files for CSPI Hardware decryption.

import argparse
import binascii
import string
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad

def cmd_arguments():
    parse = argparse.ArgumentParser()
    parse.add_argument('-i',
                       type=str,
                       default='',
                       required=True,
                       help="Mention the name of the input file")
    parse.add_argument('-o',
                       type=str,
                       default='',
                       required=True,
                       help="Mention the name of the output file")
    parse.add_argument('-k',
                       type=str,
                       default='',
                       required=True,
                       help="128-bit Key for AES Encryption")
    parse.add_argument('-d',
                       type=int,
                       default=1,
                       required=True,
                       help="1 to Encrypt, 0 to Decrypt")
    args = parse.parse_args()
    return args.i, args.o, args.k, args.d
def encrypt_data(in_file,out_file,aes_key,direction):
    try:
        fd_in = open(in_file, 'rb')
    except Exception:
        print(f"Error in opening {in_file}")
        return -1
    try:
        fd_out = open(out_file, 'wb')
    except Exception:
        print(f"Error in opening {out_file}")
        return -1
    print("Key used for Ciphering")
    key = (bytes(aes_key,'utf-8'))
    print(key)
    cipher = AES.new(key, AES.MODE_ECB)
    try:
        read_bytes = fd_in.read(16)
        while len(read_bytes) > 0:
            if direction == 1:
                if len(read_bytes) % 16 != 0:
                    read_bytes = pad(read_bytes, AES.block_size)
                swap_read_bytes = bytearray(read_bytes)
                swap_read_bytes.reverse()
                ciphered_bytes = cipher.encrypt(bytes(swap_read_bytes))
                swap_data = bytearray (ciphered_bytes)
                swap_data.reverse()
                fd_out.write(swap_data)
            elif direction == 0:
                swap_cipher_bytes = bytearray(read_bytes)
                swap_cipher_bytes.reverse()
                deciphered_bytes = cipher.decrypt(bytes(swap_cipher_bytes))
                swap_data = bytearray(deciphered_bytes)
                swap_data.reverse()
                fd_out.write(swap_data)
            read_bytes = fd_in.read(16)
    except Exception as error:
        print(error)
        return -1
    fd_in.close()
    fd_out.close()
    return 0
if __name__ == '__main__':
    in_file, out_file, aes_key, direction = cmd_arguments()
    check = encrypt_data(in_file, out_file, aes_key, direction)
    if check == -1:
        print("Failed")
        quit()
    print("Success")
