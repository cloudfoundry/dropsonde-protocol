# Protocol Documentation
<a name="top"/>

## Table of Contents
* [controlmessage.proto](#controlmessage.proto)
 * [ControlMessage](#control.ControlMessage)
 * [ControlMessage.ControlType](#control.ControlMessage.ControlType)
* [heartbeatrequest.proto](#heartbeatrequest.proto)
 * [HeartbeatRequest](#control.HeartbeatRequest)
* [uuid.proto](#uuid.proto)
 * [UUID](#control.UUID)
* [Scalar Value Types](#scalar-value-types)

<a name="controlmessage.proto"/>
<p align="right"><a href="#top">Top</a></p>

## controlmessage.proto

<a name="control.ControlMessage"/>
### ControlMessage
ControlMessage wraps a control command and adds metadata.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| origin | string | required | Unique description of the origin of this event. |
| identifier | UUID | required | A unique identifier for this control |
| timestamp | int64 | required | UNIX timestamp (in nanoseconds) event was wrapped in this ControlMessage. |
| controlType | ControlMessage.ControlType | required | Type of wrapped control. Only the optional field corresponding to the value of ControlType should be set. |
| heartbeatRequest | HeartbeatRequest | optional |  |


<a name="control.ControlMessage.ControlType"/>
### ControlMessage.ControlType
Type of the wrapped control.

| Name | Number | Description |
| ---- | ------ | ----------- |
| HeartbeatRequest | 1 |  |

<a name="heartbeatrequest.proto"/>
<p align="right"><a href="#top">Top</a></p>

## heartbeatrequest.proto

<a name="control.HeartbeatRequest"/>
### HeartbeatRequest
A HeartbeatRequest command elicits a heartbeat from a component or app. When a HeartbeatRequest is received, a Heartbeat event MUST be returned with controlMessageIdentifier set to the UUID received in the request.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |


<a name="uuid.proto"/>
<p align="right"><a href="#top">Top</a></p>

## uuid.proto

<a name="control.UUID"/>
### UUID
Type representing a 128-bit UUID.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| low | uint64 | required |  |
| high | uint64 | required |  |



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
