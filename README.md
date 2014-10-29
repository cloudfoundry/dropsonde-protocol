# dropsonde-protocol

Protocol buffer protocol for dropsonde

## Event types
Please see the [events README](events/README.md).

## Libraries using this protocol

* [Dropsonde](https://github.com/cloudfoundry/dropsonde) is a Go library for applications that wish to emit messages in this format.
* [NOAA](https://github.com/cloudfoundry/noaa) is a library (also in Go) for applications that wish to consume messages from the Cloud Foundry [metric system](https://github.com/cloudfoundry/loggregator). 

## Generating code

### Go
1. Install [protobuf](https://github.com/google/protobuf) 
   ```
   brew install protobuf
   ```
1. Generate go code
   ```
   ./generate-go.sh TARGET_PATH
   ```

### Other languages

For C++, Java and Python, Google provides [tutorials](https://developers.google.com/protocol-buffers/docs/tutorials).

Please see [this list](https://github.com/google/protobuf/wiki/Third-Party-Add-ons#Programming_Languages) for working with protocol buffers in other languages.

### Event documentation
The events README is auto-generated with [protoc-gen-doc](https://github.com/estan/protoc-gen-doc). After installing the tool, run
```
cd events
protoc --doc_out=markdown,README.md:. *.proto
```