#Copyright (c) 2020 - 2021 ALIF SEMICONDUCTOR
#
#All rights reserved.
#Redistribution and use in source and binary forms, with or without
#modification, are permitted provided that the following conditions are met:
#- Redistributions of source code must retain the above copyright
#  notice, this list of conditions and the following disclaimer.
#- Redistributions in binary form must reproduce the above copyright
#  notice, this list of conditions and the following disclaimer in the
#  documentation and/or other materials provided with the distribution.
#- Neither the name of ALIF SEMICONDUCTOR nor the names of its contributors
#  may be used to endorse or promote products derived from this software
#  without specific prior written permission.
#*
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#ARE DISCLAIMED. IN NO EVENT SHALL COPYRIGHT HOLDERS AND CONTRIBUTORS BE
#LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
#CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
#SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
#INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
#CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
#ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
#POSSIBILITY OF SUCH DAMAGE.
#---------------------------------------------------------------------------*/

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
