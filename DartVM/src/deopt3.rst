Deoptの準備
###############################################################################

===============================================================================

Deopt stub for ::

  ;; Deopt stub for id 14
     0xb3148916    e8254c1f02             call 0xb533d540  [stub: Deoptimize]
     0xb314891b    cc 

  void CompilerDeoptInfoWithStub::GenerateCode(FlowGraphCompiler* compiler,
                                               intptr_t stub_ix) {
    // Calls do not need stubs, they share a deoptimization trampoline.
    ASSERT(reason() != kDeoptAtCall);
    Assembler* assem = compiler->assembler();
  #define __ assem->
    __ Comment("Deopt stub for id %"Pd"", deopt_id());
    __ Bind(entry_label());
    if (FLAG_trap_on_deoptimization) __ int3();
  
    ASSERT(deopt_env() != NULL);
  
    __ call(&StubCode::DeoptimizeLabel());
    set_pc_offset(assem->CodeSize());
    __ int3();
  #undef __
  }


DeoptInfo
===============================================================================

重要な要素
deopt_id
DeoptReasonId
Environment

class CompilerDeoptInfo
上記をwrapして、pcを保持するだけ。labelが付いたのかな。


Environment
===============================================================================
もしかして、Environmentがコア技術だったりするのかな。

InstructionにEnvをget set removeできる。

自動メンテしてるのか？

DeepCopy()
Location
values_
ValueAtUseIndex
From


参照しているポイント
===============================================================================
flow_graph
flow_graph_compiler
flow_graph_optimizer

まとめ
===============================================================================
Dart VMのDeoptimizationのキモは、Environmentなのかな。Environment自体は、一般のコンパイラのデバッグ情報に相当する部分で、builderおよびoptimizerの各種最適化で使用される、IRへ副作用を伴う操作が自動メンテするのか。
Environmentを正しくメンテできる範囲においてIRをoptimizeしてよいし、Environmentが正しければdeoptimizeされるはずってことか。。Environmentを壊すような、命令の順序入れ替えや、アグレッシブなLOOP最適化はNGってことなのかな


===============================================================================
