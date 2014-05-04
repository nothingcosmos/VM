callchain
###############################################################################

goのmainから辿る。

go main
*******************************************************************************

main ::

  asm_amd64.s::_rt0_go
    runtime..args
    runtime..osinit
    runtime..hashinit
    runtime..schedinit
      runtime..symtabinit
      runtime..mallocinit
      mcommoninit(m)

    pushq runtime..main..f
    runtime..newproc //create a new goroutine to start program
      runtime/proc.c::runtime..shced

    runtime..mstart //start this M   ここで-vの出力が走る
        runtime..mstart()
          runtime..gosave()
          runtime..asminit()
          runtime..minit()
          runtime..initsig()
          m->mstartfn()
          schedule()
            stopm()

      runtime..starttheworld(void)

proc bootstrap ::

  // The bootstrap sequence is:
  //
  //      call osinit
  //      call schedinit
  //      make & queue new G
  //      call runtime·mstart
  //
  // The new G calls runtime·main.



===============================================================================

starttheworld
stoptheworld
freezetheworld


stoptheworld
M
P
G



stopm
===============================================================================

callback ::

  execute(gp)
    resetspinning()




===============================================================================
===============================================================================


*******************************************************************************

native thread
===============================================================================


===============================================================================
