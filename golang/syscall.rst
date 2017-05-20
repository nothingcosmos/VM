syscall
################################################################################

cgoの呼び出しはsyscall呼び出しと同様に扱い、GC向けにケアされる


system call周りで気づいたこと
================================================================================

goはsystemcallを呼び出す前後において、Syscallでラップして呼び出している。
Syscallはアセンブリで定義されており、アーキテクチャごとにhookを定義している

amd64 ::
  
  TEXT    ·Syscall(SB),NOSPLIT,$0-56
          CALL    runtime·entersyscall(SB)
          MOVQ    a1+8(FP), DI
          MOVQ    a2+16(FP), SI
          MOVQ    a3+24(FP), DX
          MOVQ    $0, R10
          MOVQ    $0, R8
          MOVQ    $0, R9
          MOVQ    trap+0(FP), AX  // syscall entry
          SYSCALL
          CMPQ    AX, $0xfffffffffffff001
          JLS     ok
          MOVQ    $-1, r1+32(FP)
          MOVQ    $0, r2+40(FP)
          NEGQ    AX
          MOVQ    AX, err+48(FP)
          CALL    runtime·exitsyscall(SB)
          RET
  ok:
          MOVQ    AX, r1+32(FP)
          MOVQ    DX, r2+40(FP)
          MOVQ    $0, err+48(FP)
          CALL    runtime·exitsyscall(SB)
          RET

ポイントは、runtime.entersyscall(SB)と
runtime.exitsyscallを呼び出している点かな？

entersyscallはcgoにも必ず挿入されるが、
stackguardを挿入したり、pc,spを保存してGC向けにケアする


exitsyscallは、mcallでschedulerを呼び出す


