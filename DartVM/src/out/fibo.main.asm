code for function 'file:///home/elise/language/dart/work/adven/fibo.dart_::_main' {
//prolog
  CheckStackOverflow:2()
0xb2f88168    55                     push ebp
0xb2f88169    89e5                   mov ebp,esp
0xb2f8816b    e800000000             call 0xb2f88170
0xb2f88170    3b256cfa7f08           cmp esp,[0x87ffa6c]
0xb2f88176    0f8636000000           jna 0xb2f881b2

//main body
  t0 <- Constant:3(#40)
  PushArgument:4(t0)
  StaticCall:5(fibo t0)
0xb2f8817c    b850000000             mov eax,0x50                   <-- fiboの引数40
0xb2f88181    50                     push eax
0xb2f88182    bab16b03b3             mov edx,0xb3036bb1  Array[1, 1, null]
0xb2f88187    e87c823702             call 0xb5300408  [stub: CallStaticFunction] <-- Stub越しにfibo呼び出し
0xb2f8818c    83c404                 add esp,0x4

//epilog
  t0 <- Constant:6(#null)
0xb2f8818f    b8190038b5             mov eax,0xb5380019             <-- 'null'
0xb2f88194    50                     push eax
  Return:7(t0)
0xb2f88195    58                     pop eax
0xb2f88196    ba690421b3             mov edx,0xb3210469  'Function 'main': static.' のテーブル取得。
0xb2f8819b    ff422b                 inc [edx+0x2b]                 <-- 'inc usage_counter'
0xb2f8819e    817a2bd0070000         cmp [edx+0x2b],0x7d0           <-- check hotcode 0x7d0==2000
0xb2f881a5    7c05                   jl 0xb2f881ac
0xb2f881a7    e8fc86ffff             call 0xb2f808a8  [stub: OptimizeFunction] <-- call JITCompiler!!!
0xb2f881ac    89ec                   mov esp,ebp
0xb2f881ae    5d                     pop ebp
0xb2f881af    c3                     ret
0xb2f881b0    90                     nop
0xb2f881b1    cc                     int3

//runtime
0xb2f881b2    b9f0c20a08             mov ecx,0x80ac2f0
0xb2f881b7    ba00000000             mov edx,0
0xb2f881bc    e8677e3702             call 0xb5300028  [stub: CallToRuntime]
0xb2f881c1    ebb9                   jmp 0xb2f8817c
0xb2f881c3    e960833702             jmp 0xb5300528  [stub: FixCallersTarget]
0xb2f881c8    e93b843702             jmp 0xb5300608  [stub: DeoptimizeLazy]
}

