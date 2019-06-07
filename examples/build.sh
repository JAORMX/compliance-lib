#!/bin/bash
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

pushd "$SCRIPTPATH"/../ || exit

make build
gcc -o build/docheck examples/docheck.c build/libopenshiftcompliance.so -Ibuild || exit

popd || exit

echo "The binary ./build/docheck was built successfully"
