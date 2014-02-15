--- Raw source ---

function fibo(n) {
  if (n < 2) {
//then
    return n;
  } else {
//else
    return fibo(n-1) + fibo(n-2);
  }
}


--- Optimized code ---
kind = OPTIMIZED_FUNCTION
name = fibo
stack_slots = 4
Instructions (size = 752)
0x27b299c0     0  55             push ebp
0x27b299c1     1  89e5           mov ebp,esp
0x27b299c3     3  56             push esi
0x27b299c4     4  57             push edi
0x27b299c5     5  83ec10         sub esp,0x10
0x27b299c8     8  c745f400000000 mov [ebp+0xf4],0x0
0x27b299cf    15  8b45fc         mov eax,[ebp+0xfc]
0x27b299d2    18  8945f0         mov [ebp+0xf0],eax
0x27b299d5    21  89c6           mov esi,eax
0x27b299d7    23  3b2530c7d908   cmp esp,[0x8d9c730]         // check stackoverflow
0x27b299dd    29  7305           jnc 36  (0x27b299e4)
0x27b299df    31  e85c5efeff     call 0x27b0f840             ;; code: STUB, StackCheckStub, minor: 0
0x27b299e4    36  8b4508         mov eax,[ebp+0x8]           // eax <-- (smi)n
0x27b299e7    39  a801           test al,0x1                 // smi check
0x27b299e9    41  0f85c0000000   jnz 239  (0x27b29aaf)       // if ! check_smi(n), goto deoptimize
0x27b299ef    47  d1f8           sar eax,1                   // (smi)n >> 1 //untag smi
0x27b299f1    49  8945ec         mov [ebp+0xec],eax          // [ebp+0xec] <- (int)n
0x27b299f4    52  83f802         cmp eax,0x2                 // if n < 2
0x27b299f7    55  0f8ca9000000   jl 230  (0x27b29aa6)        // goto else //return n
[then]
0x27b299fd    61  8b4df0         mov ecx,[ebp+0xf0]
0x27b29a00    64  8b4913         mov ecx,[ecx+0x13]
0x27b29a03    67  89c2           mov edx,eax                 // edx <-- (int)n
0x27b29a05    69  83ea01         sub edx,0x1                 // edx <-- (int)n - 1
0x27b29a08    72  8b1d1495402a   mov ebx,[0x2a409514]        ;; global property cell //property call check eq? fibo
0x27b29a0e    78  81fb05769333   cmp ebx,0x33937605          ;; object: 0x33937605 <JS Function fibo>
0x27b29a14    84  0f85f0f5e827   jnz 0x4f9b900a              ;; deoptimization bailout 1
0x27b29a1a    90  8b5917         mov ebx,[ecx+0x17]          // ebx <-- ret value //stackに返値が埋まってくるんだっけ？
0x27b29a1d    93  895df0         mov [ebp+0xf0],ebx          // このcontextのstackに入れ直し
0x27b29a20    96  53             push ebx
0x27b29a21    97  89d6           mov esi,edx                 // esi = edx = (int)(n-1)
0x27b29a23    99  03f6           add esi,esi                 // tag smi // (int)esi << 1
0x27b29a25   101  0f80b3000000   jo 286  (0x27b29ade)        // if overflow, goto deoptimize
0x27b29a2b   107  56             push esi                    // push (smi)(n-1)
0x27b29a2c   108  bf05769333     mov edi,0x33937605          ;; object: 0x33937605 <JS Function fibo>
0x27b29a31   113  8b7717         mov esi,[edi+0x17]
0x27b29a34   116  c6c102         mov_b cl,0x2
0x27b29a37   119  e884ffffff     call 0  (0x27b299c0)        ;; debug: position 72  // call fibo(n-1)
                                                             ;; code: OPTIMIZED_FUNCTION
