//
//clang3.2 -O3
//

int fibo(int n) {
  if (n < 2) {
//then
    return n;
  } else {
//else
    return fibo(n-1) + fibo(n-2);
  }
}

//objdump -d -M intel
080483f0 <fibo>:
80483f0:       57                      push   edi
80483f1:       56                      push   esi
80483f2:       50                      push   eax
80483f3:       8b 74 24 10             mov    esi,DWORD PTR [esp+0x10] // esi <-- n
80483f7:       83 fe 02                cmp    esi,0x2                  // if (n < 2)
80483fa:       7d 04                   jge    8048400 <fibo+0x10>      // goto then
// else
80483fc:       89 f0                   mov    eax,esi                  // eax <-- esi
80483fe:       eb 1a                   jmp    804841a <fibo+0x2a>      // goto return
// then
8048400:       8d 46 ff                lea    eax,[esi-0x1]            // eax <-- n - 1
8048403:       89 04 24                mov    DWORD PTR [esp],eax      // push (n-1)
8048406:       e8 e5 ff ff ff          call   80483f0 <fibo>           // call fibo1
804840b:       89 c7                   mov    edi,eax                  // edi <-- ret1
804840d:       83 c6 fe                add    esi,0xfffffffe           // esi <-- n - 2
8048410:       89 34 24                mov    DWORD PTR [esp],esi      // push (n-2)
8048413:       e8 d8 ff ff ff          call   80483f0 <fibo>           // call fibo2
8048418:       01 f8                   add    eax,edi                  // eax <-- ret2 + ret1
// return
804841a:       83 c4 04                add    esp,0x4
804841d:       5e                      pop    esi
804841e:       5f                      pop    edi
804841f:       c3                      ret                             // return eax

