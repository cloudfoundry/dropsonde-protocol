#!/bin/bash

set -e

TARGET=$1
if [ -z "$TARGET" ]; then
    echo 'USAGE: `generate-go.sh TARGET_PATH`'
    echo ''
    echo 'TARGET_PATH is where you would like the *.go files to be generated.'
    exit 1
fi

go install code.google.com/p/gogoprotobuf/protoc-gen-gogo

protoc --plugin=$GOPATH/bin/protoc-gen-gogo --gogo_out=$TARGET events/*.proto