0x27b29a3c   124  8945e8         mov [ebp+0xe8],eax          // stack ebp+0xe8 <-- (smi)fibo(n-1)の返値
0x27b29a3f   127  8b4dec         mov ecx,[ebp+0xec]          // ecx <-- (int)n
0x27b29a42   130  83e902         sub ecx,0x2                 // ecx <-- (int)n - 2
0x27b29a45   133  8b151495402a   mov edx,[0x2a409514]        ;; global property cell //property call check eq? fibo
0x27b29a4b   139  81fa05769333   cmp edx,0x33937605          ;; object: 0x33937605 <JS Function fibo>
0x27b29a51   145  0f85c7f5e827   jnz 0x4f9b901e              ;; deoptimization bailout 3
0x27b29a57   151  ff75f0         push [ebp+0xf0]
0x27b29a5a   154  03c9           add ecx,ecx                 // tag smi // (int)ecx << 1
0x27b29a5c   156  0f80e0000000   jo 386  (0x27b29b42)        // if overflow, goto deoptimize
0x27b29a62   162  51             push ecx                    // push (smi)(n-2)
0x27b29a63   163  bf05769333     mov edi,0x33937605          ;; object: 0x33937605 <JS Function fibo>
0x27b29a68   168  8b7717         mov esi,[edi+0x17]
0x27b29a6b   171  c6c102         mov_b cl,0x2
0x27b29a6e   174  e84dffffff     call 0  (0x27b299c0)        ;; debug: position 84 // call fibo(n-2)
                                                             ;; code: OPTIMIZED_FUNCTION
0x27b29a73   179  8b4de8         mov ecx,[ebp+0xe8]          // ecx <-- (smi)fibo(n-2) //stackに返値が埋まってくるんだっけ？
0x27b29a76   182  f6c101         test_b cl,0x1               // smi check(ecx)
0x27b29a79   185  0f8527010000   jnz 486  (0x27b29ba6)       // if ! check_smi, goto deoptimize
0x27b29a7f   191  d1f9           sar ecx,1                   // untag smi // (smi)fibo(n-2) >> 1
0x27b29a81   193  89c2           mov edx,eax                 // edx <-- (smi)fibo(n-1)の返値
0x27b29a83   195  f6c201         test_b dl,0x1               // smi check(edx)
0x27b29a86   198  0f8549010000   jnz 533  (0x27b29bd5)       // if ! check_smi, goto deoptimize
0x27b29a8c   204  d1fa           sar edx,1                   // untag smi,  fibo(n-1)の返値 >> 1
0x27b29a8e   206  03ca           add ecx,edx                 // ecx <-- fibo(n-1) + fibo(n-2)
0x27b29a90   208  0f809cf5e827   jo 0x4f9b9032               ;; deoptimization bailout 5 //overflow deopt
0x27b29a96   214  89c8           mov eax,ecx                 // eax <-- ecx
0x27b29a98   216  03c0           add eax,eax                 // tag smi // eax << 1
0x27b29a9a   218  0f8064010000   jo 580  (0x27b29c04)        // if overflow , goto deoptimize
0x27b29aa0   224  89ec           mov esp,ebp
0x27b29aa2   226  5d             pop ebp
0x27b29aa3   227  c20800         ret 0x8                     // return
[else]
0x27b29aa6   230  8b4508         mov eax,[ebp+0x8]           // eax <-- n
0x27b29aa9   233  89ec           mov esp,ebp
0x27b29aab   235  5d             pop ebp
0x27b29aac   236  c20800         ret 0x8                     // return n

