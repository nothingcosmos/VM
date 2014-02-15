
stubcodeをいつ生成するのか。
===============================================================================

  // Generate all the stubs.
  Code& code = Code::Handle();
  STUB_CODE_LIST(STUB_CODE_GENERATE);

STUBも実行時のようです。

incrementとreturninstrの数値は異なるのは？

以下でもカウンタ更新
void StubCode::GenerateOptimizedUsageCounterIncrement(Assembler* assembler)
void StubCode::GenerateUsageCounterIncrement(Assembler* assembler, Register temp_reg)

上記は、ICを生成する際に使うみたい。


FLAG_optimization_counter_threshold
ちゃんご動くことを確認。3000だと最適化されなかった。

Function::usage_counter_offset()

ReturnInstrでカウンタアップして、チェックしている。


type feedbackの仕組み。
===============================================================================


gc handle
===============================================================================
RawObject

from
to

その間のポインタを解析する。連続するポインタ領域として解析する。
===============================================================================

ObjectStore なんでkeyword_symbolsが途中をさしているのか。
===============================================================================

  RawInstance* out_of_memory_;
  RawArray* keyword_symbols_;
  RawFunction* receive_port_create_function_;
  RawFunction* lookup_receive_port_function_;
  RawFunction* handle_message_function_;
  RawObject** to() { return reinterpret_cast<RawObject**>(&keyword_symbols_); }


ARM Assembler
===============================================================================

いかの処理が、null強制処理化にかかわる実装であるはず。
===============================================================================
r17739 | asiva@google.com | 2013-01-29 09:53:22 +0900 (火, 29  1月 2013) | 2 lines
  Make Type, TypeParameter, TypeArguments and InstantiatedTypeArguments final heap objects.
  Review URL: https://codereview.chromium.org//12086031
  object.hの修正、上記がFINAL_HEAP_OBJECTに変更。
  何が違うのかというと、
  HEAP_OBJは、=と^=の際に、initializeHandle()
  FINAL_HEAPの場合、raw_にassignする。

  initializeHandle()は、
  raw_ptr != nullだったら、SetRaw()
  ==nullだったら、set_vtable(fake_object.vtable())

  cpp_vtable vtable() const { return bit_copy<cpp_vtable>(*this); }
  void set_vtable(cpp_vtable value) { *vtable_address() = value; }



###############################################################################


エラーハンドリングに関する疑問点
===============================================================================
VMから、どのようにエラーハンドリングを行っているのかどうか。
その横断的な制御派？

統計処理
===============================================================================
最適化の統計処理を作ってみるか？

Polyの種類統計やログ機能を作ってみるとか

