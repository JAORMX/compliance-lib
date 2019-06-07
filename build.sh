#!/bin/bash

go build --buildmode=c-shared -o libmachineconfigcheck.so lib.go
gcc -o docheck docheck.c ./libmachineconfigcheck.so
