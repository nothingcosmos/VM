Initial support for polymorphic inlining. 

Consider each polymorphic variant separately for inlining in frequency 
order. Share inlined bodies for shared targets. 

Insert an SSA redefinition of the receiver in each inlined variant to 
prevent hoisting. Hoisting code specialized to the receiver (e.g., 
direct access to internal fields of typed data arrays) out of the 
inlined body is not safe.

===============================================================================

SortICDataByCount()でソートするのかな。
InheritDeoptTargetなんてものがあるのか。
これでdeoptinfoを調整しないと落ちるのかな。

以下のIRを追加
RedefinitionInstr
これはEmitでunreachableなのか。
RemoveRedefinitions()ってのでRangeAnalysisの前に綺麗にする。
これは既存のIRをwrapして、何かするのか。IRのspillみたいなものんか

LoadClassIdInstr
これはSmiTag用の特殊パスを用意した、LoadClassId

本家の処理はInlinerにある
class PolymorphicInliner
PolymorphicInstanceCallをPolymorphicInlinerでinline()

TryInlining()でRedefinitionInstr()を生成し、calleeのargumentsをwrapするのか。

Inline()
-> TryInlining()
 -> BuildDecisionGraph()
 LoadClassIdInstrを生成して、StrictCompareの生成、

 CheckInlineDuplicate()ってのがあって、複数targetの重複をチェックする。。
 基底クラスの同じメソッドを呼び出す場合かな。

 オプション制御はないらしい。



SortICDataByCount()
===============================================================================

下記の2つから呼ばれる ::

  EmitTestAndCall()
    GenerateCallを生成する

  PolymorphicInliner::Inline()


PolymorphicInliner::Inline()
===============================================================================

inline() ::

  SortICDataByCount()でソートして、以下の処理を繰り返す。
    CheckInlinedDuplicate()
    CheckNonInlinedDuplicate()
    TryInlinig()

  最後に
  BuildDecisionGraph()
  exit_collector_->ReplaceCall()

CheckInlinedDuplicateは、異なるクラスから同じメソッドをshareしているか判定する。

CheckNonInlinedDuplicate()は、他の処理でNonInline判定されたログを確認する処理
たぶんTryInliningでNGだった。

===============================================================================
===============================================================================



inline展開 heuristics
===============================================================================

Inlining heuristics based on Cooper et al. 2008.
もしかして、これ？
http://dl.acm.org/citation.cfm?id=1788381
An adaptive strategy for inline substitution
http://www.cs.rice.edu/~keith/512/Lectures/10WholeProgram-1up.pdf
引数にConstantがある場合、Constant Propagationに期待出きるので、
積極的にinliningすると。
loop_depthは、loop_depth > 0かつinlining_in_loop_size_thresholdがtrueでないと、
ShouldWeInlineがtrueにならない。
loop bufferの範囲内で、inliningしたいってところか。

http://www.cs.rice.edu/~keith/512/Lectures/06Opt-V-1up.pdf


heuristics
===============================================================================
ヒューリスティクスに判断すると、以下のいずれかの条件に合致する場合、
inline展開を行う

DEFINE_FLAG(int, inlining_size_threshold, 22,
  "Always inline functions that have threshold or fewer instructions");

or

DEFINE_FLAG(int, inlining_callee_call_sites_threshold, 1,
  "Always inline functions containing threshold or fewer calls.");

or

DEFINE_FLAG(int, inlining_constant_arguments_count, 1,
  "Inline function calls with sufficient constant arguments "
  "and up to the increased threshold on instructions");

and

DEFINE_FLAG(int, inlining_constant_arguments_size_threshold, 60,
  "Inline function calls with sufficient constant arguments "
  "and up to the increased threshold on instructions");




Richardsの場合、4関数のpolymorphic inlineだけど、
どれもinline展開しない判断。
正確には、2つがhearisticsでNG
2つはnot inlinable


bool Function::IsInlineable() const {
  // '==' call is handled specially.
  return InlinableBit::decode(raw_ptr()->kind_tag_) &&
         HasCode() &&
         name() != Symbols::EqualOperator().raw();
}

set_is_inlinable

falseを設定するケースを洗い出す。

deoptimization_countが多すぎる場合
再帰関数で、optionがfalse
CanIntrinsify
threshold系で1度falseと判定されたらフラグ管理で埋め込む。



そもそもJVMではどうなのかの解析が必要なのではないか？