// runtime
0x27b29aaf   239  8178ff3581b05e cmp [eax+0xff],0x5eb08135    ;; object: 0x5eb08135 <Map(elements=3)>
0x27b29ab6   246  0f8580f5e827   jnz 0x4f9b903c              ;; deoptimization bailout 6
0x27b29abc   252  f20f104003     movsd xmm0,[eax+0x3]
0x27b29ac1   257  f20f2cc0       cvttsd2si eax,xmm0
0x27b29ac5   261  f20f2ac8       cvtsi2sd xmm1,eax
0x27b29ac9   265  660f2ec1       ucomisd xmm0,xmm1
0x27b29acd   269  0f8569f5e827   jnz 0x4f9b903c              ;; deoptimization bailout 6
0x27b29ad3   275  0f8a63f5e827   jpe 0x4f9b903c              ;; deoptimization bailout 6
0x27b29ad9   281  e913ffffff     jmp 49  (0x27b299f1)
0x27b29ade   286  60             pushad
0x27b29adf   287  d1fe           sar esi,1
0x27b29ae1   289  81f600000080   xor esi,0x80000000
0x27b29ae7   295  f20f2ac6       cvtsi2sd xmm0,esi
0x27b29aeb   299  8b35e8b4d908   mov esi,[0x8d9b4e8]
0x27b29af1   305  89f0           mov eax,esi
0x27b29af3   307  83c00c         add eax,0xc
0x27b29af6   310  0f821e000000   jc 346  (0x27b29b1a)
0x27b29afc   316  3b05ecb4d908   cmp eax,[0x8d9b4ec]
0x27b29b02   322  0f8712000000   ja 346  (0x27b29b1a)
0x27b29b08   328  8905e8b4d908   mov [0x8d9b4e8],eax
0x27b29b0e   334  83c601         add esi,0x1
0x27b29b11   337  c746ff3581b05e mov [esi+0xff],0x5eb08135    ;; object: 0x5eb08135 <Map(elements=3)>
0x27b29b18   344  eb19           jmp 371  (0x27b29b33)
0x27b29b1a   346  c744240400000000 mov [esp+0x4],0x0
0x27b29b22   354  8b75fc         mov esi,[ebp+0xfc]
0x27b29b25   357  33c0           xor eax,eax
0x27b29b27   359  bb1c1d2708     mov ebx,0x8271d1c
0x27b29b2c   364  e88fdeffff     call 0x27b279c0             ;; code: STUB, CEntryStub, minor: 1
0x27b29b31   369  89c6           mov esi,eax
0x27b29b33   371  f20f114603     movsd [esi+0x3],xmm0
0x27b29b38   376  89742404       mov [esp+0x4],esi
0x27b29b3c   380  61             popad
0x27b29b3d   381  e9e9feffff     jmp 107  (0x27b29a2b)
0x27b29b42   386  60             pushad
0x27b29b43   387  d1f9           sar ecx,1
0x27b29b45   389  81f100000080   xor ecx,0x80000000
0x27b29b4b   395  f20f2ac1       cvtsi2sd xmm0,ecx
0x27b29b4f   399  8b0de8b4d908   mov ecx,[0x8d9b4e8]
0x27b29b55   405  89c8           mov eax,ecx
0x27b29b57   407  83c00c         add eax,0xc
0x27b29b5a   410  0f821e000000   jc 446  (0x27b29b7e)
0x27b29b60   416  3b05ecb4d908   cmp eax,[0x8d9b4ec]
0x27b29b66   422  0f8712000000   ja 446  (0x27b29b7e)
0x27b29b6c   428  8905e8b4d908   mov [0x8d9b4e8],eax
0x27b29b72   434  83c101         add ecx,0x1
0x27b29b75   437  c741ff3581b05e mov [ecx+0xff],0x5eb08135    ;; object: 0x5eb08135 <Map(elements=3)>
0x27b29b7c   444  eb19           jmp 471  (0x27b29b97)
0x27b29b7e   446  c744241800000000 mov [esp+0x18],0x0
0x27b29b86   454  8b75fc         mov esi,[ebp+0xfc]
0x27b29b89   457  33c0           xor eax,eax
0x27b29b8b   459  bb1c1d2708     mov ebx,0x8271d1c
0x27b29b90   464  e82bdeffff     call 0x27b279c0             ;; code: STUB, CEntryStub, minor: 1
0x27b29b95   469  89c1           mov ecx,eax
0x27b29b97   471  f20f114103     movsd [ecx+0x3],xmm0
0x27b29b9c   476  894c2418       mov [esp+0x18],ecx
0x27b29ba0   480  61             popad
0x27b29ba1   481  e9bcfeffff     jmp 162  (0x27b29a62)
0x27b29ba6   486  8179ff3581b05e cmp [ecx+0xff],0x5eb08135    ;; object: 0x5eb08135 <Map(elements=3)>
0x27b29bad   493  0f8593f4e827   jnz 0x4f9b9046              ;; deoptimization bailout 7
0x27b29bb3   499  f20f104103     movsd xmm0,[ecx+0x3]
0x27b29bb8   504  f20f2cc8       cvttsd2si ecx,xmm0
0x27b29bbc   508  f20f2ac9       cvtsi2sd xmm1,ecx
0x27b29bc0   512  660f2ec1       ucomisd xmm0,xmm1
0x27b29bc4   516  0f857cf4e827   jnz 0x4f9b9046              ;; deoptimization bailout 7
0x27b29bca   522  0f8a76f4e827   jpe 0x4f9b9046              ;; deoptimization bailout 7
0x27b29bd0   528  e9acfeffff     jmp 193  (0x27b29a81)
0x27b29bd5   533  817aff3581b05e cmp [edx+0xff],0x5eb08135    ;; object: 0x5eb08135 <Map(elements=3)>
0x27b29bdc   540  0f856ef4e827   jnz 0x4f9b9050              ;; deoptimization bailout 8
0x27b29be2   546  f20f104203     movsd xmm0,[edx+0x3]
0x27b29be7   551  f20f2cd0       cvttsd2si edx,xmm0
0x27b29beb   555  f20f2aca       cvtsi2sd xmm1,edx
0x27b29bef   559  660f2ec1       ucomisd xmm0,xmm1
0x27b29bf3   563  0f8557f4e827   jnz 0x4f9b9050              ;; deoptimization bailout 8
0x27b29bf9   569  0f8a51f4e827   jpe 0x4f9b9050              ;; deoptimization bailout 8
0x27b29bff   575  e98afeffff     jmp 206  (0x27b29a8e)
0x27b29c04   580  60             pushad
0x27b29c05   581  d1f8           sar eax,1
0x27b29c07   583  3500000080     xor eax, 0x80000000
0x27b29c0c   588  f20f2ac0       cvtsi2sd xmm0,eax
0x27b29c10   592  8b05e8b4d908   mov eax,[0x8d9b4e8]
0x27b29c16   598  89c1           mov ecx,eax
0x27b29c18   600  83c10c         add ecx,0xc
0x27b29c1b   603  0f821e000000   jc 639  (0x27b29c3f)
0x27b29c21   609  3b0decb4d908   cmp ecx,[0x8d9b4ec]
0x27b29c27   615  0f8712000000   ja 639  (0x27b29c3f)
0x27b29c2d   621  890de8b4d908   mov [0x8d9b4e8],ecx
0x27b29c33   627  83c001         add eax,0x1
0x27b29c36   630  c740ff3581b05e mov [eax+0xff],0x5eb08135    ;; object: 0x5eb08135 <Map(elements=3)>
0x27b29c3d   637  eb17           jmp 662  (0x27b29c56)
0x27b29c3f   639  c744241c00000000 mov [esp+0x1c],0x0
0x27b29c47   647  8b75fc         mov esi,[ebp+0xfc]
0x27b29c4a   650  33c0           xor eax,eax
0x27b29c4c   652  bb1c1d2708     mov ebx,0x8271d1c
0x27b29c51   657  e86addffff     call 0x27b279c0             ;; code: STUB, CEntryStub, minor: 1
0x27b29c56   662  f20f114003     movsd [eax+0x3],xmm0
0x27b29c5b   667  8944241c       mov [esp+0x1c],eax
0x27b29c5f   671  61             popad
0x27b29c60   672  e93bfeffff     jmp 224  (0x27b29aa0)
0x27b29c65   677  90             nop
0x27b29c66   678  90             nop
0x27b29c67   679  90             nop
0x27b29c68   680  90             nop
0x27b29c69   681  90             nop
0x27b29c6a   682  66             nop
0x27b29c6b   683  90             nop

