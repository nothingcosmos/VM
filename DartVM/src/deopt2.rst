deoptimization
###############################################################################

src ::
  int funcADD(int n, int m) {
    return n + m;
  }


Before Optimizations ::

  Compiling function: 'file:///home/elise/language/dart/work/deopt/int.dart_::_funcADD' @ token 2, size 13
  *** BEGIN CFG
  Before Optimizations
  ==== file:///home/elise/language/dart/work/deopt/int.dart_::_funcADD
  B0[graph]:2
  B1[target]:0
      CheckStackOverflow:4()
      t0 <- LoadLocal:6(n)
      PushArgument:8(t0)
      t0 <- LoadLocal:10(m)
      PushArgument:12(t0)
      t0 <- InstanceCall:14(+, t0, t0)
      Return:16(t0)
  *** END CFG


  --> 'file:///home/elise/language/dart/work/deopt/int.dart_::_funcADD' entry: 0xb3148840 size: 106 time: 174 us
  Code for function 'file:///home/elise/language/dart/work/deopt/int.dart_::_funcADD' {
  0xb3148840    bfe1bc2cb3             mov edi,0xb32cbce1  'Function 'funcADD': static.'
  0xb3148845    ff472b                 inc [edi+0x2b]
  0xb3148848    817f2b983a0000         cmp [edi+0x2b],0x3a98
  0xb314884f    0f8d2b41ffff           jnl 0xb313c980  [stub: OptimizeFunction]
          ;; Enter frame
  0xb3148855    55                     push ebp
  0xb3148856    89e5                   mov ebp,esp
  0xb3148858    e800000000             call 0xb314885d
  0xb314885d    830424eb               add [esp],0xeb
          ;; B0
          ;; B1
          ;; CheckStackOverflow:4()
  0xb3148861    3b258c18d708           cmp esp,[0x8d7188c]
  0xb3148867    0f8622000000           jna 0xb314888f
          ;; t0 <- LoadLocal:6(n)
  0xb314886d    8b450c                 mov eax,[ebp+0xc]
  0xb3148870    50                     push eax
          ;; PushArgument:8(t0)
          ;; t0 <- LoadLocal:10(m)
  0xb3148871    8b4508                 mov eax,[ebp+0x8]
  0xb3148874    50                     push eax
          ;; PushArgument:12(t0)
          ;; t0 <- InstanceCall:14(+, t0, t0)
  0xb3148871    8b4508                 mov eax,[ebp+0x8]
  0xb3148874    50                     push eax
          ;; PushArgument:12(t0)
          ;; t0 <- InstanceCall:14(+, t0, t0)
  0xb3148875    b9e1ce2cb3             mov ecx,0xb32ccee1  'ICData target:'+' num-checks: 0'
  0xb314887a    bad9e037b5             mov edx,0xb537e0d9
  0xb314887f    e89c3affff             call 0xb313c320  [stub: TwoArgsCheckInlineCache]
  0xb3148884    83c408                 add esp,0x8
  0xb3148887    50                     push eax
          ;; Return:16(t0)
  0xb3148888    58                     pop eax
  0xb3148889    89ec                   mov esp,ebp
  0xb314888b    5d                     pop ebp
  0xb314888c    c3                     ret
  0xb314888d    90                     nop
  0xb314888e    cc                     int3
          ;; CheckStackOverflowSlowPath
  0xb314888f    b9903a0a08             mov ecx,0x80a3a90
  0xb3148894    ba00000000             mov edx,0
  0xb3148899    e8a2471f02             call 0xb533d040  [stub: CallToRuntime]
  0xb314889e    ebcd                   jmp 0xb314886d
  0xb31488a0    e93b4c1f02             jmp 0xb533d4e0  [stub: FixCallersTarget]
  0xb31488a5    e9564d1f02             jmp 0xb533d600  [stub: DeoptimizeLazy]
  }
  Pointer offsets for function: {
   1 : 0xb3148841 'Function 'funcADD': static.'
   54 : 0xb3148876 'ICData target:'+' num-checks: 0'
  }

  PC Descriptors for function 'file:///home/elise/language/dart/work/deopt/int.dart_::_funcADD' {
  pc        	kind    	deopt-id	tok-ix	try-ix
  0xb3148845	entry-patch  	-1		0	-1
  0xb3148861	deopt        	0		0	-1
  0xb3148875	deopt        	14		12	-1
  0xb3148884	ic-call      	14		12	-1
  0xb3148884	deopt        	15		12	-1
  0xb3148888	deopt        	16		0	-1
  0xb314888e	return       	-1		10	-1
  0xb314889e	other        	4		2	-1
  0xb314889e	deopt        	5		2	-1
  0xb31488a0	patch        	-1		0	-1
  0xb31488a5	lazy-deopt   	-1		0	-1
  }
  Stackmaps for function 'file:///home/elise/language/dart/work/deopt/int.dart_::_funcADD' {
  }
  Variable Descriptors for function 'file:///home/elise/language/dart/work/deopt/int.dart_::_funcADD' {
    stack var 'n' offset 3 (valid 4-16)
    stack var 'm' offset 2 (valid 7-16)
  }

