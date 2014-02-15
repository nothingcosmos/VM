
Code for function 'file:///home/elise/language/dart/work/adven/fibo.dart_::_fibo' {
//prolog
  //CheckStackOverflow:2()
  0xb30481e8    55                     push ebp
  0xb30481e9    89e5                   mov ebp,esp
  0xb30481eb    e800000000             call 0xb30481f0
  0xb30481f0    3b257c7a6b08           cmp esp,[0x86b7a7c]
  0xb30481f6    0f86d1000000           jna 0xb30482cd

  //t0 <- LoadLocal:3(n lvl:0)
  0xb30481fc    8b4508                 mov eax,[ebp+0x8]     //引数nからload
  0xb30481ff    50                     push eax
  //t1 <- Constant:4(#2)
  0xb3048200    b804000000             mov eax,0x4           //定数2をload
  0xb3048205    50                     push eax

  //Branch if RelationalOp:5(<, t0, t1) goto (2, 3)
  0xb3048206    59                     pop ecx
  0xb3048207    58                     pop eax
  0xb3048208    50                     push eax
  0xb3048209    51                     push ecx
  0xb304820a    b929062db3             mov ecx,0xb32d0629  'ICData target:'<' num-checks: 0' (n<2)の呼び出し準備
  0xb304820f    ba89ba1eb3             mov edx,0xb31eba89  Array[2, 2, null]
  0xb3048214    e8bf80ffff             call 0xb30402d8  [stub: TwoArgsCheckInlineCache] //2引数のInlineCache(<)の呼び出し
  0xb3048219    83c408                 add esp,0x8
  //goto (2, 3)
  0xb304821c    3d790f34b3             cmp eax, 0xb3340f79  'true'
  0xb3048221    0f8520000000           jnz 0xb3048247
[B2]
  //t0 <- LoadLocal:7(n lvl:0)
  0xb3048227    8b4508                 mov eax,[ebp+0x8]   //引数nをload
  0xb304822a    50                     push eax
[epilog]
  //Return:8(t0)
  0xb304822b    58                     pop eax
  0xb304822c    ba11042db3             mov edx,0xb32d0411  'Function 'fibo': static.'
  0xb3048231    ff422b                 inc [edx+0x2b]       // fiboのinc usage_counterをinc
  0xb3048234    817a2bd0070000         cmp [edx+0x2b],0x7d0 // 2000と比較してhotcode check
  0xb304823b    7c05                   jl 0xb3048242
  0xb304823d    e86686ffff             call 0xb30408a8  [stub: OptimizeFunction]
  0xb3048242    89ec                   mov esp,ebp
  0xb3048244    5d                     pop ebp
  0xb3048245    c3                     ret                  // return n;
  0xb3048246    90                     nop
[B3]
  //t0 <- LoadLocal:9(n lvl:0)
  0xb3048247    8b4508                 mov eax,[ebp+0x8]    //変数nからload
  //PushArgument:10(t0)
  0xb304824a    50                     push eax
  //t0 <- Constant:11(#1)
  0xb304824b    b802000000             mov eax,0x2          //定数1をload
  //PushArgument:12(t0)
  0xb3048250    50                     push eax
  //t0 <- InstanceCall:13(-, t0, t0)
  0xb3048251    b981062db3             mov ecx,0xb32d0681  'ICData target:'-' num-checks: 0' //(n-1)の呼び出し準備
  0xb3048256    ba89ba1eb3             mov edx,0xb31eba89  Array[2, 2, null]
  0xb304825b    e87880ffff             call 0xb30402d8  [stub: TwoArgsCheckInlineCache] //2引数のInlineCache(-)の呼び出し
  0xb3048260    83c408                 add esp,0x8
  //PushArgument:14(t0)
  0xb3048263    50                     push eax
  //t0 <- StaticCall:15(fibo t0)
  0xb3048264    bab16b0fb3             mov edx,0xb30f6bb1  Array[1, 1, null]
  0xb3048269    e89a813702             call 0xb53c0408  [stub: CallStaticFunction]  //fibo(n-1)の呼び出し
  0xb304826e    83c404                 add esp,0x4
  //PushArgument:16(t0)
  0xb3048271    50                     push
  //t0 <- LoadLocal:17(n lvl:0)
  0xb3048272    8b4508                 mov eax,[ebp+0x8]   //変数nからload
  //PushArgument:18(t0)
  0xb3048275    50                     push eax
  //t0 <- Constant:19(#2)
  0xb3048276    b804000000             mov eax,0x4         //定数2をload
  //PushArgument:20(t0)
  0xb304827b    50                     push eax
  //t0 <- InstanceCall:21(-, t0, t0)
  0xb304827c    b9f1062db3             mov ecx,0xb32d06f1  'ICData target:'-' num-checks: 0' //n-1 の呼び出し準備
  0xb3048281    ba89ba1eb3             mov edx,0xb31eba89  Array[2, 2, null]
  0xb3048286    e84d80ffff             call 0xb30402d8  [stub: TwoArgsCheckInlineCache] //2引数のInlineCache(-)を呼び出し
  0xb304828b    83c408                 add esp,0x8
  //PushArgument:22(t0)
  0xb304828e    50                     push eax
  //t0 <- StaticCall:23(fibo t0)
  0xb304828f    bab16b0fb3             mov edx,0xb30f6bb1  Array[1, 1, null]
  0xb3048294    e86f813702             call 0xb53c0408  [stub: CallStaticFunction] //fibo(n-2)の呼び出し
  0xb3048299    83c404                 add esp,0x4
  //PushArgument:24(t0)
  0xb304829c    50                     push eax
  //t0 <- InstanceCall:25(+, t0, t0)
  0xb304829d    b961072db3             mov ecx,0xb32d0761  'ICData target:'+' num-checks: 0' //fibo(n-1) + fibo(n-2)の呼び出し準備
  0xb30482a2    ba89ba1eb3             mov edx,0xb31eba89  Array[2, 2, null]
  0xb30482a7    e82c80ffff             call 0xb30402d8  [stub: TwoArgsCheckInlineCache] //2引数のInlineCache(+)を呼び出し
  0xb30482ac    83c408                 add esp,0x8
  0xb30482af    50                     push eax
[epilog]
  //Return:26(t0)
  0xb30482b0    58                     pop eax
  0xb30482b1    ba11042db3             mov edx,0xb32d0411  'Function 'fibo': static.'
  0xb30482b6    ff422b                 inc [edx+0x2b]       // fiboのinc usage_counterをinc
  0xb30482b9    817a2bd0070000         cmp [edx+0x2b],0x7d0 // 2000と比較してhotcode check
  0xb30482c0    7c05                   jl 0xb30482c7
  0xb30482c2    e8e185ffff             call 0xb30408a8  [stub: OptimizeFunction]
  0xb30482c7    89ec                   mov esp,ebp
  0xb30482c9    5d                     pop ebp
  0xb30482ca    c3                     ret
  0xb30482cb    90                     nop
[runtime]
  0xb30482cc    cc                     int3
  0xb30482cd    b9f0c20a08             mov ecx,0x80ac2f0
  0xb30482d2    ba00000000             mov edx,0
  0xb30482d7    e84c7d3702             call 0xb53c0028  [stub: CallToRuntime]
  0xb30482dc    e91bffffff             jmp 0xb30481fc
  0xb30482e1    e942823702             jmp 0xb53c0528  [stub: FixCallersTarget]
  0xb30482e6    e91d833702             jmp 0xb53c0608  [stub: DeoptimizeLazy]
}



