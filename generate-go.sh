#!/bin/bash

dir_resolve()
{
cd "$1" 2>/dev/null || return $?  # cd to desired directory; if fail, quell any error messages but return exit status
echo "`pwd -P`" # output full, link-resolved path
}

set -e

TARGET=`dir_resolve $1`
if [ -z "$TARGET" ]; then
    echo 'USAGE: `generate-go.sh TARGET_PATH`'
    echo ''
    echo 'TARGET_PATH is where you would like the control and events packages to be generated.'
    exit 1
fi

go get github.com/gogo/protobuf/{proto,protoc-gen-gogo,gogoproto}

rm -rf generate-go-tmp
mkdir -p generate-go-tmp/events generate-go-tmp/control

mkdir -p $TARGET/events
cp events/*.proto generate-go-tmp/events/
for i in $(ls -1 events/*.proto); do
    cat go/go_preamble.proto $i > generate-go-tmp/events/$(basename $i)
done

mkdir -p $TARGET/control
cp control/*.proto generate-go-tmp/control/
for i in $(ls -1 control/*.proto); do
    cat go/go_preamble.proto $i > generate-go-tmp/control/$(basename $i)
done

pushd generate-go-tmp/events
protoc --plugin=$(which protoc-gen-gogo) --gogo_out=$TARGET/events --proto_path=$GOPATH/src:$GOPATH/src/github.com/gogo/protobuf/protobuf:. *.proto
popd

pushd generate-go-tmp/control
protoc --plugin=$(which protoc-gen-gogo) --gogo_out=$TARGET/control --proto_path=$GOPATH/src:$GOPATH/src/github.com/gogo/protobuf/protobuf:. *.proto
popd
