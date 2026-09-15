#!/usr/bin/env python3
#
# gen_totp.py
#
# Command-line program to generate TOTP codes using the pyotp library.
#
# Modify the secrets variable below, which is a list of dictionaries.
# 'name' is an arbitrary string which acts as a label. 'secret' is the
# TOTP secret in base32.
#
# Example of running the program:
#   $ gen_totp.py
#   1: Provider:Name
#   2: Provider2:Name2
#   Choose an item: 1
#   976330
#
# Security note: as this file contains your TOTP secret, suggested
# usage is to copy to ~/.local/bin/ and chmod 700.


# To convert from array of signed integers to base-32:
#
# >>> import base64
# >>> secret = [-27,21,-23,32,-32,-63,60,37,28,123]
# >>> base64.b32encode(bytes((x + 256) & 255 for x in secret))
# b'4UK6SIHAYE6CKHD3'

secrets = [
        {'name': 'Provider:Name', 'secret': '234567ABCDEFGHIJKLMNOPQRSTUVWXYZ'},
        {'name': 'Provider2:Name2', 'secret': '234567ABCDEFGHIJ'},
        ];

def print_names():
    names = [ sub['name'] for sub in secrets ];
    for i, n in enumerate(names, 1):
        print('{0}: {1}'.format(i, n));

def choose_secret():
    while True:
        try:
            print_names();
            idx = int(input("Choose an item: "));
            if validate_idx(idx):
                return idx;
        except ValueError:
            print('Invalid choice.');
            continue;

def validate_idx(idx):
    if idx >= 1 and idx <= len(secrets):
        return True;
    return False;

def print_totp_code(idx):
    import pyotp
    totop = pyotp.TOTP(secrets[idx-1]['secret']);
    print(totop.now())

if __name__ == '__main__':
    import sys;
    idx = 0;
    try:
        args = sys.argv[1:];
        if len(args) == 1:
            idx = int(args[0]);
            if not validate_idx(idx):
                idx = 0;
    except ValueError:
        print('Invalid argument.');

    if idx == 0:
        idx = choose_secret();
    print_totp_code(idx);
