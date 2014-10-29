# Protocol Documentation
<a name="top"/>

## Table of Contents
* [envelope.proto](#envelope.proto)
 * [Envelope](#events.Envelope)
 * [Envelope.EventType](#events.Envelope.EventType)
* [error.proto](#error.proto)
 * [Error](#events.Error)
* [heartbeat.proto](#heartbeat.proto)
 * [Heartbeat](#events.Heartbeat)
* [http.proto](#http.proto)
 * [HttpStart](#events.HttpStart)
 * [HttpStartStop](#events.HttpStartStop)
 * [HttpStop](#events.HttpStop)
 * [UUID](#events.UUID)
 * [Method](#events.Method)
 * [PeerType](#events.PeerType)
* [log.proto](#log.proto)
 * [LogMessage](#events.LogMessage)
 * [LogMessage.MessageType](#events.LogMessage.MessageType)
* [metric.proto](#metric.proto)
 * [CounterEvent](#events.CounterEvent)
 * [ValueMetric](#events.ValueMetric)
* [Scalar Value Types](#scalar-value-types)

<a name="envelope.proto"/>
<p align="right"><a href="#top">Top</a></p>

## envelope.proto

<a name="events.Envelope"/>
### Envelope
Envelope wraps an Event and adds metadata.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| origin | string | required | Unique description of the origin of this event. |
| eventType | Envelope.EventType | required | Type of wrapped event. Only the optional field corresponding to the value of eventType should be set. |
| timestamp | int64 | optional | UNIX timestamp (in nanoseconds) event was wrapped in this Envelope. |
| heartbeat | Heartbeat | optional |  |
| httpStart | HttpStart | optional |  |
| httpStop | HttpStop | optional |  |
| httpStartStop | HttpStartStop | optional |  |
| logMessage | LogMessage | optional |  |
| valueMetric | ValueMetric | optional |  |
| counterEvent | CounterEvent | optional |  |
| error | Error | optional |  |


<a name="events.Envelope.EventType"/>
### Envelope.EventType
Type of the wrapped event.

| Name | Number | Description |
| ---- | ------ | ----------- |
| Heartbeat | 1 |  |
| HttpStart | 2 |  |
| HttpStop | 3 |  |
| HttpStartStop | 4 |  |
| LogMessage | 5 |  |
| ValueMetric | 6 |  |
| CounterEvent | 7 |  |
| Error | 8 |  |

<a name="error.proto"/>
<p align="right"><a href="#top">Top</a></p>

## error.proto

<a name="events.Error"/>
### Error
An Error event represents an error in the originating process.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| source | string | required | Source of the error. This may or may not be the same as the Origin in the envelope. |
| code | int32 | required | Numeric error code. This is provided for programmatic responses to the error. |
| message | string | required | Error description (preferably human-readable). |


<a name="heartbeat.proto"/>
<p align="right"><a href="#top">Top</a></p>

## heartbeat.proto

<a name="events.Heartbeat"/>
### Heartbeat
A Heartbeat event both indicates liveness of the emitter, and communicates counts of events processed.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| sentCount | uint64 | required | Number of events sent by this emitter. |
| receivedCount | uint64 | required | Number of events received by this emitter from the host process. |
| errorCount | uint64 | required | Number of errors encountered while sending. |


<a name="http.proto"/>
<p align="right"><a href="#top">Top</a></p>

## http.proto

<a name="events.HttpStart"/>
### HttpStart
An HttpStart event is emitted when a client sends a request (or immediately when a server receives the request).

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| timestamp | int64 | required | UNIX timestamp (in nanoseconds) when the request was sent (by a client) or received (by a server). |
| requestId | UUID | required | ID for tracking lifecycle of request. |
| peerType | PeerType | required | Role of the emitting process in the request cycle. |
| method | Method | required | Method of the request. |
| uri | string | required | Destination of the request. |
| remoteAddress | string | required | Remote address of the request. (For a server, this should be the origin of the request.) |
| userAgent | string | required | Contents of the UserAgent header on the request. |
| parentRequestId | UUID | optional | If this request was made in order to service an incoming request, this field should track the ID of the parent. |
| applicationId | UUID | optional | If this request was made in relation to an appliciation, this field should track that application's ID. |
| instanceIndex | int32 | optional | Index of the application instance. |
| instanceId | string | optional | ID of the application instance. |

<a name="events.HttpStartStop"/>
### HttpStartStop
An HttpStartStop event represents the whole lifecycle of an HTTP request.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| startTimestamp | int64 | required | UNIX timestamp (in nanoseconds) when the request was sent (by a client) or received (by a server). |
| stopTimestamp | int64 | required | UNIX timestamp (in nanoseconds) when the request was received. |
| requestId | UUID | required | ID for tracking lifecycle of request. Should match requestId of a HttpStart event. |
| peerType | PeerType | required | Role of the emitting process in the request cycle. |
| method | Method | required | Method of the request. |
| uri | string | required | Destination of the request. |
| remoteAddress | string | required | Remote address of the request. (For a server, this should be the origin of the request.) |
| userAgent | string | required | Contents of the UserAgent header on the request. |
| statusCode | int32 | required | Status code returned with the response to the request. |
| contentLength | int64 | required | Length of response (bytes). |
| parentRequestId | UUID | optional | If this request was made in order to service an incoming request, this field should track the ID of the parent. |
| applicationId | UUID | optional | If this request was made in relation to an appliciation, this field should track that application's ID. |
| instanceIndex | int32 | optional | Index of the application instance. |
| instanceId | string | optional | ID of the application instance. |

<a name="events.HttpStop"/>
### HttpStop
An HttpStop event is emitted when a client receives a response to its request (or when a server completes its handling and returns a response).

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| timestamp | int64 | required | UNIX timestamp (in nanoseconds) when the request was received. |
| uri | string | required | URI of request. |
| requestId | UUID | required | ID for tracking lifecycle of request. Should match requestId of a HttpStart event. |
| peerType | PeerType | required | Role of the emitting process in the request cycle. |
| statusCode | int32 | required | Status code returned with the response to the request. |
| contentLength | int64 | required | Length of response (bytes). |
| applicationId | UUID | optional | If this request was made in relation to an appliciation, this field should track that application's ID. |

<a name="events.UUID"/>
### UUID
Type representing a 128-bit UUID.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| low | uint64 | required |  |
| high | uint64 | required |  |


<a name="events.Method"/>
### Method
HTTP method.

| Name | Number | Description |
| ---- | ------ | ----------- |
| GET | 1 |  |
| POST | 2 |  |
| PUT | 3 |  |
| DELETE | 4 |  |
| HEAD | 5 |  |

<a name="events.PeerType"/>
### PeerType
Type of peer handling request.

| Name | Number | Description |
| ---- | ------ | ----------- |
| Client | 1 | Request is made by this process. |
| Server | 2 | Request is received by this process. |

<a name="log.proto"/>
<p align="right"><a href="#top">Top</a></p>

## log.proto

<a name="events.LogMessage"/>
### LogMessage
A LogMessage contains a &quot;log line&quot; and associated metadata.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| message | bytes | required | Bytes of the log message. (Note that it is not required to be a single line.) |
| message_type | LogMessage.MessageType | required | Type of the message (OUT or ERR). |
| timestamp | int64 | required | UNIX timestamp (in nanoseconds) when the log was written. |
| app_id | string | optional | Application that emitted the message (or to which the application is related). |
| source_type | string | optional | Source of the message. For Cloud Foundry, this can be &quot;APP&quot;, &quot;RTR&quot;, &quot;DEA&quot;, &quot;STG&quot;, etc. |
| source_instance | string | optional | Instance that emitted the message. |


<a name="events.LogMessage.MessageType"/>
### LogMessage.MessageType
MessageType stores the destination of the message (corresponding to STDOUT or STDERR).

| Name | Number | Description |
| ---- | ------ | ----------- |
| OUT | 1 |  |
| ERR | 2 |  |

<a name="metric.proto"/>
<p align="right"><a href="#top">Top</a></p>

## metric.proto

<a name="events.CounterEvent"/>
### CounterEvent
A CounterEvent represents the increment of a counter. It contains only the change in the value; it is the responsibility of downstream consumers to maintain the value of the counter.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | string | required | Name of the counter. Must be consistent for downstream consumers to associate events semantically. |
| delta | uint64 | required | Amount by which to increment the counter. |

<a name="events.ValueMetric"/>
### ValueMetric
A ValueMetric indicates the value of a metric at an instant in time.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | string | required | Name of the metric. Must be consistent for downstream consumers to associate events semantically. |
| value | double | required | Value at the time of event emission. |
| unit | string | required | Unit of the metric. Please see http://metrics20.org/spec/#units for ideas; SI units/prefixes are recommended where applicable. Should be consistent for the life of the metric (consumers are expected to report, but not interpret, prefixes). |



<a name="scalar-value-types"/>
## Scalar Value Types

| .proto Type | Notes | C++ Type | Java Type | Python Type |
| ----------- | ----- | -------- | --------- | ----------- |
| double |  | double | double | float |
| float |  | float | float | float |
| int32 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint32 instead. | int32 | int | int |
| int64 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead. | int64 | long | int/long |
| uint32 | Uses variable-length encoding. | uint32 | int | int/long |
| uint64 | Uses variable-length encoding. | uint64 | long | int/long |
| sint32 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int32s. | int32 | int | int |
| sint64 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int64s. | int64 | long | int/long |
| fixed32 | Always four bytes. More efficient than uint32 if values are often greater than 2^28. | uint32 | int | int |
| fixed64 | Always eight bytes. More efficient than uint64 if values are often greater than 2^56. | uint64 | long | int/long |
| sfixed32 | Always four bytes. | int32 | int | int |
| sfixed64 | Always eight bytes. | int64 | long | int/long |
| bool |  | bool | boolean | boolean |
| string | A string must always contain UTF-8 encoded or 7-bit ASCII text. | string | String | str/unicode |
| bytes | May contain any arbitrary sequence of bytes. | string | ByteString | str |