IC[= をカウントする機能

ICの汚染を統計したい。
toString()などは除外する必要があるだろう。

pythonのフロントエンドを作ってみるとか
===============================================================================
何か難しい機能はあるだろうか。
Evalとか？


Deoptimizationの詳細が知りたい
===============================================================================
GenerateDartCall

deopt_idをキーに呼び出す。

coreimplのhash probe lookupの型がおかしい
===============================================================================

未確認。
polyになっているので。

lib/coreimpl/hash

probe

5: [target]
  Branch if EqualityCompare:44(v16 == v2 IC[2: Smi, Smi | _DeletedKeySentinel@0x924b4b8, Smi]) goto (6, 7) env={ v1, v2, v8, v9, v10
6: [target]

if (existingKey === null) return -1;
// The key is in the map, return its index.
if (existingKey == key) return hash;

糖衣構文の追加
===============================================================================

Double[] Javaのsyntaxを取り入れたい。
Double[]は、すべてscalarlistへの置換にすればいいのではないか。
int[]は、int32listか？
long[]は、int64listか？

intはどうするのか。

double[][]は、どうするのか。

StoreBufferProcessのネック
===============================================================================
DLRT_StoreBufferBlockProcess

おそらくGC経由だと思う。
aobenchで遅い。

DLRT_StoreBufferBlockProcess
_stub_UpdateStoreBuffer
file:///home/elise/language/dart/work/sci/fft.dart_FFT_transform_internal
file:///home/elise/language/dart/work/sci/fft.dart_FFT_inverse
file:///home/elise/language/dart/work/sci/fft.dart_::_measureFFT
file:///home/elise/language/dart/work/sci/fft.dart_::_main
_stub_InvokeDartCode


そもそもStoreBufferBlockって何よ


addPointerって、、


SmiToDouble UnboxedDouble reduce
===============================================================================
以下の中間表現を作成すれば速くならないかな。

peephole optimizer

SmiToDouble
SmiToUnboxDouble

IntegerToDouble
SmitToUnboxedDouble

generiscs のspecialize
===============================================================================


unboxdoubleを元に、メモリレイアウトを明かにする
===============================================================================

resultがkDoubleCidの場合、特定のフィールドから値を取ってくるだけ。
movsd(result, FieldAddress(value, Double::value_offset()));

resultがkSmiCid
untagしてxmmにconversion
SmiUntag(value);  // Untag input before conversion.
cvtsi2sd(result, value);
SmiTag(value);  // Restore input register.

上記以外の場合、
Label* deopt = compiler->AddDeoptStub(deopt_id_, kDeoptBinaryDoubleOp);
compiler->LoadDoubleOrSmiToXmm(result,
value,
locs()->temp(0).reg(),
deopt);

Mintのケースも特殊化できるような気がする。

OFFSET_OF(type, filed
RawDouble
RawMint

基本的には、this, _value
のみのこうせいかな

DartVMのオブジェクトは、
this
uword tags_
BitField<>


object.h
sentinel_

Object::Allocate(intptr_t cls_id, intptr_t size, Heap::Space space)
pageからsize分のメモリを確保

void Object::InitializeObject(uword address, intptr_t class_id, intptr_t size)



debug時に最適なdump処理をllvmと同じレベルで作ってみる。
===============================================================================

lazy initialize の仕組み
===============================================================================
null

worker/wrapper
===============================================================================
intは、scaleするので作れない。
doubleだけか。

simd用tuple型の実装
===============================================================================

scalarlistでデータを内包して、
simd演算すると速いかもしれない。
tuple型


Array
===============================================================================
kObjectArrayLength
kImmutableArrayLength

kFloat64ArrayCid
kFloat32ArrayCid

LoadFieldInstr
MethodRecognizer



for (ForwardInstructionIterator it(block); !it.Done(); it.Advance()) {
  Instruction* current = it.Current();

  Definition* defn = current->AsDefinition();
  if ((defn != NULL) &&
    (defn->ssa_temp_index() != -1) &&
    smi_definitions_->Contains(defn->ssa_temp_index())) {
    defn->InferRange();
  } else if (FLAG_array_bounds_check_elimination &&
    current->IsCheckArrayBound()) {
    CheckArrayBoundInstr* check = current->AsCheckArrayBound();
    RangeBoundary array_length =
    RangeBoundary::FromDefinition(LoadArrayLength(check));
    if (check->IsRedundant(array_length)) it.RemoveCurrentFromGraph();
  }
}


initArrayの場合は、数回ループしてるわけだが。
initFloatは、1回走査するのみ

RangeBoundary

phiノードのboundが足りない？

initarrayは、InferRangeCecursive前にRedundant

LoadArrayLength

intermediateとoptimizerに、それぞれfloat32 float64を追加

kImmutableArrayCid


下記関数で、Rangeを生成しないとだめだと思う。
intermediate
IsArrayLength
LoadFieldInstr::InferRange

void LoadFieldInstr::InferRange() {
if ((range_ == NULL) &&
((recognized_kind() == MethodRecognizer::kObjectArrayLength) ||
(recognized_kind() == MethodRecognizer::kImmutableArrayLength))) {
//elise
range_ = new Range(RangeBoundary::FromConstant(0),
RangeBoundary::FromConstant(Array::kMaxElements));
return;
}
Definition::InferRange();
}


あと木になるのは、LengthOffsetFor

pointerやarrayのbaseをphiにするべきか


Constructor Array Length
===============================================================================
ImmutableArray
ObjectArray


ExternalString
Peer
FinalizablePersistentHandle


メモリ戦略、ScopeみたいなRAIIの実装を解明する。
===============================================================================
Handleの仕組みが知りたい。

GCとの絡み

Externalはどうなるのか。とか。


main関数の最後に呼び出している関数
===============================================================================

main関数の最後で、OptimizedFunctionをcallしているが。
何をする処理なのか。

0xb2f8818f    b8190038b5             mov eax,0xb5380019
0xb2f88194    50                     push eax
0xb2f88195    58                     pop eax
0xb2f88196    ba690421b3             mov edx,0xb3210469  'Function 'main': static.'
0xb2f8819b    ff422b                 inc [edx+0x2b]
0xb2f8819e    817a2bd0070000         cmp [edx+0x2b],0x7d0
0xb2f881a5    7c05                   jl 0xb2f881ac
0xb2f881a7    e8fc86ffff             call 0xb2f808a8  [stub: OptimizeFunction]
0xb2f881ac    89ec                   mov esp,ebp
0xb2f881ae    5d                     pop ebp
0xb2f881af    c3                     ret
0xb2f881b0    90                     nop
0xb2f881b1    cc                     int3

GC reference
===============================================================================
raw data only reference
handle
external

gc is see visible reference
not bottme up all object

CallSiteごとに、lengthの値を１つだけ記録するのはどうなのだろうか。
===============================================================================

IC value capture


===============================================================================
===============================================================================