上記deopt pcに戻ってこれるように、PC Descriptorsで保存している。
pc descriptorには、pc deopt-idがある。 deopt-idは、deoptの際の飛び先を表すはずである。


After Optimizations ::

  ==== file:///home/elise/language/dart/work/deopt/int.dart_::_funcADD
  0: B0[graph]:2 {
    v0 <- Constant:18(#null) T{null, Null, Type: class 'Null'}
    v1 <- Parameter:20(0) T{null, dynamic, Type: class 'dynamic'}
    v2 <- Parameter:22(1) T{null, dynamic, Type: class 'dynamic'}
  }
  2: B1[target]:0 ParallelMove edx <- S-2, ecx <- S-1
  4:     CheckStackOverflow:4()
  6:     CheckSmi:14(v1)
  8:     CheckSmi:14(v2)
  10:     ParallelMove eax <- edx
  10:     v3 <- BinarySmiOp:14(+, v1 T{not-null, _Smi@0x36924d72, ?}, v2 T{not-null, _Smi@0x36924d72, ?}) [-inf, +inf] T{not-null, _Smi@0x36924d72, ?} +o -t
  11:     ParallelMove eax <- eax
  12:     Return:16(v3)

Instr:の後の数字が、lifetime_positionってやつか？
deopt_idと一致するはず。

BinarySmiOp:14, CheckSmiが14で、Returnが16なのは


Assembler
===============================================================================

Deoptの仕組みとして、CheckSmi等のIRが
testとjumpをemitする。

jumpの飛び先は、主にDeopt stubである。

Code ::

  --> 'file:///home/elise/language/dart/work/deopt/int.dart_::_funcADD' entry: 0xb31488e0 size: 76 time: 555 us
  Code for optimized function 'file:///home/elise/language/dart/work/deopt/int.dart_::_funcADD' {
          ;; Enter frame
  0xb31488e0    55                     push ebp
  0xb31488e1    89e5                   mov ebp,esp
  0xb31488e3    e800000000             call 0xb31488e8
          ;; B0
          ;; B1
  0xb31488e8    8b550c                 mov edx,[ebp+0xc]
  0xb31488eb    8b4d08                 mov ecx,[ebp+0x8]
          ;; CheckSmi:14(v1)
  0xb31488ee    f6c201                 test_b edx,0x1
  0xb31488f1    0f8519000000           jnz 0xb3148910
          ;; CheckSmi:14(v2)
  0xb31488f7    f6c101                 test_b ecx,0x1
  0xb31488fa    0f8516000000           jnz 0xb3148916
          ;; ParallelMove eax <- edx
  0xb3148900    89d0                   mov eax,edx
          ;; v3 <- BinarySmiOp:14(+, v1 T{not-null, _Smi@0x36924d72, ?}, v2 T{not-null, _Smi@0x36924d72, ?}) [-inf, +inf] T{not-null, _Smi@0x36924d72, ?} +o -t
  0xb3148902    03c1                   add eax,ecx
  0xb3148904    0f8012000000           jo 0xb314891c
          ;; ParallelMove eax <- eax
          ;; Return:16(v3)
  0xb314890a    89ec                   mov esp,ebp
  0xb314890c    5d                     pop ebp
  0xb314890d    c3                     ret
  0xb314890e    90                     nop
  0xb314890f    cc                     int3
          ;; Deopt stub for id 14
  0xb3148910    e82b4c1f02             call 0xb533d540  [stub: Deoptimize]
  0xb3148915    cc                     int3
          ;; Deopt stub for id 14
  0xb3148916    e8254c1f02             call 0xb533d540  [stub: Deoptimize]
  0xb314891b    cc                     int3
          ;; Deopt stub for id 14
  0xb314891c    e81f4c1f02             call 0xb533d540  [stub: Deoptimize]
  0xb3148921    cc                     int3
  0xb3148922    e9b94b1f02             jmp 0xb533d4e0  [stub: FixCallersTarget]
  0xb3148927    e9d44c1f02             jmp 0xb533d600  [stub: DeoptimizeLazy]
  }

  PC Descriptors for function 'file:///home/elise/language/dart/work/deopt/int.dart_::_funcADD' {
  pc        	kind    	deopt-id	tok-ix	try-ix
  0xb31488e0	entry-patch  	-1		0	-1
  0xb314890f	return       	-1		10	-1
  0xb3148922	patch        	-1		0	-1
  0xb3148927	lazy-deopt   	-1		0	-1
  }

  DeoptInfo: {
    0: 0xb3148915  [pcmark oti:0][callerfp][ret oti:1(14)][ecx][edx][pcmark oti:1][callerfp][callerpc][const oti:0][const oti:0]  (CheckSmi)
    1: 0xb314891b  [suffix 0:10]  (CheckSmi)
    2: 0xb3148921  [suffix 0:10]  (BinarySmiOp)
  }

Deopt stubのidがどこにうまっているのか不明。。
DeoptInfoの012のアドレスを参照すれば、どのtableからjumpすれば復元できるのかわかるのかん？

;; Deopt stub for id 14
自体は、DeoptInfoをEmitしたときなので、deopt_id()で参照できている。
int3はdebug breakだけど、callに失敗して変なとこに飛んできたように生めているのか。

GenerateCode(stub_ix)




deopt reason ::

  Deoptimizing (reason 5 'BinarySmiOp') at pc 0xb3148a23 'file:///home/elise/language/dart/work/deopt/int.dart_::_main' (count 0)
  Deoptimizing file:///home/elise/language/dart/work/deopt/int.dart_::_main (count 1)
  Deoptimizing file:///home/elise/language/dart/work/deopt/int.dart_::_funcADD (count 1)
  *0. [bf988834] 00000000000000 [pcmark oti:0]
  *1. [bf988838] 0x0000bf98884c [callerfp]
  *2. [bf98883c] 0x0000b3148875 [ret oti:2(14)]
  *3. [bf988840] 0x00007fff5d14 [edx]
  *4. [bf988844] 0x000000016a0a [eax]
  *5. [bf988848] 0x0000b3148848 [pcmark oti:2]
  *6. [bf98884c] 0x0000bf98886c [callerfp]
  *7. [bf988850] 0x0000b314870d [ret oti:1(23)]
  *8. [bf988854] 0x0000b537d021 [const oti:0]
  *9. [bf988858] 0x0000b537d021 [const oti:0]
  *10. [bf98885c] 0x000000016a0a [eax]
  *11. [bf988860] 0x00007fff5d14 [edx]
  *12. [bf988864] 0x0000b537d021 [s3]
  *13. [bf988868] 0x0000b3148668 [pcmark oti:1]
  *14. [bf98886c] 0x0000bf988888 [callerfp]
  *15. [bf988870] 0x0000b313c087 [callerpc]
  Function: file:///home/elise/language/dart/work/deopt/int.dart_::_funcADD
  Line 4: '  return n + m;'
  Deopt args: 0


stubDeoptimize
===============================================================================

deoptimizeの飛び先は2ヶ所ある。

_stub_Deoptimizeと、_stub_DeoptimizeLazyである。



===============================================================================


===============================================================================
===============================================================================




