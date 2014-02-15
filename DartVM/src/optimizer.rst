hyperblockform
###############################################################################

(1)
optimized comopile時に、通らないパスをpredecessorから除外する。

(2)
deoptimizeのみの専用命令を作成し、分岐とは別に挿入して1block化する。


before
===============================================================================
instancecallをemitする際に、is_optimizingの場合に、
unoptimized codeをemitする。
compiler->GenerateInstanceCall(deopt_id(), ...

InstanceCallNoICData

after
===============================================================================
まずはいくつくらいno icなケースがあるか確認すべきだろう。

ApplyICData()の後に、

def-useの計算前、
constant propagatorの前

branch simplifier
の中でやる。

BlockEntryInstrがbbに相当するのかな。

goto
branch
もしかしてreturnも？


gotoの場合、returnに置換するか？
mergeのほうは、


return xxx
returnInst->InsertBefore(old_goto)
returnInst->set_next(NULL);
returnInst->UnuseAllInputs();
block->set_last_instruction(returnInst);

returninstr token_pos, value



Instruction * instr new ThrowInstr(0);

predを書き換えて歩く。

use list
=============================================================================

instのInputCount()を捜査

defn instr->AsDefinition()
defn->input_use_list()

phiをuse_listにもつ要素(instr, idx)の参照を削除する必要があるな。



===============================================================================
===============================================================================
