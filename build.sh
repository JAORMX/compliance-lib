#!/bin/bash

go build --buildmode=c-shared -o libmachineconfigcheck.so main.go
gcc -o docheck docheck.c ./libmachineconfigcheck.so
