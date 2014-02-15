snapshot
###############################################################################

Dart
===============================================================================
snapshot.h
snapshot.cc

IsMessageSnapshot
IsScriptSnapshot
IsFullSnapshot

起点
SetupFromBuffer()

test
  // Write snapshot with object content.
  uint8_t* buffer;
  MessageWriter writer(&buffer, &zone_allocator);
  const Smi& smi = Smi::Handle(Smi::New(124));
  writer.WriteMessage(smi);
  intptr_t buffer_len = writer.BytesWritten();


GetDeserializedDartMessage
dart_function
result = Dart_Infoke(lib, NewString(dart_function

 // Serialize the list into a message.
 uint8_t* buffer;
 MessageWriter writer(&buffer, &zone_allocator);
 const Object& list = Object::Handle(Api::UnwrapHandle(result));
 writer.WriteMessage(list);
 intptr_t buffer_len = writer.BytesWritten();

起点は以下の3つ
MessageWriter
ScriptSnapshotWriter
FullSnapshotWriter

dart_api_impl.cc
  Dart_CreateSnapshot(buffer, size)
  Dart_CreateScriptSnapshot(buffer, size)

include/dart_api.h
  Dart_ToString(object)
  Dart_NewPersistentHandle(object)
  Dart_DeletePersistentHandle(object)

  Dart_NewWeakPersistentHandle(object, peer, callback)

  Dart_CObject


gen_snapshot
  --snapshot=
  --script_snapshot=
  --package_root=
  --url_mapping=
  --url-mapping=

snapshot.mk
OBJS := \
        $(obj).target/$(TARGET)/runtime/bin/gen_snapshot.o \
        $(obj).target/$(TARGET)/runtime/bin/builtin.o \
        $(obj).target/$(TARGET)/gen/builtin_gen.o \
        $(obj).target/$(TARGET)/gen/crypto_gen.o \
        $(obj).target/$(TARGET)/gen/io_gen.o \
        $(obj).target/$(TARGET)/gen/io_patch_gen.o \
        $(obj).target/$(TARGET)/gen/json_gen.o \
        $(obj).target/$(TARGET)/gen/uri_gen.o \
        $(obj).target/$(TARGET)/gen/utf_gen.o

gen_snapshot --script_snapshot=test.dart --snapshot=./test.ss
これでsnapshotは作れるけど。

gen_snapshot --snapshot=./test1.ss test1.dart
gen_snapshot --snapshot=./test2.ss test2.dart

上記で、test1.ssとtest2.ssは異なる。
でも、dart --use_script_snapshot=./test1.ss test1.dart だと動かない。








改造のポイント
DART_EXPORT bool Dart_PostIntArray(Dart_Port port_id,
intptr_t len,
intptr_t* data) {
uint8_t* buffer = NULL;
ApiMessageWriter writer(&buffer, &allocator);
writer.WriteMessage(len, data);

// Post the message at the given port.
return PortMap::PostMessage(new Message(
port_id, Message::kIllegalPort, buffer, writer.BytesWritten(),
Message::kNormalPriority));
}


DART_EXPORT bool Dart_PostCObject(Dart_Port port_id, Dart_CObject* message) {
uint8_t* buffer = NULL;
ApiMessageWriter writer(&buffer, allocator);
writer.WriteCMessage(message);

// Post the message at the given port.
return PortMap::PostMessage(new Message(
port_id, Message::kIllegalPort, buffer, writer.BytesWritten(),
Message::kNormalPriority));
}


DART_EXPORT bool Dart_Post(Dart_Port port_id, Dart_Handle handle) {
Isolate* isolate = Isolate::Current();
CHECK_ISOLATE(isolate);
DARTSCOPE_NOCHECKS(isolate);
const Object& object = Object::Handle(isolate, Api::UnwrapHandle(handle));
uint8_t* data = NULL;
MessageWriter writer(&data, &allocator);
writer.WriteMessage(object);
intptr_t len = writer.BytesWritten();
return PortMap::PostMessage(new Message(
port_id, Message::kIllegalPort, data, len, Message::kNormalPriority));
}


改造
external

patch


===============================================================================

// Index for predefined singleton objects used in a snapshot.
enum {
  kNullObject = 0,
  kSentinelObject,
  kEmptyArrayObject,
  kTrueValue,
  kFalseValue,
  kClassIdsOffset = kFalseValue,

  // The class ids of predefined classes are included in this list
  // at an offset of kClassIdsOffset.

  kObjectType = (kNumPredefinedCids + kClassIdsOffset),
  kNullType,
  kDynamicType,
  kVoidType,
  kFunctionType,
  kNumberType,
  kSmiType,
  kMintType,
  kDoubleType,
  kIntType,
  kBoolType,
  kStringType,
  kArrayType,

  kInstanceObjectId,
  kMaxPredefinedObjectIds,
  kInvalidIndex = -1,
};

}  // namespace dart




MessageWriter
===============================================================================

class MessageWriter : public SnapshotWriter {
 public:
  static const intptr_t kIncrementSize = 512;
  MessageWriter(uint8_t** buffer, ReAlloc alloc)
      : SnapshotWriter(Snapshot::kMessage, buffer, alloc, kIncrementSize) {
    ASSERT(buffer != NULL);
    ASSERT(alloc != NULL);
  }
  ~MessageWriter() { }

  void WriteMessage(const Object& obj);

 private:
  DISALLOW_COPY_AND_ASSIGN(MessageWriter);
};

あとはひたすらWriteObjectするのみ。

WriteObjectImpl(rawobj);
  WriteInlinedObject(RawObject*)
WriteForwardedObjs();


raw_object_snapshot
===============================================================================
String WriteTo
Double Mint BigIntも似たような実装。

header

object_id
class_id
tags
length
hash
data //lenのサイズだけ書き込む

ReadFrom(reader, object_id, tags, kind)

lenを取得。
hashを取得。

if kFull
  str_objを取得。
  hashチェックを行う。
else
  ReadFromImpl()
    IsCanonical()
      str_objをcanonical tableから引く
    else
      str_objを取得。
      hashは0set

ByteArrayの場合、

object_id
tags

len
body


Mint::ReadFrom

===============================================================================

hash s
===============================================================================
===============================================================================
===============================================================================
===============================================================================
===============================================================================
