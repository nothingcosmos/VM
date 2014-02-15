部
###############################################################################

章
*******************************************************************************

型の一覧
Null
Dynamic
Void
Object
Bool
Int
Double
Number
String
Function
List

Interface



セクション
===============================================================================

サブセクション
-------------------------------------------------------------------------------

Optional Type System
===============================================================================

varIfとintIfに、中間表現上の違いはない。
flow_graph_compilerを使っても、差分なし。

varIfにdoubleをあたえたら、ICでdoubleをきゃぷちゃしてるので、
変化はあるが、allocatorでこけている。



Generics
===============================================================================
Type Erasureではなく、

reified generics


Genericsのnewの比較
===============================================================================

t0 <- InstanceCall:22(* , t0, t0) IC[3: Smi, Smi | Double, Smi | Double, Double]

TypeArgumentsっていうIRが存在する。
AllocateObjectする際の引数になっている。
第2引数が０なのはなんだろうか。


Genericsのクラスnewと、普通のnewを比較してみればわかるかもしれない。。

gen
  TypeArguments int
  push 0
  Allocate Object (classtest, int, 0)
  push 3
  push 1
  staticcall constructor (obj, 3, 1)

nogen
  Allocate Object (classnogenerics)
  push 3
  push 100
  staticcal constructor (obj, 3, 100)

todo push 3って何？



ICの型が１種類の場合
===============================================================================

After Optimizations:
  0:  0: [graph]
  {
          v0 <- parameter(0) {PT: classtest<T>}
                v1 <- parameter(1) {PT: Dynamic}
  }  env={ v0, v1, #null }
 2:  1: [target]
        ParallelMove ecx <- S-2, eax <- S-1
 4:     CheckStackOverflow:0()
 6:     v2 <- #null {PT: Null}
 7:     ParallelMove S+0 <- edx
 8:     v3 <- LoadInstanceField:75(init, v0) IC[1: classtest] {PT: Dynamic} env={ v0 [ecx], v1 [eax], v2 [edx], v1 [eax], v0 [ecx] }
10:     Branch:11 if v1 > v3 goto (2, 3) IC[1: Smi, Smi] env={ v0 [ecx], v1 [eax], v2 [edx], v1 [eax], v3 [ebx] }
12:  2: [target]
14:     PushArgument v0
16:     v6 <- LoadInstanceField:76(init, v0) IC[1: classtest] {PT: Dynamic} env={ v0 [ecx], v1 [eax], v2 [edx], v1 [eax], t-1, v1 [eax], v0 [ecx] }
18:     ParallelMove edi <- eax
18:     v7 <- BinaryOp:77(-, v1, v6) IC[1: Smi, Smi] {PT: Smi} env={ v0 [ecx], v1 [S-1], v2 [edx], v1 [S-1], t-1, v1 [S-1], v6 [ebx] }
20:     PushArgument v7
22:     v8 <- PolymorphicInstanceCall(TintRec, v0, v7)  IC[1: classtest] {PT: Dynamic} env={ v0 [S-2], v1 [S-1], v2 [S+0], v1 [S-1], t-1, t-1 }
23:     ParallelMove eax <- eax
24:     ParallelMove ecx <- S-1
24:     v9 <- BinaryOp:79(* , v1, v8) IC[1: Smi, Smi] {PT: Smi} env={ v0 [S-2], v1 [S-1], v2 [S+0], v1 [S-1], v8 [eax] }
26:     ParallelMove eax <- ecx goto 4
28:  3: [target]
30:     v4 <- LoadInstanceField:80(init, v0) IC[1: classtest] {PT: Dynamic} env={ v0 [ecx], v1 [S-1], v2 [S+0], v0 [ecx] }
32:     ParallelMove eax <- edx goto 4
34:  4: [join]
        v5 <- phi(v4, v9) {PT: Dynamic}
35:     ParallelMove eax <- eax
36:     Return:36 v5



binary operator
===============================================================================
初期のbinaryは、phiにからむ問題があった。

i_id   500ms
+, Double Smi | Double, Double
Phi Dynamic   Num型だと判定するとよいことがあるだろうか。
Polymorphic IC[2: Smi | Double]

d_id  1201ms
+, Smi Double
Phi Dynamic
Polymorphic IC[1: Smi]

i_di   455ms
+, Doubke Smi | Double Double
inlined Polymorphic + IC[1: Double]
phi Dynamic
CheckClass Double
Polymorphic IC[1] Double]


d_di 12010ms
+, Double, Smi
Phi Dynamic
inlined +, Double
CheckClass Double
Polymorphic IC[1: Double]



i_id 1000ms
IC[1: Smi, Double
Polymorphic smi

d_id 1000ms
IC[1:Smi, Double
Polymorphic Smi

i_di 12000ms
IC[1:Double, Smi
CheckClass Double
Polymorphic Double

d_di 12000ms
IC[1:Double, Smi
CheckClass Double
Polymorphic Double





NumberOfChecks
===============================================================================
==0の場合、
feedbackがない場合、inlineしない



discussion
===============================================================================

Hi,



-------------------------------------------------------------------------------



-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

-------------------------------------------------------------------------------



TypeFeedback
===============================================================================

InstanceCallInstr* call

ICData call->ic_data()

ic_data.NumberOfChecks()


class Code : public Object;
// Returns an array indexed by deopt id, containing the extracted ICData.
RawArray* ExtractTypeFeedbackArray() const;


class ICData : public Object
ic_data_offset()
function_offset()
AddCheck(GrowableArray<intptr_t>& class_ids, Function& target)
GetCheckAt(index)  <-- きほんてきにこれで取得する。
GetReceiverClassIdAt()
NumberOfChecks()
GetClassIdAt() //あまり

id==0 receiver_class_id
id==1 argument_class_id

ICに型をupdateする箇所
AddCheckのcaller
InlineCacheMissHandler
UpdateTypeTestCache
UpdateICDataTwoArgs




UpdateICDataTwoArgs
================================
target_function = Resolver::ResolveDynamic()
class_ids.Add(Class::Handle(receiver.clazz()).id())
class_ids.Add(Class::Handle(arg1.clazz()).id())
ic_data.AddCheck(class_ids, target_function)




