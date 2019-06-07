#!/bin/bash

make build
gcc -o build/docheck docheck.c ./build/libopenshiftcompliance.so -Ibuild
