
sdk/lib/scalarlist

byte_arrays.dart
  external factory Float64List(int lenght);
  external factory Float64List.view(ByteArray array, [int start, int length]);


runtime/lib/byte_array.dart

patch class Float64List {
  factory Float64List(int length) {
    new _Float64List(length);
  }
}
static _Float64Array _new(int length) native "Float64Array_new";


externalは、raw objectに、実配列を含んでいない。
raw objectには、sizeとreferenceのみ格納している。

external arrayの場合、length, raw_array を格納しているため、instance sizeに、lengthを引数に与えて計算する必要我ある。



+intptr_t RawUint8ClampedArray::VisitUint8ClampedArrayPointers(
+    RawUint8ClampedArray *raw_obj, ObjectPointerVisitor* visitor) {
+  // Make sure that we got here with the tagged pointer as this.
+  ASSERT(raw_obj->IsHeapObject());
+  intptr_t length = Smi::Value(raw_obj->ptr()->length_);
+  visitor->VisitPointers(raw_obj->from(), raw_obj->to());
+  return Uint8ClampedArray::InstanceSize(length);
+}

+intptr_t RawExternalUint8ClampedArray::VisitExternalUint8ClampedArrayPointers(
+    RawExternalUint8ClampedArray* raw_obj, ObjectPointerVisitor* visitor) {
+  // Make sure that we got here with the tagged pointer as this.
+  ASSERT(raw_obj->IsHeapObject());
+  visitor->VisitPointers(raw_obj->from(), raw_obj->to());
+  return ExternalUint8ClampedArray::InstanceSize();
+}

Uint8ClampedArray
は、Ecmaのtyped array specification


どこで使うのか。
===============================================================================
newTransferableをつけると、externalを使って領域確保する。

GCの対象外になるため、transferableは譲渡可能の意味らしい。

GCの対象外になるため、ashmemみたいな使い方なのか。プロセス間通信に使うのか？isolateなどで？


