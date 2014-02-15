//Fibo.java
class Fibo {
  static int fibo(int n) {
    if (n < 2) {
      //then
      return n;
    } else {
      //else
      return fibo(n-1) + fibo(n-2);
    }
  }
  public static void main(String[] args) {
    System.out.println(fibo(40));
  }
}

$ time java -XX:MaxInlineSize=0 -XX:FreqInlineSize=0 -XX:PrintOptoAssembly Fibo

#
#  int ( int )
#
#r000 ecx   : parm 0: int                          <-- 引数n
# -- Old esp -- Framesize: 32 --                   <-- static関数なので、thisはない。
#r045 esp+28: return address                       <-- 第2引数は、edxに乗ってくる。以降はstack push
#r044 esp+24: saved fp register                    <-- method callだった場合、ecx=this, edx=arg1
#r043 esp+20: pad2, stack alignment
#r042 esp+16: Fixed slot 0
#r049 esp+12: spill
#r048 esp+ 8: spill
#r047 esp+ 4: spill
#r046 esp+ 0: spill
abababab   N1: #  B1 <- B6 B9  Freq: 1
abababab
000   B1: # B5 B2 <- BLOCK HEAD IS JUNK   Freq: 1
000     # stack bang
        PUSH   EBP  # Save EBP
        SUB    ESP, #24 # Create frame

00b     MOV    EBP,ECX                              <-- EBP = ECX = n
00d     CMP    ECX,#2                               <-- if (n < 2)
010     Jl,s  B5  P=0.500013 C=359559.000000        <-- goto then   //branchのfreqをカウントしている。
010
//else
012   B2: # B7 B3 <- B1  Freq: 0.499987
012     DEC    ECX                                  <-- ECX = (n-1)
013     CALL,static  Fibo::fibo                     <-- call fibo(n-1)
        # Fibo::fibo @ bci:10  L[0]=EBP
        # OopMap{off=24}
018
018   B3: # B8 B4 <- B2  Freq: 0.499977
        # Block is sole successor of call
018     MOV    [ESP + #0],EAX                       <-- ESP+#0 = fibo(n-1)の返値
01b     MOV    ECX,EBP                              <-- ECX = EBP = n
01d     ADD    ECX,#-2                              <-- ECX = (n-2)
        nop   # 3 bytes pad for loops and calls
023     CALL,static  Fibo::fibo                     <-- call fibo(n-2)
        # Fibo::fibo @ bci:16  L[0]=_ STK[0]=esp + #0
        # OopMap{off=40}
028
028   B4: # B6 <- B3  Freq: 0.499967
        # Block is sole successor of call
028     ADD    EAX,[ESP + #0]                       <-- ret = fibo(n-1) + fibo(n-2)
02b     JMP,s  B6                                   <-- return
02b
//then
02d   B5: # B6 <- B1  Freq: 0.500013                <-- goto if (n<2)
02d     MOV    EAX,ECX                              <-- EAX = ECX = n
02d
02f   B6: # N1 <- B5 B4  Freq: 0.99998
02f     ADD    ESP,24 # Destroy frame
        POPL   EBP
        TEST   PollPage,EAX ! Poll Safepoint

039     RET                                         <-- return EAX
039
03a   B7: # B9 <- B2  Freq: 4.99987e-06
03a     # exception oop is in EAX; no code emitted
03a     MOV    ECX,EAX
03c     JMP,s  B9
03c
03e   B8: # B9 <- B3  Freq: 4.99977e-06
03e     # exception oop is in EAX; no code emitted
03e     MOV    ECX,EAX
03e
040   B9: # N1 <- B7 B8  Freq: 9.99965e-06
040     ADD    ESP,24 # Destroy frame
        POPL   EBP

044     JMP    rethrow_stub
044



