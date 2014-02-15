メモリレイアウト
###############################################################################

Object
===============================================================================

Object.cc::RawObject* Object::Allocate(cls_id, size, space) ::

  //addressがreturnされ、HeapTagが立っていない。
  address = heap->Allocate(size, scace);
  //nullでsize分初期化したのち、
  //tagsをclass_idとsizeから生成して,tags_フィールドに埋め込む。
  InitializeObject(address, cls_id, size);
      uword tags = 0;
      tags = RawObject::ClassIdTag::update(class_id, tags);
      tags = RawObject::SizeTag::update(size, tags);
      reinterpret_cast<RawObject*>(address)->tags_ = tags;
  raw_obj = cast(address + heapobjecttag); //heapobjecttag = 1
  return raw_obj;


  [....][....][....][....] <-- size 4byte
  ^
  address

  [....][....][....][....]
  ^     ^
  tag   raw_obj

RawObject

Tag



上記のような扱いのはずだけど。。

TryAllocate
===============================================================================

assembler_ia32.cc ::

  TopAddress()
  /
  [....][....][....][....]     <-- .を1byteとして、[....]は4byte
   ^^^^

  //TopAddressって、すでにkHeapObjectTag加算されてるんだっけ？
  addl(instance_reg, Immediate(instance_size))          //TopAddress + instance_size
  sub(instance_reg, (instance_size - kHeapObjectTag=1)) //TopAddress - kHeapObjectTag
  movl((instance_reg, tags_offset), Immediate(tags))    //tags_フィールドのupdate
  return instance_reg

  raw_objectの最初のフィールドはtagで、1word
  uword tags_
  最初の1wordには、必ずtags_を埋め込むということ。

rawにはtags_があるけど、
marks, size, classが埋まっている。 hashは？

TagBits ::

  enum TagBits {
    kFreeBit = 0,
    kMarkBit = 1,         //for GC
    kCanonicalBit = 2,    //for object tags.
    kFromSnapshotBit = 3,
    kWatchedBit = 4,      //for GC
    kReservedTagBit = 5,  // kReservedBit{10K,100K,1M,10M}
    kReservedTagSize = 3,
    kSizeTagBit = 8,
    kSizeTagSize = 8,
    kClassIdTagBit = kSizeTagBit + kSizeTagSize,
    kClassIdTagSize = 16
  };

  [....][....][....][....]  <-- uword tags_
  ^     ^     ^
  some  size  classId

ObjectAlignment ::

  // Alignment offsets are used to determine object age.
  kNewObjectAlignmentOffset = kWordSize,                    //ia32は4
  kOldObjectAlignmentOffset = 0,
  // Object sizes are aligned to kObjectAlignment.
  kObjectAlignment = 2 * kWordSize,
  kObjectAlignmentLog2 = kWordSizeLog2 + 1,
  kObjectAlignmentMask = kObjectAlignment - 1,

SizeTag ::

  encodeは、size >> kObjectAlignmentLog2
  decodeは、value << kObjectAlignmentLog2

  sizeが8bit目からなので、kObjectAlignment + 1なのだと思う。

Is ::

  IsHeapObject()
    (this & kSmiTagMask) == kHeapObjectTag
  最下位1bit立っているかどうか。

  ia32、word=4, x64、word=8のはず。

  IsNewObject()
    (this & kNewObjectAlignmentOffset) == kNewObjectAlignmentOffset
  3or4bit目が立っているかどうか

  IsOldObject()
    (this & kNewObjectAlignmentOffset) == kOldObjectAlignmentOffset
  3or4bit目が立っていない。

  なぜ3or4bit目なのかがわからない。。
  NewObjectの場合、ObjectAlignmentは8or16だけど、それに1wordずらして扱っている関係上
  TopAddressごと 1wordずれているため、とか？

  そんなトリックはheapには見られないけど。。
  ダンプを入れると確かに1たってるので。。

  newgen word=4

snapshot
===============================================================================

ReadObjectImpl()を参照すると、 最初にint64_tをReadしている。 ::

  RawObject* SnapshotReader::ReadObjectImpl() {
    int64_t value = Read<int64_t>();
    if ((value & kSmiTagMask) == kSmiTag) {
      return NewInteger(value);
    }
    return ReadObjectImpl(value);
  }

  //
  class_id = GetVMIsolateObjectId(class_header)

IsVMIsolateObject

IsSingletonClassId

IsObjectStoreClassId





===============================================================================
===============================================================================

NoGCScope
===============================================================================



Allocate
===============================================================================
===============================================================================
===============================================================================
