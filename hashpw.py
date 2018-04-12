#!/usr/bin/env python3


if __name__ == '__main__':
    import activate
    activate.activate()

from sys import stdin

from pw import hashpw


if __name__ == '__main__':
    print(repr(hashpw(input("Password: "))))
