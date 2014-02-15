On-Stack Replacement
###############################################################################

Revision
===============================================================================
r24088 | kmillikin@google.com | 2013-06-17 20:05:15 +0900 (月, 17  6月 2013) | 12 lines

After OSR compilation, restore the pre-OSR code (which might be already
optimized) rather than the unoptimized code (which might have its entry patched).
When the optimized code entry is patched it is only safe to call
it as a static call, not as an instance call.


r24024 | kmillikin@google.com | 2013-06-14 19:10:55 +0900 (金, 14  6月 2013) | 13 lines
OSRの最初の実装
プロファイリングを追加 OSRの候補を選択する
関数にOSR entry pointを追加

パラメータのプロファイルとって
チューニング中、

Option
===============================================================================
オプションを3つ追加

DEFINE_FLAG(bool, use_osr, true, "Use on-stack replacement.");
DEFINE_FLAG(bool, trace_osr, false, "Trace attempts at on-stack replacement.");

Assembler
===============================================================================
Assembler::EnterOsrFrame(intptr_t extra_size)の追加

code_generator::StackOverflowを修正

CompileParsedFunctionの引数、osr_idを追加
osr_idがkNoDeoptIdの場合、これまでの処理と同様。デフォルト値みたいなもん。

AddCurrentDescriptorには、osr用

PcDescriptor
===============================================================================
PcDescriptorには、kOsrEntryを追加。

OSRの場合、通常のFrameEnterよりStackSizeが小さい。
 intptr_t extra_slots = StackSize()
   - flow_graph().num_stack_locals()
   - flow_graph().num_copied_params();

class Codeに、intptr_t GetDeoptIdForOsr(uword pc) const; を追加

GraphBuilderから、
GraphEntry->PruneUnreachable()
osr_id == deoptidのブロックを、深さ優先で探す。
対象のAsJoinEntryからGotoInstrを生成し、Edgeを生成する。

上記を使って、GraphBuilderにおいて、GraphEntryのSucc > 1のポイントに、
OSR用のedgeを挿入していく。

Check <-- CheckStackOverflow
Compile
OSR Patch

Entry
===============================================================================

StackOverflowにおいて、
usage_counterを+1する。これは以前から同様。

UnoptimizedCodeにおいて、StackOverflowした場合、
具体的にはRuntimeEntry中において、
OSRを試行する。

AddCurrentDescriptor
===============================================================================


