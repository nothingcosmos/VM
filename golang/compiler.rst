go compiler
###############################################################################

キーワードを足がかりに検索してみる。

largemodel

peephole

optimizations


調べるのは
gc cc 6g 

option
*******************************************************************************

こんな感じで分岐する

debug['P'] Peephole
debug['N'] optimize
debug['l'] inlining


optimization
===============================================================================

grep ::

  cc/lex.c: flagcount("N", "disable optimizations", &debug['N']);
  cc/pgen.c:  if(!debug['N'] || debug['R'] || debug['P'])
  gc/lex.c: flagcount("N", "disable optimizations", &debug['N']);
  gc/lex.c: if(!debug['N'])
  gc/gen.c:   if(debug['N'] && n->esc != EscUnknown)
  gc/gen.c:     if(!debug['N'])
  gc/pgen.c:  if(!debug['N'] || debug['R'] || debug['P']) {
  gc/typecheck.c:   if(debug['N'] && !(top & Eindir) && !n->etype)
  gc/typecheck.c:       if(debug['N'])


gen.c ::

  EscUnknown fatal("without escape analysis, only PAUTO's should have esc: %N", n);

  n->esc = EscHeap

エスケープ解析をAST上のNodeのTreeを辿り(walk)ながら行っている。

go.h ::

  EscUnknown
  EscHeap     esc(h)
  EscScope    esc(s)
  EscNone     esc(no)
  EscReturn
  EscNever    esc(N)
  EscBits
  EscMask

  visit
    analyze
      esctag
        escflood
          escwalk

  escloopdepth

walk.c 
newしている箇所(Node)において、
escNoneの場合callnewの代わりに、stackにtempを確保する

参照型のsliceも対象っぽい。


gc/pgen.c ::

  regopt() //peephole or register optimizer
  nilopt()

  expandchecks()

gc/typecheck.c ::

  addrescapes() //これはescapeすると強制判定

cc/pgen.c ::

  regopt()

gc/lex
===============================================================================

main ::

  Phase 1: 
  Phase 2: variable assignments, to interface assm
  Phase 3: type check function bodies
  Phase 4: Inlining
    typecheckinl()
    caninl()
    inlcalls()
  Phase 5: Escape analysis
  escapes()
  movelarge()
    if n->class == PAUTO and type != T nad width > MaxStacVarSize
      addrescapes(n)

  Phase 6: Compile top level
    funccompile()
    fninit(xtop)

  Phase 7: Check external declarations
    typecheck

  dumpobj()

funccompile(Node *, isclosure)
===============================================================================

必要なstack sizeの見積りを行ってからcompile

compile(Node * ) //pgen


gen  NodeがTree構造
pgen レジスタ割付してアセンブリ
portable code generator


===============================================================================

template ::
  ###############################################################################
  *******************************************************************************
  ===============================================================================

