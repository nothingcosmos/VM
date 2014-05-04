├── include
│   ├── README
│   ├── ar.h
│   ├── bio.h
│   ├── bootexec.h
│   ├── fmt.h
│   ├── libc.h
│   ├── mach.h
│   ├── plan9
│   │   ├── 386
│   │   │   └── u.h
│   │   ├── amd64
│   │   │   └── u.h
│   │   ├── arm
│   │   │   └── u.h
│   │   ├── libc.h
│   │   ├── mach.h
│   │   ├── ureg_amd64.h
│   │   ├── ureg_arm.h
│   │   └── ureg_x86.h
│   ├── u.h
│   ├── ureg_amd64.h
│   ├── ureg_arm.h
│   ├── ureg_x86.h
│   └── utf.h

├── src
│   ├── Make.dist
│   ├── all.bash
│   ├── all.bat
│   ├── all.rc
│   ├── clean.bash
│   ├── clean.bat
│   ├── clean.rc
│   ├── cmd
│   │   ├── 5a
│   │   │   ├── Makefile
│   │   │   ├── a.h
│   │   │   ├── a.y
│   │   │   ├── doc.go
│   │   │   ├── lex.c
│   │   │   ├── y.tab.c
│   │   │   └── y.tab.h
│   │   ├── 5c
│   │   │   ├── Makefile
│   │   │   ├── cgen.c
│   │   │   ├── doc.go
│   │   │   ├── gc.h
│   │   │   ├── list.c
│   │   │   ├── mul.c
│   │   │   ├── peep.c
│   │   │   ├── reg.c
│   │   │   ├── sgen.c
│   │   │   ├── swt.c
│   │   │   └── txt.c
│   │   ├── 5g
│   │   │   ├── Makefile
│   │   │   ├── cgen.c
│   │   │   ├── cgen64.c
│   │   │   ├── doc.go
│   │   │   ├── galign.c
│   │   │   ├── gg.h
│   │   │   ├── ggen.c
│   │   │   ├── gobj.c
│   │   │   ├── gsubr.c
│   │   │   ├── list.c
│   │   │   ├── opt.h
│   │   │   ├── peep.c
│   │   │   ├── prog.c
│   │   │   └── reg.c
│   │   ├── 5l
│   │   │   ├── 5.out.h
│   │   │   ├── Makefile
│   │   │   ├── asm.c
│   │   │   ├── doc.go
│   │   │   ├── l.h
│   │   │   ├── list.c
│   │   │   ├── mkenam
│   │   │   ├── noop.c
│   │   │   ├── obj.c
│   │   │   ├── optab.c
│   │   │   ├── pass.c
│   │   │   ├── prof.c
│   │   │   ├── softfloat.c
│   │   │   └── span.c
│   │   ├── 6a
│   │   │   ├── Makefile
│   │   │   ├── a.h
│   │   │   ├── a.y
│   │   │   ├── doc.go
│   │   │   ├── lex.c
│   │   │   ├── y.tab.c
│   │   │   └── y.tab.h
│   │   ├── 6c
│   │   │   ├── Makefile
│   │   │   ├── cgen.c
│   │   │   ├── div.c
│   │   │   ├── doc.go
│   │   │   ├── gc.h
│   │   │   ├── list.c
│   │   │   ├── machcap.c
│   │   │   ├── mul.c
│   │   │   ├── peep.c
│   │   │   ├── reg.c
│   │   │   ├── sgen.c
│   │   │   ├── swt.c
│   │   │   └── txt.c
│   │   ├── 6g
│   │   │   ├── Makefile
│   │   │   ├── cgen.c
│   │   │   ├── doc.go
│   │   │   ├── galign.c
│   │   │   ├── gg.h
│   │   │   ├── ggen.c
│   │   │   ├── gobj.c
│   │   │   ├── gsubr.c
│   │   │   ├── list.c
│   │   │   ├── opt.h
│   │   │   ├── peep.c
│   │   │   ├── prog.c
│   │   │   └── reg.c
│   │   ├── 6l
│   │   │   ├── 6.out.h
│   │   │   ├── Makefile
│   │   │   ├── asm.c
│   │   │   ├── doc.go
│   │   │   ├── l.h
│   │   │   ├── list.c
│   │   │   ├── mkenam
│   │   │   ├── obj.c
│   │   │   ├── optab.c
│   │   │   ├── pass.c
│   │   │   ├── prof.c
│   │   │   └── span.c
│   │   ├── 8a
│   │   │   ├── Makefile
│   │   │   ├── a.h
│   │   │   ├── a.y
│   │   │   ├── doc.go
│   │   │   ├── lex.c
│   │   │   ├── y.tab.c
│   │   │   └── y.tab.h
│   │   ├── 8c
│   │   │   ├── Makefile
│   │   │   ├── cgen.c
│   │   │   ├── cgen64.c
│   │   │   ├── div.c
│   │   │   ├── doc.go
│   │   │   ├── gc.h
│   │   │   ├── list.c
│   │   │   ├── machcap.c
│   │   │   ├── mul.c
│   │   │   ├── peep.c
│   │   │   ├── reg.c
│   │   │   ├── sgen.c
│   │   │   ├── swt.c
│   │   │   └── txt.c
│   │   ├── 8g
│   │   │   ├── Makefile
│   │   │   ├── cgen.c
│   │   │   ├── cgen64.c
│   │   │   ├── doc.go
│   │   │   ├── galign.c
│   │   │   ├── gg.h
│   │   │   ├── ggen.c
│   │   │   ├── gobj.c
│   │   │   ├── gsubr.c
│   │   │   ├── list.c
│   │   │   ├── opt.h
│   │   │   ├── peep.c
│   │   │   ├── prog.c
│   │   │   └── reg.c
│   │   ├── 8l
│   │   │   ├── 8.out.h
│   │   │   ├── Makefile
│   │   │   ├── asm.c
│   │   │   ├── doc.go
│   │   │   ├── l.h
│   │   │   ├── list.c
│   │   │   ├── mkenam
│   │   │   ├── obj.c
│   │   │   ├── optab.c
│   │   │   ├── pass.c
│   │   │   ├── prof.c
│   │   │   └── span.c
│   │   ├── addr2line
│   │   │   └── main.c
│   │   ├── api
│   │   │   ├── goapi.go
│   │   │   ├── goapi_test.go
│   │   │   ├── run.go
│   │   │   └── testdata
│   │   │       └── src
│   │   │           └── pkg
│   │   │               ├── p1
│   │   │               │   ├── golden.txt
│   │   │               │   └── p1.go
│   │   │               ├── p2
│   │   │               │   ├── golden.txt
│   │   │               │   └── p2.go
│   │   │               └── p3
│   │   │                   ├── golden.txt
│   │   │                   └── p3.go
│   │   ├── cc
│   │   │   ├── Makefile
│   │   │   ├── acid.c
│   │   │   ├── bits.c
│   │   │   ├── bv.c
│   │   │   ├── cc.h
│   │   │   ├── cc.y
│   │   │   ├── com.c
│   │   │   ├── com64.c
│   │   │   ├── dcl.c
│   │   │   ├── doc.go
│   │   │   ├── dpchk.c
│   │   │   ├── funct.c
│   │   │   ├── godefs.c
│   │   │   ├── lex.c
│   │   │   ├── lexbody
│   │   │   ├── mac.c
│   │   │   ├── macbody
│   │   │   ├── omachcap.c
│   │   │   ├── pgen.c
│   │   │   ├── pswt.c
│   │   │   ├── scon.c
│   │   │   ├── sub.c
│   │   │   ├── y.tab.c
│   │   │   └── y.tab.h
│   │   ├── cgo
│   │   │   ├── ast.go
│   │   │   ├── doc.go
│   │   │   ├── gcc.go
│   │   │   ├── godefs.go
│   │   │   ├── main.go
│   │   │   ├── out.go
│   │   │   └── util.go
│   │   ├── dist
│   │   │   ├── README
│   │   │   ├── a.h
│   │   │   ├── arg.h
│   │   │   ├── arm.c
│   │   │   ├── buf.c
│   │   │   ├── build.c
│   │   │   ├── buildgc.c
│   │   │   ├── buildgo.c
│   │   │   ├── buildruntime.c
│   │   │   ├── goc2c.c
│   │   │   ├── main.c
│   │   │   ├── plan9.c
│   │   │   ├── unix.c
│   │   │   └── windows.c
│   │   ├── fix
│   │   │   ├── doc.go
│   │   │   ├── fix.go
│   │   │   ├── import_test.go
│   │   │   ├── main.go
│   │   │   ├── main_test.go
│   │   │   ├── netipv6zone.go
│   │   │   ├── netipv6zone_test.go
│   │   │   ├── printerconfig.go
│   │   │   ├── printerconfig_test.go
│   │   │   └── typecheck.go
│   │   ├── gc
│   │   │   ├── Makefile
│   │   │   ├── align.c
│   │   │   ├── bisonerrors
│   │   │   ├── bits.c
│   │   │   ├── builtin.c
│   │   │   ├── bv.c
│   │   │   ├── closure.c
│   │   │   ├── const.c
│   │   │   ├── cplx.c
│   │   │   ├── dcl.c
│   │   │   ├── doc.go
│   │   │   ├── esc.c
│   │   │   ├── export.c
│   │   │   ├── fmt.c
│   │   │   ├── gen.c
│   │   │   ├── go.errors
│   │   │   ├── go.h
│   │   │   ├── go.y
│   │   │   ├── init.c
│   │   │   ├── inl.c
│   │   │   ├── lex.c
│   │   │   ├── md5.c
│   │   │   ├── md5.h
│   │   │   ├── mkbuiltin
│   │   │   ├── mkbuiltin1.c
│   │   │   ├── mkopnames
│   │   │   ├── mparith1.c
│   │   │   ├── mparith2.c
│   │   │   ├── mparith3.c
│   │   │   ├── obj.c
│   │   │   ├── order.c
│   │   │   ├── pgen.c
│   │   │   ├── popt.c
│   │   │   ├── popt.h
│   │   │   ├── racewalk.c
│   │   │   ├── range.c
│   │   │   ├── reflect.c
│   │   │   ├── runtime.go
│   │   │   ├── select.c
│   │   │   ├── sinit.c
│   │   │   ├── subr.c
│   │   │   ├── swt.c
│   │   │   ├── typecheck.c
│   │   │   ├── unsafe.c
│   │   │   ├── unsafe.go
│   │   │   ├── walk.c
│   │   │   ├── y.tab.c
│   │   │   ├── y.tab.h
│   │   │   └── yerr.h
│   │   ├── go
│   │   │   ├── bootstrap.go
│   │   │   ├── build.go
│   │   │   ├── clean.go
│   │   │   ├── discovery.go
│   │   │   ├── doc.go
│   │   │   ├── env.go
│   │   │   ├── fix.go
│   │   │   ├── fmt.go
│   │   │   ├── get.go
│   │   │   ├── go11.go
│   │   │   ├── help.go
│   │   │   ├── http.go
│   │   │   ├── list.go
│   │   │   ├── main.go
│   │   │   ├── match_test.go
│   │   │   ├── mkdoc.sh
│   │   │   ├── pkg.go
│   │   │   ├── run.go
│   │   │   ├── script
│   │   │   ├── script.txt
│   │   │   ├── signal.go
│   │   │   ├── signal_notunix.go
│   │   │   ├── signal_unix.go
│   │   │   ├── tag_test.go
│   │   │   ├── test.bash
│   │   │   ├── test.go
│   │   │   ├── testdata
│   │   │   │   ├── example1_test.go
│   │   │   │   ├── example2_test.go
│   │   │   │   ├── local
│   │   │   │   │   ├── easy.go
│   │   │   │   │   ├── easysub
│   │   │   │   │   │   ├── easysub.go
│   │   │   │   │   │   └── main.go
│   │   │   │   │   ├── hard.go
│   │   │   │   │   └── sub
│   │   │   │   │       ├── sub
│   │   │   │   │       │   └── subsub.go
│   │   │   │   │       └── sub.go
│   │   │   │   ├── shadow
│   │   │   │   │   ├── root1
│   │   │   │   │   │   └── src
│   │   │   │   │   │       ├── foo
│   │   │   │   │   │       │   └── foo.go
│   │   │   │   │   │       └── math
│   │   │   │   │   │           └── math.go
│   │   │   │   │   └── root2
│   │   │   │   │       └── src
│   │   │   │   │           └── foo
│   │   │   │   │               └── foo.go
│   │   │   │   ├── src
│   │   │   │   │   ├── badpkg
│   │   │   │   │   │   └── x.go
│   │   │   │   │   ├── cgotest
│   │   │   │   │   │   └── m.go
│   │   │   │   │   ├── go-cmd-test
│   │   │   │   │   │   └── helloworld.go
│   │   │   │   │   ├── main_test
│   │   │   │   │   │   ├── m.go
│   │   │   │   │   │   └── m_test.go
│   │   │   │   │   └── syntaxerror
│   │   │   │   │       ├── x.go
│   │   │   │   │       └── x_test.go
│   │   │   │   └── testimport
│   │   │   │       ├── p.go
│   │   │   │       ├── p1
│   │   │   │       │   └── p1.go
│   │   │   │       ├── p2
│   │   │   │       │   └── p2.go
│   │   │   │       ├── p_test.go
│   │   │   │       └── x_test.go
│   │   │   ├── testflag.go
│   │   │   ├── tool.go
│   │   │   ├── vcs.go
│   │   │   ├── version.go
│   │   │   └── vet.go
│   │   ├── ld
│   │   │   ├── data.c
│   │   │   ├── decodesym.c
│   │   │   ├── doc.go
│   │   │   ├── dwarf.c
│   │   │   ├── dwarf.h
│   │   │   ├── dwarf_defs.h
│   │   │   ├── elf.c
│   │   │   ├── elf.h
│   │   │   ├── go.c
│   │   │   ├── ldelf.c
│   │   │   ├── ldmacho.c
│   │   │   ├── ldpe.c
│   │   │   ├── lib.c
│   │   │   ├── lib.h
│   │   │   ├── macho.c
│   │   │   ├── macho.h
│   │   │   ├── pe.c
│   │   │   ├── pe.h
│   │   │   ├── symtab.c
│   │   │   └── textflag.h
│   │   ├── nm
│   │   │   ├── Makefile
│   │   │   ├── doc.go
│   │   │   └── nm.c
│   │   ├── objdump
│   │   │   └── main.c
│   │   ├── pack
│   │   │   ├── Makefile
│   │   │   ├── ar.c
│   │   │   └── doc.go
│   │   └── yacc
│   │       ├── Makefile
│   │       ├── doc.go
│   │       ├── expr.y
│   │       └── yacc.go
│   ├── lib9
│   │   ├── Makefile
│   │   ├── _exits.c
│   │   ├── _p9dir.c
│   │   ├── atoi.c
│   │   ├── await.c
│   │   ├── cleanname.c
│   │   ├── create.c
│   │   ├── ctime.c
│   │   ├── dirfstat.c
│   │   ├── dirfwstat.c
│   │   ├── dirstat.c
│   │   ├── dirwstat.c
│   │   ├── dup.c
│   │   ├── errstr.c
│   │   ├── exec.c
│   │   ├── execl.c
│   │   ├── exitcode.c
│   │   ├── exits.c
│   │   ├── flag.c
│   │   ├── fmt
│   │   │   ├── charstod.c
│   │   │   ├── dofmt.c
│   │   │   ├── dorfmt.c
│   │   │   ├── fltfmt.c
│   │   │   ├── fmt.c
│   │   │   ├── fmtdef.h
│   │   │   ├── fmtfd.c
│   │   │   ├── fmtfdflush.c
│   │   │   ├── fmtlocale.c
│   │   │   ├── fmtlock.c
│   │   │   ├── fmtnull.c
│   │   │   ├── fmtprint.c
│   │   │   ├── fmtquote.c
│   │   │   ├── fmtrune.c
│   │   │   ├── fmtstr.c
│   │   │   ├── fmtvprint.c
│   │   │   ├── fprint.c
│   │   │   ├── nan64.c
│   │   │   ├── pow10.c
│   │   │   ├── print.c
│   │   │   ├── seprint.c
│   │   │   ├── smprint.c
│   │   │   ├── snprint.c
│   │   │   ├── sprint.c
│   │   │   ├── strtod.c
│   │   │   ├── test.c
│   │   │   ├── vfprint.c
│   │   │   ├── vseprint.c
│   │   │   ├── vsmprint.c
│   │   │   └── vsnprint.c
│   │   ├── fmtlock2.c
│   │   ├── getenv.c
│   │   ├── getfields.c
│   │   ├── getwd.c
│   │   ├── goos.c
│   │   ├── jmp.c
│   │   ├── main.c
│   │   ├── nan.c
│   │   ├── notify.c
│   │   ├── nulldir.c
│   │   ├── open.c
│   │   ├── readn.c
│   │   ├── rfork.c
│   │   ├── run_plan9.c
│   │   ├── run_unix.c
│   │   ├── run_windows.c
│   │   ├── seek.c
│   │   ├── strecpy.c
│   │   ├── sysfatal.c
│   │   ├── tempdir_plan9.c
│   │   ├── tempdir_unix.c
│   │   ├── tempdir_windows.c
│   │   ├── time.c
│   │   ├── tokenize.c
│   │   ├── utf
│   │   │   ├── Makefile
│   │   │   ├── mkrunetype.c
│   │   │   ├── rune.c
│   │   │   ├── runetype.c
│   │   │   ├── runetypebody-6.2.0.h
│   │   │   ├── utf.h
│   │   │   ├── utfdef.h
│   │   │   ├── utfecpy.c
│   │   │   ├── utflen.c
│   │   │   ├── utfnlen.c
│   │   │   ├── utfrrune.c
│   │   │   ├── utfrune.c
│   │   │   └── utfutf.c
│   │   ├── win.h
│   │   └── windows.c
│   ├── libbio
│   │   ├── Makefile
│   │   ├── bbuffered.c
│   │   ├── bfildes.c
│   │   ├── bflush.c
│   │   ├── bgetc.c
│   │   ├── bgetd.c
│   │   ├── bgetrune.c
│   │   ├── binit.c
│   │   ├── boffset.c
│   │   ├── bprint.c
│   │   ├── bputc.c
│   │   ├── bputrune.c
│   │   ├── brdline.c
│   │   ├── brdstr.c
│   │   ├── bread.c
│   │   ├── bseek.c
│   │   └── bwrite.c
│   ├── libmach
│   │   ├── 5.c
│   │   ├── 5db.c
│   │   ├── 5obj.c
│   │   ├── 6.c
│   │   ├── 6obj.c
│   │   ├── 8.c
│   │   ├── 8db.c
│   │   ├── 8obj.c
│   │   ├── Makefile
│   │   ├── access.c
│   │   ├── darwin.c
│   │   ├── dragonfly.c
│   │   ├── elf.h
│   │   ├── executable.c
│   │   ├── fakeobj.c
│   │   ├── freebsd.c
│   │   ├── linux.c
│   │   ├── machdata.c
│   │   ├── macho.h
│   │   ├── map.c
│   │   ├── netbsd.c
│   │   ├── obj.c
│   │   ├── obj.h
│   │   ├── openbsd.c
│   │   ├── plan9.c
│   │   ├── setmach.c
│   │   ├── swap.c
│   │   ├── sym.c
│   │   └── windows.c
│   ├── make.bash
│   ├── make.bat
│   ├── make.rc
│   ├── pkg
│   │   ├── archive
│   │   │   ├── tar
│   │   │   │   ├── common.go
│   │   │   │   ├── example_test.go
│   │   │   │   ├── reader.go
│   │   │   │   ├── reader_test.go
│   │   │   │   ├── stat_atim.go
│   │   │   │   ├── stat_atimespec.go
│   │   │   │   ├── stat_unix.go
│   │   │   │   ├── tar_test.go
│   │   │   │   ├── testdata
│   │   │   │   │   ├── gnu.tar
│   │   │   │   │   ├── nil-uid.tar
│   │   │   │   │   ├── pax.tar
│   │   │   │   │   ├── small.txt
│   │   │   │   │   ├── small2.txt
│   │   │   │   │   ├── star.tar
│   │   │   │   │   ├── ustar.tar
│   │   │   │   │   ├── v7.tar
│   │   │   │   │   ├── writer-big.tar
│   │   │   │   │   └── writer.tar
│   │   │   │   ├── writer.go
│   │   │   │   └── writer_test.go
│   │   │   └── zip
│   │   │       ├── example_test.go
│   │   │       ├── reader.go
│   │   │       ├── reader_test.go
│   │   │       ├── register.go
│   │   │       ├── struct.go
│   │   │       ├── testdata
│   │   │       │   ├── crc32-not-streamed.zip
│   │   │       │   ├── dd.zip
│   │   │       │   ├── go-no-datadesc-sig.zip
│   │   │       │   ├── go-with-datadesc-sig.zip
│   │   │       │   ├── gophercolor16x16.png
│   │   │       │   ├── readme.notzip
│   │   │       │   ├── readme.zip
│   │   │       │   ├── symlink.zip
│   │   │       │   ├── test-trailing-junk.zip
│   │   │       │   ├── test.zip
│   │   │       │   ├── unix.zip
│   │   │       │   ├── winxp.zip
│   │   │       │   └── zip64.zip
│   │   │       ├── writer.go
│   │   │       ├── writer_test.go
│   │   │       └── zip_test.go
│   │   ├── bufio
│   │   │   ├── bufio.go
│   │   │   ├── bufio_test.go
│   │   │   ├── example_test.go
│   │   │   ├── export_test.go
│   │   │   ├── scan.go
│   │   │   └── scan_test.go
│   │   ├── builtin
│   │   │   └── builtin.go
│   │   ├── bytes
│   │   │   ├── buffer.go
│   │   │   ├── buffer_test.go
│   │   │   ├── bytes.go
│   │   │   ├── bytes.s
│   │   │   ├── bytes_decl.go
│   │   │   ├── bytes_test.go
│   │   │   ├── compare_test.go
│   │   │   ├── equal_test.go
│   │   │   ├── example_test.go
│   │   │   ├── export_test.go
│   │   │   ├── reader.go
│   │   │   └── reader_test.go
│   │   ├── compress
│   │   │   ├── bzip2
│   │   │   │   ├── bit_reader.go
│   │   │   │   ├── bzip2.go
│   │   │   │   ├── bzip2_test.go
│   │   │   │   ├── huffman.go
│   │   │   │   ├── move_to_front.go
│   │   │   │   └── testdata
│   │   │   │       ├── Mark.Twain-Tom.Sawyer.txt.bz2
│   │   │   │       └── e.txt.bz2
│   │   │   ├── flate
│   │   │   │   ├── copy.go
│   │   │   │   ├── copy_test.go
│   │   │   │   ├── deflate.go
│   │   │   │   ├── deflate_test.go
│   │   │   │   ├── fixedhuff.go
│   │   │   │   ├── flate_test.go
│   │   │   │   ├── gen.go
│   │   │   │   ├── huffman_bit_writer.go
│   │   │   │   ├── huffman_code.go
│   │   │   │   ├── inflate.go
│   │   │   │   ├── reader_test.go
│   │   │   │   ├── reverse_bits.go
│   │   │   │   ├── token.go
│   │   │   │   └── writer_test.go
│   │   │   ├── gzip
│   │   │   │   ├── gunzip.go
│   │   │   │   ├── gunzip_test.go
│   │   │   │   ├── gzip.go
│   │   │   │   ├── gzip_test.go
│   │   │   │   └── testdata
│   │   │   │       └── issue6550.gz
│   │   │   ├── lzw
│   │   │   │   ├── reader.go
│   │   │   │   ├── reader_test.go
│   │   │   │   ├── writer.go
│   │   │   │   └── writer_test.go
│   │   │   ├── testdata
│   │   │   │   ├── Mark.Twain-Tom.Sawyer.txt
│   │   │   │   ├── e.txt
│   │   │   │   └── pi.txt
│   │   │   └── zlib
│   │   │       ├── example_test.go
│   │   │       ├── reader.go
│   │   │       ├── reader_test.go
│   │   │       ├── writer.go
│   │   │       └── writer_test.go
│   │   ├── container
│   │   │   ├── heap
│   │   │   │   ├── example_intheap_test.go
│   │   │   │   ├── example_pq_test.go
│   │   │   │   ├── heap.go
│   │   │   │   └── heap_test.go
│   │   │   ├── list
│   │   │   │   ├── example_test.go
│   │   │   │   ├── list.go
│   │   │   │   └── list_test.go
│   │   │   └── ring
│   │   │       ├── ring.go
│   │   │       └── ring_test.go
│   │   ├── crypto
│   │   │   ├── aes
│   │   │   │   ├── aes_test.go
│   │   │   │   ├── asm_amd64.s
│   │   │   │   ├── block.go
│   │   │   │   ├── cipher.go
│   │   │   │   ├── cipher_asm.go
│   │   │   │   ├── cipher_generic.go
│   │   │   │   └── const.go
│   │   │   ├── cipher
│   │   │   │   ├── cbc.go
│   │   │   │   ├── cbc_aes_test.go
│   │   │   │   ├── cfb.go
│   │   │   │   ├── cfb_test.go
│   │   │   │   ├── cipher.go
│   │   │   │   ├── cipher_test.go
│   │   │   │   ├── common_test.go
│   │   │   │   ├── ctr.go
│   │   │   │   ├── ctr_aes_test.go
│   │   │   │   ├── example_test.go
│   │   │   │   ├── gcm.go
│   │   │   │   ├── gcm_test.go
│   │   │   │   ├── io.go
│   │   │   │   ├── ofb.go
│   │   │   │   └── ofb_test.go
│   │   │   ├── crypto.go
│   │   │   ├── des
│   │   │   │   ├── block.go
│   │   │   │   ├── cipher.go
│   │   │   │   ├── const.go
│   │   │   │   ├── des_test.go
│   │   │   │   └── example_test.go
│   │   │   ├── dsa
│   │   │   │   ├── dsa.go
│   │   │   │   └── dsa_test.go
│   │   │   ├── ecdsa
│   │   │   │   ├── ecdsa.go
│   │   │   │   ├── ecdsa_test.go
│   │   │   │   └── testdata
│   │   │   │       └── SigVer.rsp.bz2
│   │   │   ├── elliptic
│   │   │   │   ├── elliptic.go
│   │   │   │   ├── elliptic_test.go
│   │   │   │   ├── p224.go
│   │   │   │   ├── p224_test.go
│   │   │   │   └── p256.go
│   │   │   ├── hmac
│   │   │   │   ├── hmac.go
│   │   │   │   └── hmac_test.go
│   │   │   ├── md5
│   │   │   │   ├── example_test.go
│   │   │   │   ├── gen.go
│   │   │   │   ├── md5.go
│   │   │   │   ├── md5_test.go
│   │   │   │   ├── md5block.go
│   │   │   │   ├── md5block_386.s
│   │   │   │   ├── md5block_amd64.s
│   │   │   │   ├── md5block_arm.s
│   │   │   │   └── md5block_decl.go
│   │   │   ├── rand
│   │   │   │   ├── example_test.go
│   │   │   │   ├── rand.go
│   │   │   │   ├── rand_test.go
│   │   │   │   ├── rand_unix.go
│   │   │   │   ├── rand_windows.go
│   │   │   │   └── util.go
│   │   │   ├── rc4
│   │   │   │   ├── rc4.go
│   │   │   │   ├── rc4_386.s
│   │   │   │   ├── rc4_amd64.s
│   │   │   │   ├── rc4_arm.s
│   │   │   │   ├── rc4_asm.go
│   │   │   │   ├── rc4_ref.go
│   │   │   │   └── rc4_test.go
│   │   │   ├── rsa
│   │   │   │   ├── pkcs1v15.go
│   │   │   │   ├── pkcs1v15_test.go
│   │   │   │   ├── pss.go
│   │   │   │   ├── pss_test.go
│   │   │   │   ├── rsa.go
│   │   │   │   ├── rsa_test.go
│   │   │   │   └── testdata
│   │   │   │       └── pss-vect.txt.bz2
│   │   │   ├── sha1
│   │   │   │   ├── example_test.go
│   │   │   │   ├── sha1.go
│   │   │   │   ├── sha1_test.go
│   │   │   │   ├── sha1block.go
│   │   │   │   ├── sha1block_386.s
│   │   │   │   ├── sha1block_amd64.s
│   │   │   │   └── sha1block_decl.go
│   │   │   ├── sha256
│   │   │   │   ├── sha256.go
│   │   │   │   ├── sha256_test.go
│   │   │   │   └── sha256block.go
│   │   │   ├── sha512
│   │   │   │   ├── sha512.go
│   │   │   │   ├── sha512_test.go
│   │   │   │   └── sha512block.go
│   │   │   ├── subtle
│   │   │   │   ├── constant_time.go
│   │   │   │   └── constant_time_test.go
│   │   │   ├── tls
│   │   │   │   ├── alert.go
│   │   │   │   ├── cipher_suites.go
│   │   │   │   ├── common.go
│   │   │   │   ├── conn.go
│   │   │   │   ├── conn_test.go
│   │   │   │   ├── generate_cert.go
│   │   │   │   ├── handshake_client.go
│   │   │   │   ├── handshake_client_test.go
│   │   │   │   ├── handshake_messages.go
│   │   │   │   ├── handshake_messages_test.go
│   │   │   │   ├── handshake_server.go
│   │   │   │   ├── handshake_server_test.go
│   │   │   │   ├── key_agreement.go
│   │   │   │   ├── prf.go
│   │   │   │   ├── prf_test.go
│   │   │   │   ├── ticket.go
│   │   │   │   ├── tls.go
│   │   │   │   └── tls_test.go
│   │   │   └── x509
│   │   │       ├── cert_pool.go
│   │   │       ├── pem_decrypt.go
│   │   │       ├── pem_decrypt_test.go
│   │   │       ├── pkcs1.go
│   │   │       ├── pkcs8.go
│   │   │       ├── pkcs8_test.go
│   │   │       ├── pkix
│   │   │       │   └── pkix.go
│   │   │       ├── root.go
│   │   │       ├── root_darwin.go
│   │   │       ├── root_plan9.go
│   │   │       ├── root_stub.go
│   │   │       ├── root_unix.go
│   │   │       ├── root_windows.go
│   │   │       ├── sec1.go
│   │   │       ├── sec1_test.go
│   │   │       ├── verify.go
│   │   │       ├── verify_test.go
│   │   │       ├── x509.go
│   │   │       └── x509_test.go
│   │   ├── database
│   │   │   └── sql
│   │   │       ├── convert.go
│   │   │       ├── convert_test.go
│   │   │       ├── doc.txt
│   │   │       ├── driver
│   │   │       │   ├── driver.go
│   │   │       │   ├── types.go
│   │   │       │   └── types_test.go
│   │   │       ├── example_test.go
│   │   │       ├── fakedb_test.go
│   │   │       ├── sql.go
│   │   │       └── sql_test.go
│   │   ├── debug
│   │   │   ├── dwarf
│   │   │   │   ├── buf.go
│   │   │   │   ├── const.go
│   │   │   │   ├── entry.go
│   │   │   │   ├── open.go
│   │   │   │   ├── testdata
│   │   │   │   │   ├── typedef.c
│   │   │   │   │   ├── typedef.elf
│   │   │   │   │   └── typedef.macho
│   │   │   │   ├── type.go
│   │   │   │   ├── type_test.go
│   │   │   │   └── unit.go
│   │   │   ├── elf
│   │   │   │   ├── elf.go
│   │   │   │   ├── elf_test.go
│   │   │   │   ├── file.go
│   │   │   │   ├── file_test.go
│   │   │   │   └── testdata
│   │   │   │       ├── gcc-386-freebsd-exec
│   │   │   │       ├── gcc-amd64-linux-exec
│   │   │   │       ├── gcc-amd64-openbsd-debug-with-rela.obj
│   │   │   │       ├── go-relocation-test-gcc424-x86-64.obj
│   │   │   │       ├── go-relocation-test-gcc441-x86-64.obj
│   │   │   │       ├── go-relocation-test-gcc441-x86.obj
│   │   │   │       └── hello-world-core.gz
│   │   │   ├── gosym
│   │   │   │   ├── pclinetest.asm
│   │   │   │   ├── pclinetest.h
│   │   │   │   ├── pclntab.go
│   │   │   │   ├── pclntab_test.go
│   │   │   │   └── symtab.go
│   │   │   ├── macho
│   │   │   │   ├── file.go
│   │   │   │   ├── file_test.go
│   │   │   │   ├── macho.go
│   │   │   │   └── testdata
│   │   │   │       ├── gcc-386-darwin-exec
│   │   │   │       ├── gcc-amd64-darwin-exec
│   │   │   │       ├── gcc-amd64-darwin-exec-debug
│   │   │   │       └── hello.c
│   │   │   └── pe
│   │   │       ├── file.go
│   │   │       ├── file_test.go
│   │   │       ├── pe.go
│   │   │       └── testdata
│   │   │           ├── gcc-386-mingw-exec
│   │   │           ├── gcc-386-mingw-obj
│   │   │           └── hello.c
│   │   ├── encoding
│   │   │   ├── ascii85
│   │   │   │   ├── ascii85.go
│   │   │   │   └── ascii85_test.go
│   │   │   ├── asn1
│   │   │   │   ├── asn1.go
│   │   │   │   ├── asn1_test.go
│   │   │   │   ├── common.go
│   │   │   │   ├── marshal.go
│   │   │   │   └── marshal_test.go
│   │   │   ├── base32
│   │   │   │   ├── base32.go
│   │   │   │   ├── base32_test.go
│   │   │   │   └── example_test.go
│   │   │   ├── base64
│   │   │   │   ├── base64.go
│   │   │   │   ├── base64_test.go
│   │   │   │   └── example_test.go
│   │   │   ├── binary
│   │   │   │   ├── binary.go
│   │   │   │   ├── binary_test.go
│   │   │   │   ├── example_test.go
│   │   │   │   ├── varint.go
│   │   │   │   └── varint_test.go
│   │   │   ├── csv
│   │   │   │   ├── reader.go
│   │   │   │   ├── reader_test.go
│   │   │   │   ├── writer.go
│   │   │   │   └── writer_test.go
│   │   │   ├── encoding.go
│   │   │   ├── gob
│   │   │   │   ├── codec_test.go
│   │   │   │   ├── debug.go
│   │   │   │   ├── decode.go
│   │   │   │   ├── decoder.go
│   │   │   │   ├── doc.go
│   │   │   │   ├── dump.go
│   │   │   │   ├── encode.go
│   │   │   │   ├── encoder.go
│   │   │   │   ├── encoder_test.go
│   │   │   │   ├── error.go
│   │   │   │   ├── example_encdec_test.go
│   │   │   │   ├── example_interface_test.go
│   │   │   │   ├── example_test.go
│   │   │   │   ├── gobencdec_test.go
│   │   │   │   ├── timing_test.go
│   │   │   │   ├── type.go
│   │   │   │   └── type_test.go
│   │   │   ├── hex
│   │   │   │   ├── hex.go
│   │   │   │   └── hex_test.go
│   │   │   ├── json
│   │   │   │   ├── bench_test.go
│   │   │   │   ├── decode.go
│   │   │   │   ├── decode_test.go
│   │   │   │   ├── encode.go
│   │   │   │   ├── encode_test.go
│   │   │   │   ├── example_test.go
│   │   │   │   ├── indent.go
│   │   │   │   ├── scanner.go
│   │   │   │   ├── scanner_test.go
│   │   │   │   ├── stream.go
│   │   │   │   ├── stream_test.go
│   │   │   │   ├── tagkey_test.go
│   │   │   │   ├── tags.go
│   │   │   │   ├── tags_test.go
│   │   │   │   └── testdata
│   │   │   │       └── code.json.gz
│   │   │   ├── pem
│   │   │   │   ├── pem.go
│   │   │   │   └── pem_test.go
│   │   │   └── xml
│   │   │       ├── atom_test.go
│   │   │       ├── example_test.go
│   │   │       ├── marshal.go
│   │   │       ├── marshal_test.go
│   │   │       ├── read.go
│   │   │       ├── read_test.go
│   │   │       ├── typeinfo.go
│   │   │       ├── xml.go
│   │   │       └── xml_test.go
│   │   ├── errors
│   │   │   ├── errors.go
│   │   │   ├── errors_test.go
│   │   │   └── example_test.go
│   │   ├── expvar
│   │   │   ├── expvar.go
│   │   │   └── expvar_test.go
│   │   ├── flag
│   │   │   ├── example_test.go
│   │   │   ├── export_test.go
│   │   │   ├── flag.go
│   │   │   └── flag_test.go
│   │   ├── fmt
│   │   │   ├── doc.go
│   │   │   ├── export_test.go
│   │   │   ├── fmt_test.go
│   │   │   ├── format.go
│   │   │   ├── print.go
│   │   │   ├── scan.go
│   │   │   ├── scan_test.go
│   │   │   └── stringer_test.go
│   │   ├── go
│   │   │   ├── ast
│   │   │   │   ├── ast.go
│   │   │   │   ├── ast_test.go
│   │   │   │   ├── commentmap.go
│   │   │   │   ├── commentmap_test.go
│   │   │   │   ├── example_test.go
│   │   │   │   ├── filter.go
│   │   │   │   ├── filter_test.go
│   │   │   │   ├── import.go
│   │   │   │   ├── print.go
│   │   │   │   ├── print_test.go
│   │   │   │   ├── resolve.go
│   │   │   │   ├── scope.go
│   │   │   │   └── walk.go
│   │   │   ├── build
│   │   │   │   ├── build.go
│   │   │   │   ├── build_test.go
│   │   │   │   ├── deps_test.go
│   │   │   │   ├── doc.go
│   │   │   │   ├── read.go
│   │   │   │   ├── read_test.go
│   │   │   │   ├── syslist.go
│   │   │   │   ├── syslist_test.go
│   │   │   │   └── testdata
│   │   │   │       └── other
│   │   │   │           ├── file
│   │   │   │           │   └── file.go
│   │   │   │           └── main.go
│   │   │   ├── doc
│   │   │   │   ├── Makefile
│   │   │   │   ├── comment.go
│   │   │   │   ├── comment_test.go
│   │   │   │   ├── doc.go
│   │   │   │   ├── doc_test.go
│   │   │   │   ├── example.go
│   │   │   │   ├── example_test.go
│   │   │   │   ├── exports.go
│   │   │   │   ├── filter.go
│   │   │   │   ├── headscan.go
│   │   │   │   ├── reader.go
│   │   │   │   ├── synopsis.go
│   │   │   │   ├── synopsis_test.go
│   │   │   │   └── testdata
│   │   │   │       ├── a.0.golden
│   │   │   │       ├── a.1.golden
│   │   │   │       ├── a.2.golden
│   │   │   │       ├── a0.go
│   │   │   │       ├── a1.go
│   │   │   │       ├── b.0.golden
│   │   │   │       ├── b.1.golden
│   │   │   │       ├── b.2.golden
│   │   │   │       ├── b.go
│   │   │   │       ├── benchmark.go
│   │   │   │       ├── bugpara.0.golden
│   │   │   │       ├── bugpara.1.golden
│   │   │   │       ├── bugpara.2.golden
│   │   │   │       ├── bugpara.go
│   │   │   │       ├── c.0.golden
│   │   │   │       ├── c.1.golden
│   │   │   │       ├── c.2.golden
│   │   │   │       ├── c.go
│   │   │   │       ├── d.0.golden
│   │   │   │       ├── d.1.golden
│   │   │   │       ├── d.2.golden
│   │   │   │       ├── d1.go
│   │   │   │       ├── d2.go
│   │   │   │       ├── e.0.golden
│   │   │   │       ├── e.1.golden
│   │   │   │       ├── e.2.golden
│   │   │   │       ├── e.go
│   │   │   │       ├── error1.0.golden
│   │   │   │       ├── error1.1.golden
│   │   │   │       ├── error1.2.golden
│   │   │   │       ├── error1.go
│   │   │   │       ├── error2.0.golden
│   │   │   │       ├── error2.1.golden
│   │   │   │       ├── error2.2.golden
│   │   │   │       ├── error2.go
│   │   │   │       ├── example.go
│   │   │   │       ├── f.0.golden
│   │   │   │       ├── f.1.golden
│   │   │   │       ├── f.2.golden
│   │   │   │       ├── f.go
│   │   │   │       ├── template.txt
│   │   │   │       ├── testing.0.golden
│   │   │   │       ├── testing.1.golden
│   │   │   │       ├── testing.2.golden
│   │   │   │       └── testing.go
│   │   │   ├── format
│   │   │   │   ├── format.go
│   │   │   │   └── format_test.go
│   │   │   ├── parser
│   │   │   │   ├── error_test.go
│   │   │   │   ├── example_test.go
│   │   │   │   ├── interface.go
│   │   │   │   ├── parser.go
│   │   │   │   ├── parser_test.go
│   │   │   │   ├── performance_test.go
│   │   │   │   ├── short_test.go
│   │   │   │   └── testdata
│   │   │   │       ├── commas.src
│   │   │   │       └── issue3106.src
│   │   │   ├── printer
│   │   │   │   ├── example_test.go
│   │   │   │   ├── nodes.go
│   │   │   │   ├── performance_test.go
│   │   │   │   ├── printer.go
│   │   │   │   ├── printer_test.go
│   │   │   │   └── testdata
│   │   │   │       ├── comments.golden
│   │   │   │       ├── comments.input
│   │   │   │       ├── comments.x
│   │   │   │       ├── comments2.golden
│   │   │   │       ├── comments2.input
│   │   │   │       ├── declarations.golden
│   │   │   │       ├── declarations.input
│   │   │   │       ├── empty.golden
│   │   │   │       ├── empty.input
│   │   │   │       ├── expressions.golden
│   │   │   │       ├── expressions.input
│   │   │   │       ├── expressions.raw
│   │   │   │       ├── linebreaks.golden
│   │   │   │       ├── linebreaks.input
│   │   │   │       ├── parser.go
│   │   │   │       ├── slow.golden
│   │   │   │       ├── slow.input
│   │   │   │       ├── statements.golden
│   │   │   │       └── statements.input
│   │   │   ├── scanner
│   │   │   │   ├── errors.go
│   │   │   │   ├── example_test.go
│   │   │   │   ├── scanner.go
│   │   │   │   └── scanner_test.go
│   │   │   └── token
│   │   │       ├── position.go
│   │   │       ├── position_test.go
│   │   │       ├── serialize.go
│   │   │       ├── serialize_test.go
│   │   │       └── token.go
│   │   ├── hash
│   │   │   ├── adler32
│   │   │   │   ├── adler32.go
│   │   │   │   └── adler32_test.go
│   │   │   ├── crc32
│   │   │   │   ├── crc32.go
│   │   │   │   ├── crc32_amd64.go
│   │   │   │   ├── crc32_amd64.s
│   │   │   │   ├── crc32_generic.go
│   │   │   │   └── crc32_test.go
│   │   │   ├── crc64
│   │   │   │   ├── crc64.go
│   │   │   │   └── crc64_test.go
│   │   │   ├── fnv
│   │   │   │   ├── fnv.go
│   │   │   │   └── fnv_test.go
│   │   │   ├── hash.go
│   │   │   ├── test_cases.txt
│   │   │   └── test_gen.awk
│   │   ├── html
│   │   │   ├── entity.go
│   │   │   ├── entity_test.go
│   │   │   ├── escape.go
│   │   │   ├── escape_test.go
│   │   │   └── template
│   │   │       ├── attr.go
│   │   │       ├── clone_test.go
│   │   │       ├── content.go
│   │   │       ├── content_test.go
│   │   │       ├── context.go
│   │   │       ├── css.go
│   │   │       ├── css_test.go
│   │   │       ├── doc.go
│   │   │       ├── error.go
│   │   │       ├── escape.go
│   │   │       ├── escape_test.go
│   │   │       ├── html.go
│   │   │       ├── html_test.go
│   │   │       ├── js.go
│   │   │       ├── js_test.go
│   │   │       ├── template.go
│   │   │       ├── transition.go
│   │   │       ├── url.go
│   │   │       └── url_test.go
│   │   ├── image
│   │   │   ├── color
│   │   │   │   ├── color.go
│   │   │   │   ├── palette
│   │   │   │   │   ├── gen.go
│   │   │   │   │   └── palette.go
│   │   │   │   ├── ycbcr.go
│   │   │   │   └── ycbcr_test.go
│   │   │   ├── decode_example_test.go
│   │   │   ├── decode_test.go
│   │   │   ├── draw
│   │   │   │   ├── bench_test.go
│   │   │   │   ├── clip_test.go
│   │   │   │   ├── draw.go
│   │   │   │   └── draw_test.go
│   │   │   ├── format.go
│   │   │   ├── geom.go
│   │   │   ├── gif
│   │   │   │   ├── reader.go
│   │   │   │   ├── reader_test.go
│   │   │   │   ├── writer.go
│   │   │   │   └── writer_test.go
│   │   │   ├── image.go
│   │   │   ├── image_test.go
│   │   │   ├── jpeg
│   │   │   │   ├── dct_test.go
│   │   │   │   ├── fdct.go
│   │   │   │   ├── huffman.go
│   │   │   │   ├── idct.go
│   │   │   │   ├── reader.go
│   │   │   │   ├── reader_test.go
│   │   │   │   ├── scan.go
│   │   │   │   ├── writer.go
│   │   │   │   └── writer_test.go
│   │   │   ├── names.go
│   │   │   ├── png
│   │   │   │   ├── paeth.go
│   │   │   │   ├── paeth_test.go
│   │   │   │   ├── reader.go
│   │   │   │   ├── reader_test.go
│   │   │   │   ├── testdata
│   │   │   │   │   ├── benchGray.png
│   │   │   │   │   ├── benchNRGBA-gradient.png
│   │   │   │   │   ├── benchNRGBA-opaque.png
│   │   │   │   │   ├── benchPaletted.png
│   │   │   │   │   ├── benchRGB.png
│   │   │   │   │   ├── invalid-crc32.png
│   │   │   │   │   ├── invalid-noend.png
│   │   │   │   │   ├── invalid-trunc.png
│   │   │   │   │   ├── invalid-zlib.png
│   │   │   │   │   └── pngsuite
│   │   │   │   │       ├── README
│   │   │   │   │       ├── README.original
│   │   │   │   │       ├── basn0g01-30.png
│   │   │   │   │       ├── basn0g01-30.sng
│   │   │   │   │       ├── basn0g01.png
│   │   │   │   │       ├── basn0g01.sng
│   │   │   │   │       ├── basn0g02-29.png
│   │   │   │   │       ├── basn0g02-29.sng
│   │   │   │   │       ├── basn0g02.png
│   │   │   │   │       ├── basn0g02.sng
│   │   │   │   │       ├── basn0g04-31.png
│   │   │   │   │       ├── basn0g04-31.sng
│   │   │   │   │       ├── basn0g04.png
│   │   │   │   │       ├── basn0g04.sng
│   │   │   │   │       ├── basn0g08.png
│   │   │   │   │       ├── basn0g08.sng
│   │   │   │   │       ├── basn0g16.png
│   │   │   │   │       ├── basn0g16.sng
│   │   │   │   │       ├── basn2c08.png
│   │   │   │   │       ├── basn2c08.sng
│   │   │   │   │       ├── basn2c16.png
│   │   │   │   │       ├── basn2c16.sng
│   │   │   │   │       ├── basn3p01.png
│   │   │   │   │       ├── basn3p01.sng
│   │   │   │   │       ├── basn3p02.png
│   │   │   │   │       ├── basn3p02.sng
│   │   │   │   │       ├── basn3p04.png
│   │   │   │   │       ├── basn3p04.sng
│   │   │   │   │       ├── basn3p08-trns.png
│   │   │   │   │       ├── basn3p08-trns.sng
│   │   │   │   │       ├── basn3p08.png
│   │   │   │   │       ├── basn3p08.sng
│   │   │   │   │       ├── basn4a08.png
│   │   │   │   │       ├── basn4a08.sng
│   │   │   │   │       ├── basn4a16.png
│   │   │   │   │       ├── basn4a16.sng
│   │   │   │   │       ├── basn6a08.png
│   │   │   │   │       ├── basn6a08.sng
│   │   │   │   │       ├── basn6a16.png
│   │   │   │   │       └── basn6a16.sng
│   │   │   │   ├── writer.go
│   │   │   │   └── writer_test.go
│   │   │   ├── testdata
│   │   │   │   ├── video-001.5bpp.gif
│   │   │   │   ├── video-001.gif
│   │   │   │   ├── video-001.interlaced.gif
│   │   │   │   ├── video-001.jpeg
│   │   │   │   ├── video-001.png
│   │   │   │   ├── video-001.progressive.jpeg
│   │   │   │   ├── video-001.q50.420.jpeg
│   │   │   │   ├── video-001.q50.420.progressive.jpeg
│   │   │   │   ├── video-001.q50.422.jpeg
│   │   │   │   ├── video-001.q50.422.progressive.jpeg
│   │   │   │   ├── video-001.q50.440.jpeg
│   │   │   │   ├── video-001.q50.440.progressive.jpeg
│   │   │   │   ├── video-001.q50.444.jpeg
│   │   │   │   ├── video-001.q50.444.progressive.jpeg
│   │   │   │   ├── video-005.gray.gif
│   │   │   │   ├── video-005.gray.jpeg
│   │   │   │   ├── video-005.gray.png
│   │   │   │   ├── video-005.gray.q50.2x2.jpeg
│   │   │   │   ├── video-005.gray.q50.2x2.progressive.jpeg
│   │   │   │   ├── video-005.gray.q50.jpeg
│   │   │   │   └── video-005.gray.q50.progressive.jpeg
│   │   │   ├── ycbcr.go
│   │   │   └── ycbcr_test.go
│   │   ├── index
│   │   │   └── suffixarray
│   │   │       ├── qsufsort.go
│   │   │       ├── suffixarray.go
│   │   │       └── suffixarray_test.go
│   │   ├── io
│   │   │   ├── io.go
│   │   │   ├── io_test.go
│   │   │   ├── ioutil
│   │   │   │   ├── blackhole.go
│   │   │   │   ├── ioutil.go
│   │   │   │   ├── ioutil_test.go
│   │   │   │   ├── tempfile.go
│   │   │   │   └── tempfile_test.go
│   │   │   ├── multi.go
│   │   │   ├── multi_test.go
│   │   │   ├── pipe.go
│   │   │   └── pipe_test.go
│   │   ├── log
│   │   │   ├── log.go
│   │   │   ├── log_test.go
│   │   │   └── syslog
│   │   │       ├── syslog.go
│   │   │       ├── syslog_plan9.go
│   │   │       ├── syslog_test.go
│   │   │       ├── syslog_unix.go
│   │   │       └── syslog_windows.go
│   │   ├── math
│   │   │   ├── abs.go
│   │   │   ├── abs_386.s
│   │   │   ├── abs_amd64.s
│   │   │   ├── abs_arm.s
│   │   │   ├── acosh.go
│   │   │   ├── all_test.go
│   │   │   ├── asin.go
│   │   │   ├── asin_386.s
│   │   │   ├── asin_amd64.s
│   │   │   ├── asin_arm.s
│   │   │   ├── asinh.go
│   │   │   ├── atan.go
│   │   │   ├── atan2.go
│   │   │   ├── atan2_386.s
│   │   │   ├── atan2_amd64.s
│   │   │   ├── atan2_arm.s
│   │   │   ├── atan_386.s
│   │   │   ├── atan_amd64.s
│   │   │   ├── atan_arm.s
│   │   │   ├── atanh.go
│   │   │   ├── big
│   │   │   │   ├── arith.go
│   │   │   │   ├── arith_386.s
│   │   │   │   ├── arith_amd64.s
│   │   │   │   ├── arith_arm.s
│   │   │   │   ├── arith_decl.go
│   │   │   │   ├── arith_test.go
│   │   │   │   ├── calibrate_test.go
│   │   │   │   ├── example_test.go
│   │   │   │   ├── gcd_test.go
│   │   │   │   ├── hilbert_test.go
│   │   │   │   ├── int.go
│   │   │   │   ├── int_test.go
│   │   │   │   ├── nat.go
│   │   │   │   ├── nat_test.go
│   │   │   │   ├── rat.go
│   │   │   │   └── rat_test.go
│   │   │   ├── bits.go
│   │   │   ├── cbrt.go
│   │   │   ├── cmplx
│   │   │   │   ├── abs.go
│   │   │   │   ├── asin.go
│   │   │   │   ├── cmath_test.go
│   │   │   │   ├── conj.go
│   │   │   │   ├── exp.go
│   │   │   │   ├── isinf.go
│   │   │   │   ├── isnan.go
│   │   │   │   ├── log.go
│   │   │   │   ├── phase.go
│   │   │   │   ├── polar.go
│   │   │   │   ├── pow.go
│   │   │   │   ├── rect.go
│   │   │   │   ├── sin.go
│   │   │   │   ├── sqrt.go
│   │   │   │   └── tan.go
│   │   │   ├── const.go
│   │   │   ├── copysign.go
│   │   │   ├── dim.go
│   │   │   ├── dim_386.s
│   │   │   ├── dim_amd64.s
│   │   │   ├── dim_arm.s
│   │   │   ├── erf.go
│   │   │   ├── exp.go
│   │   │   ├── exp2_386.s
│   │   │   ├── exp2_amd64.s
│   │   │   ├── exp2_arm.s
│   │   │   ├── exp_386.s
│   │   │   ├── exp_amd64.s
│   │   │   ├── exp_arm.s
│   │   │   ├── expm1.go
│   │   │   ├── expm1_386.s
│   │   │   ├── expm1_amd64.s
│   │   │   ├── expm1_arm.s
│   │   │   ├── export_test.go
│   │   │   ├── floor.go
│   │   │   ├── floor_386.s
│   │   │   ├── floor_amd64.s
│   │   │   ├── floor_arm.s
│   │   │   ├── frexp.go
│   │   │   ├── frexp_386.s
│   │   │   ├── frexp_amd64.s
│   │   │   ├── frexp_arm.s
│   │   │   ├── gamma.go
│   │   │   ├── hypot.go
│   │   │   ├── hypot_386.s
│   │   │   ├── hypot_amd64.s
│   │   │   ├── hypot_arm.s
│   │   │   ├── j0.go
│   │   │   ├── j1.go
│   │   │   ├── jn.go
│   │   │   ├── ldexp.go
│   │   │   ├── ldexp_386.s
│   │   │   ├── ldexp_amd64.s
│   │   │   ├── ldexp_arm.s
│   │   │   ├── lgamma.go
│   │   │   ├── log.go
│   │   │   ├── log10.go
│   │   │   ├── log10_386.s
│   │   │   ├── log10_amd64.s
│   │   │   ├── log10_arm.s
│   │   │   ├── log1p.go
│   │   │   ├── log1p_386.s
│   │   │   ├── log1p_amd64.s
│   │   │   ├── log1p_arm.s
│   │   │   ├── log_386.s
│   │   │   ├── log_amd64.s
│   │   │   ├── log_arm.s
│   │   │   ├── logb.go
│   │   │   ├── mod.go
│   │   │   ├── mod_386.s
│   │   │   ├── mod_amd64.s
│   │   │   ├── mod_arm.s
│   │   │   ├── modf.go
│   │   │   ├── modf_386.s
│   │   │   ├── modf_amd64.s
│   │   │   ├── modf_arm.s
│   │   │   ├── nextafter.go
│   │   │   ├── pow.go
│   │   │   ├── pow10.go
│   │   │   ├── rand
│   │   │   │   ├── example_test.go
│   │   │   │   ├── exp.go
│   │   │   │   ├── normal.go
│   │   │   │   ├── rand.go
│   │   │   │   ├── rand_test.go
│   │   │   │   ├── rng.go
│   │   │   │   └── zipf.go
│   │   │   ├── remainder.go
│   │   │   ├── remainder_386.s
│   │   │   ├── remainder_amd64.s
│   │   │   ├── remainder_arm.s
│   │   │   ├── signbit.go
│   │   │   ├── sin.go
│   │   │   ├── sin_386.s
│   │   │   ├── sin_amd64.s
│   │   │   ├── sin_arm.s
│   │   │   ├── sincos.go
│   │   │   ├── sincos_386.s
│   │   │   ├── sincos_amd64.s
│   │   │   ├── sincos_arm.s
│   │   │   ├── sinh.go
│   │   │   ├── sqrt.go
│   │   │   ├── sqrt_386.s
│   │   │   ├── sqrt_amd64.s
│   │   │   ├── sqrt_arm.s
│   │   │   ├── tan.go
│   │   │   ├── tan_386.s
│   │   │   ├── tan_amd64.s
│   │   │   ├── tan_arm.s
│   │   │   ├── tanh.go
│   │   │   └── unsafe.go
│   │   ├── mime
│   │   │   ├── grammar.go
│   │   │   ├── mediatype.go
│   │   │   ├── mediatype_test.go
│   │   │   ├── multipart
│   │   │   │   ├── formdata.go
│   │   │   │   ├── formdata_test.go
│   │   │   │   ├── multipart.go
│   │   │   │   ├── multipart_test.go
│   │   │   │   ├── quotedprintable.go
│   │   │   │   ├── quotedprintable_test.go
│   │   │   │   ├── testdata
│   │   │   │   │   └── nested-mime
│   │   │   │   ├── writer.go
│   │   │   │   └── writer_test.go
│   │   │   ├── testdata
│   │   │   │   ├── test.types
│   │   │   │   └── test.types.plan9
│   │   │   ├── type.go
│   │   │   ├── type_plan9.go
│   │   │   ├── type_test.go
│   │   │   ├── type_unix.go
│   │   │   └── type_windows.go
│   │   ├── net
│   │   │   ├── cgo_bsd.go
│   │   │   ├── cgo_linux.go
│   │   │   ├── cgo_netbsd.go
│   │   │   ├── cgo_openbsd.go
│   │   │   ├── cgo_stub.go
│   │   │   ├── cgo_unix.go
│   │   │   ├── conn_test.go
│   │   │   ├── dial.go
│   │   │   ├── dial_gen.go
│   │   │   ├── dial_gen_test.go
│   │   │   ├── dial_test.go
│   │   │   ├── dialgoogle_test.go
│   │   │   ├── dnsclient.go
│   │   │   ├── dnsclient_unix.go
│   │   │   ├── dnsclient_unix_test.go
│   │   │   ├── dnsconfig_unix.go
│   │   │   ├── dnsmsg.go
│   │   │   ├── dnsmsg_test.go
│   │   │   ├── dnsname_test.go
│   │   │   ├── empty.c
│   │   │   ├── example_test.go
│   │   │   ├── fd_mutex.go
│   │   │   ├── fd_mutex_test.go
│   │   │   ├── fd_plan9.go
│   │   │   ├── fd_poll_runtime.go
│   │   │   ├── fd_unix.go
│   │   │   ├── fd_unix_test.go
│   │   │   ├── fd_windows.go
│   │   │   ├── file_plan9.go
│   │   │   ├── file_test.go
│   │   │   ├── file_unix.go
│   │   │   ├── file_windows.go
│   │   │   ├── hosts.go
│   │   │   ├── hosts_test.go
│   │   │   ├── http
│   │   │   │   ├── cgi
│   │   │   │   │   ├── child.go
│   │   │   │   │   ├── child_test.go
│   │   │   │   │   ├── host.go
│   │   │   │   │   ├── host_test.go
│   │   │   │   │   ├── matryoshka_test.go
│   │   │   │   │   ├── plan9_test.go
│   │   │   │   │   ├── posix_test.go
│   │   │   │   │   └── testdata
│   │   │   │   │       └── test.cgi
│   │   │   │   ├── chunked.go
│   │   │   │   ├── chunked_test.go
│   │   │   │   ├── client.go
│   │   │   │   ├── client_test.go
│   │   │   │   ├── cookie.go
│   │   │   │   ├── cookie_test.go
│   │   │   │   ├── cookiejar
│   │   │   │   │   ├── jar.go
│   │   │   │   │   ├── jar_test.go
│   │   │   │   │   ├── punycode.go
│   │   │   │   │   └── punycode_test.go
│   │   │   │   ├── doc.go
│   │   │   │   ├── example_test.go
│   │   │   │   ├── export_test.go
│   │   │   │   ├── fcgi
│   │   │   │   │   ├── child.go
│   │   │   │   │   ├── fcgi.go
│   │   │   │   │   └── fcgi_test.go
│   │   │   │   ├── filetransport.go
│   │   │   │   ├── filetransport_test.go
│   │   │   │   ├── fs.go
│   │   │   │   ├── fs_test.go
│   │   │   │   ├── header.go
│   │   │   │   ├── header_test.go
│   │   │   │   ├── httptest
│   │   │   │   │   ├── example_test.go
│   │   │   │   │   ├── recorder.go
│   │   │   │   │   ├── recorder_test.go
│   │   │   │   │   ├── server.go
│   │   │   │   │   └── server_test.go
│   │   │   │   ├── httputil
│   │   │   │   │   ├── chunked.go
│   │   │   │   │   ├── chunked_test.go
│   │   │   │   │   ├── dump.go
│   │   │   │   │   ├── dump_test.go
│   │   │   │   │   ├── persist.go
│   │   │   │   │   ├── reverseproxy.go
│   │   │   │   │   └── reverseproxy_test.go
│   │   │   │   ├── jar.go
│   │   │   │   ├── lex.go
│   │   │   │   ├── lex_test.go
│   │   │   │   ├── npn_test.go
│   │   │   │   ├── pprof
│   │   │   │   │   └── pprof.go
│   │   │   │   ├── proxy_test.go
│   │   │   │   ├── range_test.go
│   │   │   │   ├── readrequest_test.go
│   │   │   │   ├── request.go
│   │   │   │   ├── request_test.go
│   │   │   │   ├── requestwrite_test.go
│   │   │   │   ├── response.go
│   │   │   │   ├── response_test.go
│   │   │   │   ├── responsewrite_test.go
│   │   │   │   ├── serve_test.go
│   │   │   │   ├── server.go
│   │   │   │   ├── sniff.go
│   │   │   │   ├── sniff_test.go
│   │   │   │   ├── status.go
│   │   │   │   ├── testdata
│   │   │   │   │   ├── file
│   │   │   │   │   ├── index.html
│   │   │   │   │   └── style.css
│   │   │   │   ├── transfer.go
│   │   │   │   ├── transfer_test.go
│   │   │   │   ├── transport.go
│   │   │   │   ├── transport_test.go
│   │   │   │   ├── triv.go
│   │   │   │   └── z_last_test.go
│   │   │   ├── interface.go
│   │   │   ├── interface_bsd.go
│   │   │   ├── interface_bsd_test.go
│   │   │   ├── interface_darwin.go
│   │   │   ├── interface_dragonfly.go
│   │   │   ├── interface_freebsd.go
│   │   │   ├── interface_linux.go
│   │   │   ├── interface_linux_test.go
│   │   │   ├── interface_netbsd.go
│   │   │   ├── interface_openbsd.go
│   │   │   ├── interface_stub.go
│   │   │   ├── interface_test.go
│   │   │   ├── interface_unix_test.go
│   │   │   ├── interface_windows.go
│   │   │   ├── ip.go
│   │   │   ├── ip_test.go
│   │   │   ├── ipraw_test.go
│   │   │   ├── iprawsock.go
│   │   │   ├── iprawsock_plan9.go
│   │   │   ├── iprawsock_posix.go
│   │   │   ├── ipsock.go
│   │   │   ├── ipsock_plan9.go
│   │   │   ├── ipsock_posix.go
│   │   │   ├── ipsock_test.go
│   │   │   ├── lookup.go
│   │   │   ├── lookup_plan9.go
│   │   │   ├── lookup_test.go
│   │   │   ├── lookup_unix.go
│   │   │   ├── lookup_windows.go
│   │   │   ├── mac.go
│   │   │   ├── mac_test.go
│   │   │   ├── mail
│   │   │   │   ├── message.go
│   │   │   │   └── message_test.go
│   │   │   ├── mockicmp_test.go
│   │   │   ├── mockserver_test.go
│   │   │   ├── multicast_test.go
│   │   │   ├── net.go
│   │   │   ├── net_test.go
│   │   │   ├── packetconn_test.go
│   │   │   ├── parse.go
│   │   │   ├── parse_test.go
│   │   │   ├── pipe.go
│   │   │   ├── pipe_test.go
│   │   │   ├── port.go
│   │   │   ├── port_test.go
│   │   │   ├── port_unix.go
│   │   │   ├── protoconn_test.go
│   │   │   ├── race.go
│   │   │   ├── race0.go
│   │   │   ├── rpc
│   │   │   │   ├── client.go
│   │   │   │   ├── debug.go
│   │   │   │   ├── jsonrpc
│   │   │   │   │   ├── all_test.go
│   │   │   │   │   ├── client.go
│   │   │   │   │   └── server.go
│   │   │   │   ├── server.go
│   │   │   │   └── server_test.go
│   │   │   ├── sendfile_dragonfly.go
│   │   │   ├── sendfile_freebsd.go
│   │   │   ├── sendfile_linux.go
│   │   │   ├── sendfile_stub.go
│   │   │   ├── sendfile_windows.go
│   │   │   ├── server_test.go
│   │   │   ├── singleflight.go
│   │   │   ├── smtp
│   │   │   │   ├── auth.go
│   │   │   │   ├── smtp.go
│   │   │   │   └── smtp_test.go
│   │   │   ├── sock_bsd.go
│   │   │   ├── sock_cloexec.go
│   │   │   ├── sock_linux.go
│   │   │   ├── sock_plan9.go
│   │   │   ├── sock_posix.go
│   │   │   ├── sock_windows.go
│   │   │   ├── sockopt_bsd.go
│   │   │   ├── sockopt_linux.go
│   │   │   ├── sockopt_posix.go
│   │   │   ├── sockopt_windows.go
│   │   │   ├── sockoptip_bsd.go
│   │   │   ├── sockoptip_linux.go
│   │   │   ├── sockoptip_posix.go
│   │   │   ├── sockoptip_windows.go
│   │   │   ├── sys_cloexec.go
│   │   │   ├── tcp_test.go
│   │   │   ├── tcpsock.go
│   │   │   ├── tcpsock_plan9.go
│   │   │   ├── tcpsock_posix.go
│   │   │   ├── tcpsockopt_darwin.go
│   │   │   ├── tcpsockopt_openbsd.go
│   │   │   ├── tcpsockopt_posix.go
│   │   │   ├── tcpsockopt_unix.go
│   │   │   ├── tcpsockopt_windows.go
│   │   │   ├── testdata
│   │   │   │   ├── hosts
│   │   │   │   ├── hosts_singleline
│   │   │   │   ├── igmp
│   │   │   │   └── igmp6
│   │   │   ├── textproto
│   │   │   │   ├── header.go
│   │   │   │   ├── pipeline.go
│   │   │   │   ├── reader.go
│   │   │   │   ├── reader_test.go
│   │   │   │   ├── textproto.go
│   │   │   │   ├── writer.go
│   │   │   │   └── writer_test.go
│   │   │   ├── timeout_test.go
│   │   │   ├── udp_test.go
│   │   │   ├── udpsock.go
│   │   │   ├── udpsock_plan9.go
│   │   │   ├── udpsock_posix.go
│   │   │   ├── unicast_posix_test.go
│   │   │   ├── unix_test.go
│   │   │   ├── unixsock.go
│   │   │   ├── unixsock_plan9.go
│   │   │   ├── unixsock_posix.go
│   │   │   └── url
│   │   │       ├── example_test.go
│   │   │       ├── url.go
│   │   │       └── url_test.go
│   │   ├── os
│   │   │   ├── dir_plan9.go
│   │   │   ├── dir_unix.go
│   │   │   ├── dir_windows.go
│   │   │   ├── doc.go
│   │   │   ├── env.go
│   │   │   ├── env_test.go
│   │   │   ├── env_unix_test.go
│   │   │   ├── error.go
│   │   │   ├── error_plan9.go
│   │   │   ├── error_test.go
│   │   │   ├── error_unix.go
│   │   │   ├── error_windows.go
│   │   │   ├── error_windows_test.go
│   │   │   ├── exec
│   │   │   │   ├── example_test.go
│   │   │   │   ├── exec.go
│   │   │   │   ├── exec_test.go
│   │   │   │   ├── lp_plan9.go
│   │   │   │   ├── lp_test.go
│   │   │   │   ├── lp_unix.go
│   │   │   │   ├── lp_unix_test.go
│   │   │   │   ├── lp_windows.go
│   │   │   │   └── lp_windows_test.go
│   │   │   ├── exec.go
│   │   │   ├── exec_plan9.go
│   │   │   ├── exec_posix.go
│   │   │   ├── exec_unix.go
│   │   │   ├── exec_windows.go
│   │   │   ├── export_test.go
│   │   │   ├── file.go
│   │   │   ├── file_plan9.go
│   │   │   ├── file_posix.go
│   │   │   ├── file_unix.go
│   │   │   ├── file_windows.go
│   │   │   ├── getwd.go
│   │   │   ├── getwd_darwin.go
│   │   │   ├── os_test.go
│   │   │   ├── os_unix_test.go
│   │   │   ├── path.go
│   │   │   ├── path_plan9.go
│   │   │   ├── path_test.go
│   │   │   ├── path_unix.go
│   │   │   ├── path_windows.go
│   │   │   ├── pipe_bsd.go
│   │   │   ├── pipe_linux.go
│   │   │   ├── proc.go
│   │   │   ├── signal
│   │   │   │   ├── example_test.go
│   │   │   │   ├── sig.s
│   │   │   │   ├── signal.go
│   │   │   │   ├── signal_stub.go
│   │   │   │   ├── signal_test.go
│   │   │   │   ├── signal_unix.go
│   │   │   │   └── signal_windows_test.go
│   │   │   ├── stat_darwin.go
│   │   │   ├── stat_dragonfly.go
│   │   │   ├── stat_freebsd.go
│   │   │   ├── stat_linux.go
│   │   │   ├── stat_netbsd.go
│   │   │   ├── stat_openbsd.go
│   │   │   ├── stat_plan9.go
│   │   │   ├── stat_windows.go
│   │   │   ├── str.go
│   │   │   ├── sys_bsd.go
│   │   │   ├── sys_linux.go
│   │   │   ├── sys_plan9.go
│   │   │   ├── sys_windows.go
│   │   │   ├── types.go
│   │   │   ├── types_notwin.go
│   │   │   ├── types_windows.go
│   │   │   └── user
│   │   │       ├── lookup.go
│   │   │       ├── lookup_plan9.go
│   │   │       ├── lookup_stubs.go
│   │   │       ├── lookup_unix.go
│   │   │       ├── lookup_windows.go
│   │   │       ├── user.go
│   │   │       └── user_test.go
│   │   ├── path
│   │   │   ├── example_test.go
│   │   │   ├── filepath
│   │   │   │   ├── example_unix_test.go
│   │   │   │   ├── match.go
│   │   │   │   ├── match_test.go
│   │   │   │   ├── path.go
│   │   │   │   ├── path_plan9.go
│   │   │   │   ├── path_test.go
│   │   │   │   ├── path_unix.go
│   │   │   │   ├── path_windows.go
│   │   │   │   ├── path_windows_test.go
│   │   │   │   ├── symlink.go
│   │   │   │   └── symlink_windows.go
│   │   │   ├── match.go
│   │   │   ├── match_test.go
│   │   │   ├── path.go
│   │   │   └── path_test.go
│   │   ├── reflect
│   │   │   ├── all_test.go
│   │   │   ├── asm_386.s
│   │   │   ├── asm_amd64.s
│   │   │   ├── asm_arm.s
│   │   │   ├── deepequal.go
│   │   │   ├── example_test.go
│   │   │   ├── export_test.go
│   │   │   ├── makefunc.go
│   │   │   ├── set_test.go
│   │   │   ├── tostring_test.go
│   │   │   ├── type.go
│   │   │   └── value.go
│   │   ├── regexp
│   │   │   ├── all_test.go
│   │   │   ├── example_test.go
│   │   │   ├── exec.go
│   │   │   ├── exec2_test.go
│   │   │   ├── exec_test.go
│   │   │   ├── find_test.go
│   │   │   ├── regexp.go
│   │   │   ├── syntax
│   │   │   │   ├── compile.go
│   │   │   │   ├── doc.go
│   │   │   │   ├── make_perl_groups.pl
│   │   │   │   ├── parse.go
│   │   │   │   ├── parse_test.go
│   │   │   │   ├── perl_groups.go
│   │   │   │   ├── prog.go
│   │   │   │   ├── prog_test.go
│   │   │   │   ├── regexp.go
│   │   │   │   ├── simplify.go
│   │   │   │   └── simplify_test.go
│   │   │   └── testdata
│   │   │       ├── README
│   │   │       ├── basic.dat
│   │   │       ├── nullsubexpr.dat
│   │   │       ├── re2-exhaustive.txt.bz2
│   │   │       ├── re2-search.txt
│   │   │       ├── repetition.dat
│   │   │       └── testregex.c
│   │   ├── runtime
│   │   │   ├── Makefile
│   │   │   ├── alg.c
│   │   │   ├── append_test.go
│   │   │   ├── arch_386.h
│   │   │   ├── arch_amd64.h
│   │   │   ├── arch_arm.h
│   │   │   ├── asm_386.s
│   │   │   ├── asm_amd64.s
│   │   │   ├── asm_arm.s
│   │   │   ├── atomic_386.c
│   │   │   ├── atomic_amd64.c
│   │   │   ├── atomic_arm.c
│   │   │   ├── callback_windows.c
│   │   │   ├── cgo
│   │   │   │   ├── asm_386.s
│   │   │   │   ├── asm_amd64.s
│   │   │   │   ├── asm_arm.s
│   │   │   │   ├── callbacks.c
│   │   │   │   ├── cgo.go
│   │   │   │   ├── dragonfly.c
│   │   │   │   ├── freebsd.c
│   │   │   │   ├── gcc_386.S
│   │   │   │   ├── gcc_amd64.S
│   │   │   │   ├── gcc_arm.S
│   │   │   │   ├── gcc_darwin_386.c
│   │   │   │   ├── gcc_darwin_amd64.c
│   │   │   │   ├── gcc_dragonfly_386.c
│   │   │   │   ├── gcc_dragonfly_amd64.c
│   │   │   │   ├── gcc_freebsd_386.c
│   │   │   │   ├── gcc_freebsd_amd64.c
│   │   │   │   ├── gcc_freebsd_arm.c
│   │   │   │   ├── gcc_linux_386.c
│   │   │   │   ├── gcc_linux_amd64.c
│   │   │   │   ├── gcc_linux_arm.c
│   │   │   │   ├── gcc_netbsd_386.c
│   │   │   │   ├── gcc_netbsd_amd64.c
│   │   │   │   ├── gcc_netbsd_arm.c
│   │   │   │   ├── gcc_openbsd_386.c
│   │   │   │   ├── gcc_openbsd_amd64.c
│   │   │   │   ├── gcc_setenv.c
│   │   │   │   ├── gcc_util.c
│   │   │   │   ├── gcc_windows_386.c
│   │   │   │   ├── gcc_windows_amd64.c
│   │   │   │   ├── iscgo.c
│   │   │   │   ├── libcgo.h
│   │   │   │   ├── netbsd.c
│   │   │   │   ├── openbsd.c
│   │   │   │   └── setenv.c
│   │   │   ├── cgocall.c
│   │   │   ├── cgocall.h
│   │   │   ├── chan.c
│   │   │   ├── chan_test.go
│   │   │   ├── closure_test.go
│   │   │   ├── compiler.go
│   │   │   ├── complex.c
│   │   │   ├── complex_test.go
│   │   │   ├── cpuprof.c
│   │   │   ├── crash_cgo_test.go
│   │   │   ├── crash_test.go
│   │   │   ├── debug
│   │   │   │   ├── debug.c
│   │   │   │   ├── garbage.go
│   │   │   │   ├── garbage_test.go
│   │   │   │   ├── stack.go
│   │   │   │   └── stack_test.go
│   │   │   ├── debug.go
│   │   │   ├── defs1_linux.go
│   │   │   ├── defs2_linux.go
│   │   │   ├── defs_arm_linux.go
│   │   │   ├── defs_darwin.go
│   │   │   ├── defs_darwin_386.h
│   │   │   ├── defs_darwin_amd64.h
│   │   │   ├── defs_dragonfly.go
│   │   │   ├── defs_dragonfly_386.h
│   │   │   ├── defs_dragonfly_amd64.h
│   │   │   ├── defs_freebsd.go
│   │   │   ├── defs_freebsd_386.h
│   │   │   ├── defs_freebsd_amd64.h
│   │   │   ├── defs_freebsd_arm.h
│   │   │   ├── defs_linux.go
│   │   │   ├── defs_linux_386.h
│   │   │   ├── defs_linux_amd64.h
│   │   │   ├── defs_linux_arm.h
│   │   │   ├── defs_netbsd.go
│   │   │   ├── defs_netbsd_386.go
│   │   │   ├── defs_netbsd_386.h
│   │   │   ├── defs_netbsd_amd64.go
│   │   │   ├── defs_netbsd_amd64.h
│   │   │   ├── defs_netbsd_arm.go
│   │   │   ├── defs_netbsd_arm.h
│   │   │   ├── defs_openbsd.go
│   │   │   ├── defs_openbsd_386.h
│   │   │   ├── defs_openbsd_amd64.h
│   │   │   ├── defs_plan9_386.h
│   │   │   ├── defs_plan9_amd64.h
│   │   │   ├── defs_windows.go
│   │   │   ├── defs_windows_386.h
│   │   │   ├── defs_windows_amd64.h
│   │   │   ├── env_plan9.c
│   │   │   ├── env_posix.c
│   │   │   ├── error.go
│   │   │   ├── export_futex_test.go
│   │   │   ├── export_test.c
│   │   │   ├── export_test.go
│   │   │   ├── extern.go
│   │   │   ├── float.c
│   │   │   ├── funcdata.h
│   │   │   ├── futex_test.go
│   │   │   ├── gc_test.go
│   │   │   ├── hash_test.go
│   │   │   ├── hashmap.c
│   │   │   ├── hashmap_fast.c
│   │   │   ├── iface.c
│   │   │   ├── iface_test.go
│   │   │   ├── lfstack.c
│   │   │   ├── lfstack_test.go
│   │   │   ├── lock_futex.c
│   │   │   ├── lock_sema.c
│   │   │   ├── malloc.goc
│   │   │   ├── malloc.h
│   │   │   ├── malloc1.go
│   │   │   ├── malloc_test.go
│   │   │   ├── mallocrand.go
│   │   │   ├── mallocrep.go
│   │   │   ├── mallocrep1.go
│   │   │   ├── map_test.go
│   │   │   ├── mapspeed_test.go
│   │   │   ├── mcache.c
│   │   │   ├── mcentral.c
│   │   │   ├── mem.go
│   │   │   ├── mem_darwin.c
│   │   │   ├── mem_dragonfly.c
│   │   │   ├── mem_freebsd.c
│   │   │   ├── mem_linux.c
│   │   │   ├── mem_netbsd.c
│   │   │   ├── mem_openbsd.c
│   │   │   ├── mem_plan9.c
│   │   │   ├── mem_windows.c
│   │   │   ├── memclr_arm.s
│   │   │   ├── memmove_386.s
│   │   │   ├── memmove_amd64.s
│   │   │   ├── memmove_arm.s
│   │   │   ├── memmove_linux_amd64_test.go
│   │   │   ├── memmove_test.go
│   │   │   ├── mfinal.c
│   │   │   ├── mfinal_test.go
│   │   │   ├── mfixalloc.c
│   │   │   ├── mgc0.c
│   │   │   ├── mgc0.go
│   │   │   ├── mgc0.h
│   │   │   ├── mheap.c
│   │   │   ├── mprof.goc
│   │   │   ├── msize.c
│   │   │   ├── netpoll.goc
│   │   │   ├── netpoll_epoll.c
│   │   │   ├── netpoll_kqueue.c
│   │   │   ├── netpoll_stub.c
│   │   │   ├── netpoll_windows.c
│   │   │   ├── noasm_arm.goc
│   │   │   ├── norace_test.go
│   │   │   ├── os_darwin.c
│   │   │   ├── os_darwin.h
│   │   │   ├── os_dragonfly.c
│   │   │   ├── os_dragonfly.h
│   │   │   ├── os_freebsd.c
│   │   │   ├── os_freebsd.h
│   │   │   ├── os_freebsd_arm.c
│   │   │   ├── os_linux.c
│   │   │   ├── os_linux.h
│   │   │   ├── os_linux_386.c
│   │   │   ├── os_linux_arm.c
│   │   │   ├── os_netbsd.c
│   │   │   ├── os_netbsd.h
│   │   │   ├── os_netbsd_386.c
│   │   │   ├── os_netbsd_amd64.c
│   │   │   ├── os_netbsd_arm.c
│   │   │   ├── os_openbsd.c
│   │   │   ├── os_openbsd.h
│   │   │   ├── os_plan9.c
│   │   │   ├── os_plan9.h
│   │   │   ├── os_plan9_386.c
│   │   │   ├── os_plan9_amd64.c
│   │   │   ├── os_windows.c
│   │   │   ├── os_windows.h
│   │   │   ├── os_windows_386.c
│   │   │   ├── os_windows_amd64.c
│   │   │   ├── panic.c
│   │   │   ├── parfor.c
│   │   │   ├── parfor_test.go
│   │   │   ├── pprof
│   │   │   │   ├── pprof.go
│   │   │   │   └── pprof_test.go
│   │   │   ├── print.c
│   │   │   ├── proc.c
│   │   │   ├── proc.p
│   │   │   ├── proc_test.go
│   │   │   ├── race
│   │   │   │   ├── README
│   │   │   │   ├── doc.go
│   │   │   │   ├── output_test.go
│   │   │   │   ├── race.go
│   │   │   │   ├── race_darwin_amd64.syso
│   │   │   │   ├── race_linux_amd64.syso
│   │   │   │   ├── race_test.go
│   │   │   │   ├── race_windows_amd64.syso
│   │   │   │   └── testdata
│   │   │   │       ├── atomic_test.go
│   │   │   │       ├── cgo_test.go
│   │   │   │       ├── cgo_test_main.go
│   │   │   │       ├── chan_test.go
│   │   │   │       ├── comp_test.go
│   │   │   │       ├── finalizer_test.go
│   │   │   │       ├── io_test.go
│   │   │   │       ├── map_test.go
│   │   │   │       ├── mop_test.go
│   │   │   │       ├── mutex_test.go
│   │   │   │       ├── regression_test.go
│   │   │   │       ├── rwmutex_test.go
│   │   │   │       ├── select_test.go
│   │   │   │       ├── slice_test.go
│   │   │   │       ├── sync_test.go
│   │   │   │       └── waitgroup_test.go
│   │   │   ├── race.c
│   │   │   ├── race.go
│   │   │   ├── race.h
│   │   │   ├── race0.c
│   │   │   ├── race_amd64.s
│   │   │   ├── rt0_darwin_386.s
│   │   │   ├── rt0_darwin_amd64.s
│   │   │   ├── rt0_dragonfly_386.s
│   │   │   ├── rt0_dragonfly_amd64.s
│   │   │   ├── rt0_freebsd_386.s
│   │   │   ├── rt0_freebsd_amd64.s
│   │   │   ├── rt0_freebsd_arm.s
│   │   │   ├── rt0_linux_386.s
│   │   │   ├── rt0_linux_amd64.s
│   │   │   ├── rt0_linux_arm.s
│   │   │   ├── rt0_netbsd_386.s
│   │   │   ├── rt0_netbsd_amd64.s
│   │   │   ├── rt0_netbsd_arm.s
│   │   │   ├── rt0_openbsd_386.s
│   │   │   ├── rt0_openbsd_amd64.s
│   │   │   ├── rt0_plan9_386.s
│   │   │   ├── rt0_plan9_amd64.s
│   │   │   ├── rt0_windows_386.s
│   │   │   ├── rt0_windows_amd64.s
│   │   │   ├── rune.c
│   │   │   ├── runtime-gdb.py
│   │   │   ├── runtime.c
│   │   │   ├── runtime.h
│   │   │   ├── runtime1.goc
│   │   │   ├── runtime_linux_test.go
│   │   │   ├── runtime_test.go
│   │   │   ├── sema.goc
│   │   │   ├── signal_386.c
│   │   │   ├── signal_amd64.c
│   │   │   ├── signal_arm.c
│   │   │   ├── signal_darwin_386.h
│   │   │   ├── signal_darwin_amd64.h
│   │   │   ├── signal_dragonfly_386.h
│   │   │   ├── signal_dragonfly_amd64.h
│   │   │   ├── signal_freebsd_386.h
│   │   │   ├── signal_freebsd_amd64.h
│   │   │   ├── signal_freebsd_arm.h
│   │   │   ├── signal_linux_386.h
│   │   │   ├── signal_linux_amd64.h
│   │   │   ├── signal_linux_arm.h
│   │   │   ├── signal_netbsd_386.h
│   │   │   ├── signal_netbsd_amd64.h
│   │   │   ├── signal_netbsd_arm.h
│   │   │   ├── signal_openbsd_386.h
│   │   │   ├── signal_openbsd_amd64.h
│   │   │   ├── signal_unix.c
│   │   │   ├── signal_unix.h
│   │   │   ├── signals_darwin.h
│   │   │   ├── signals_dragonfly.h
│   │   │   ├── signals_freebsd.h
│   │   │   ├── signals_linux.h
│   │   │   ├── signals_netbsd.h
│   │   │   ├── signals_openbsd.h
│   │   │   ├── signals_plan9.h
│   │   │   ├── signals_windows.h
│   │   │   ├── sigqueue.goc
│   │   │   ├── slice.c
│   │   │   ├── softfloat64.go
│   │   │   ├── softfloat64_test.go
│   │   │   ├── softfloat_arm.c
│   │   │   ├── stack.c
│   │   │   ├── stack.h
│   │   │   ├── stack_test.go
│   │   │   ├── string.goc
│   │   │   ├── string_test.go
│   │   │   ├── symtab.c
│   │   │   ├── symtab_test.go
│   │   │   ├── sys_arm.c
│   │   │   ├── sys_darwin_386.s
│   │   │   ├── sys_darwin_amd64.s
│   │   │   ├── sys_dragonfly_386.s
│   │   │   ├── sys_dragonfly_amd64.s
│   │   │   ├── sys_freebsd_386.s
│   │   │   ├── sys_freebsd_amd64.s
│   │   │   ├── sys_freebsd_arm.s
│   │   │   ├── sys_linux_386.s
│   │   │   ├── sys_linux_amd64.s
│   │   │   ├── sys_linux_arm.s
│   │   │   ├── sys_netbsd_386.s
│   │   │   ├── sys_netbsd_amd64.s
│   │   │   ├── sys_netbsd_arm.s
│   │   │   ├── sys_openbsd_386.s
│   │   │   ├── sys_openbsd_amd64.s
│   │   │   ├── sys_plan9_386.s
│   │   │   ├── sys_plan9_amd64.s
│   │   │   ├── sys_windows_386.s
│   │   │   ├── sys_windows_amd64.s
│   │   │   ├── sys_x86.c
│   │   │   ├── syscall_windows.goc
│   │   │   ├── syscall_windows_test.go
│   │   │   ├── time.goc
│   │   │   ├── time_plan9_386.c
│   │   │   ├── traceback_arm.c
│   │   │   ├── traceback_x86.c
│   │   │   ├── type.go
│   │   │   ├── type.h
│   │   │   ├── typekind.h
│   │   │   ├── vdso_linux_amd64.c
│   │   │   ├── vlop_386.s
│   │   │   ├── vlop_arm.s
│   │   │   ├── vlop_arm_test.go
│   │   │   ├── vlrt_386.c
│   │   │   └── vlrt_arm.c
│   │   ├── sort
│   │   │   ├── example_interface_test.go
│   │   │   ├── example_keys_test.go
│   │   │   ├── example_multi_test.go
│   │   │   ├── example_test.go
│   │   │   ├── example_wrapper_test.go
│   │   │   ├── export_test.go
│   │   │   ├── search.go
│   │   │   ├── search_test.go
│   │   │   ├── sort.go
│   │   │   └── sort_test.go
│   │   ├── strconv
│   │   │   ├── atob.go
│   │   │   ├── atob_test.go
│   │   │   ├── atof.go
│   │   │   ├── atof_test.go
│   │   │   ├── atoi.go
│   │   │   ├── atoi_test.go
│   │   │   ├── decimal.go
│   │   │   ├── decimal_test.go
│   │   │   ├── extfloat.go
│   │   │   ├── fp_test.go
│   │   │   ├── ftoa.go
│   │   │   ├── ftoa_test.go
│   │   │   ├── internal_test.go
│   │   │   ├── isprint.go
│   │   │   ├── itoa.go
│   │   │   ├── itoa_test.go
│   │   │   ├── makeisprint.go
│   │   │   ├── quote.go
│   │   │   ├── quote_test.go
│   │   │   ├── strconv_test.go
│   │   │   └── testdata
│   │   │       └── testfp.txt
│   │   ├── strings
│   │   │   ├── example_test.go
│   │   │   ├── export_test.go
│   │   │   ├── reader.go
│   │   │   ├── reader_test.go
│   │   │   ├── replace.go
│   │   │   ├── replace_test.go
│   │   │   ├── search.go
│   │   │   ├── search_test.go
│   │   │   ├── strings.go
│   │   │   ├── strings.s
│   │   │   ├── strings_decl.go
│   │   │   └── strings_test.go
│   │   ├── sync
│   │   │   ├── atomic
│   │   │   │   ├── 64bit_arm.go
│   │   │   │   ├── asm_386.s
│   │   │   │   ├── asm_amd64.s
│   │   │   │   ├── asm_arm.s
│   │   │   │   ├── asm_freebsd_arm.s
│   │   │   │   ├── asm_linux_arm.s
│   │   │   │   ├── asm_netbsd_arm.s
│   │   │   │   ├── atomic_linux_arm_test.go
│   │   │   │   ├── atomic_test.go
│   │   │   │   ├── doc.go
│   │   │   │   ├── export_linux_arm_test.go
│   │   │   │   └── race.go
│   │   │   ├── cond.go
│   │   │   ├── cond_test.go
│   │   │   ├── example_test.go
│   │   │   ├── export_test.go
│   │   │   ├── mutex.go
│   │   │   ├── mutex_test.go
│   │   │   ├── once.go
│   │   │   ├── once_test.go
│   │   │   ├── race.go
│   │   │   ├── race0.go
│   │   │   ├── runtime.go
│   │   │   ├── runtime_sema_test.go
│   │   │   ├── rwmutex.go
│   │   │   ├── rwmutex_test.go
│   │   │   ├── waitgroup.go
│   │   │   └── waitgroup_test.go
│   │   ├── syscall
│   │   │   ├── asm_darwin_386.s
│   │   │   ├── asm_darwin_amd64.s
│   │   │   ├── asm_dragonfly_386.s
│   │   │   ├── asm_dragonfly_amd64.s
│   │   │   ├── asm_freebsd_386.s
│   │   │   ├── asm_freebsd_amd64.s
│   │   │   ├── asm_freebsd_arm.s
│   │   │   ├── asm_linux_386.s
│   │   │   ├── asm_linux_amd64.s
│   │   │   ├── asm_linux_arm.s
│   │   │   ├── asm_netbsd_386.s
│   │   │   ├── asm_netbsd_amd64.s
│   │   │   ├── asm_netbsd_arm.s
│   │   │   ├── asm_openbsd_386.s
│   │   │   ├── asm_openbsd_amd64.s
│   │   │   ├── asm_plan9_386.s
│   │   │   ├── asm_plan9_amd64.s
│   │   │   ├── asm_windows_386.s
│   │   │   ├── asm_windows_amd64.s
│   │   │   ├── bpf_bsd.go
│   │   │   ├── consistency_unix_test.go
│   │   │   ├── creds_test.go
│   │   │   ├── dir_plan9.go
│   │   │   ├── dll_windows.go
│   │   │   ├── env_plan9.go
│   │   │   ├── env_unix.go
│   │   │   ├── env_windows.go
│   │   │   ├── exec_bsd.go
│   │   │   ├── exec_linux.go
│   │   │   ├── exec_plan9.go
│   │   │   ├── exec_unix.go
│   │   │   ├── exec_windows.go
│   │   │   ├── lsf_linux.go
│   │   │   ├── mkall.sh
│   │   │   ├── mkerrors.sh
│   │   │   ├── mkerrors_windows.sh
│   │   │   ├── mksyscall.pl
│   │   │   ├── mksyscall_windows.pl
│   │   │   ├── mksysctl_openbsd.pl
│   │   │   ├── mksysnum_darwin.pl
│   │   │   ├── mksysnum_dragonfly.pl
│   │   │   ├── mksysnum_freebsd.pl
│   │   │   ├── mksysnum_linux.pl
│   │   │   ├── mksysnum_netbsd.pl
│   │   │   ├── mksysnum_openbsd.pl
│   │   │   ├── mksysnum_plan9.sh
│   │   │   ├── netlink_linux.go
│   │   │   ├── passfd_test.go
│   │   │   ├── race.go
│   │   │   ├── race0.go
│   │   │   ├── rlimit_linux_test.go
│   │   │   ├── route_bsd.go
│   │   │   ├── route_darwin.go
│   │   │   ├── route_dragonfly.go
│   │   │   ├── route_freebsd.go
│   │   │   ├── route_netbsd.go
│   │   │   ├── route_openbsd.go
│   │   │   ├── security_windows.go
│   │   │   ├── sockcmsg_linux.go
│   │   │   ├── sockcmsg_unix.go
│   │   │   ├── str.go
│   │   │   ├── syscall.go
│   │   │   ├── syscall_bsd.go
│   │   │   ├── syscall_darwin.go
│   │   │   ├── syscall_darwin_386.go
│   │   │   ├── syscall_darwin_amd64.go
│   │   │   ├── syscall_dragonfly.go
│   │   │   ├── syscall_dragonfly_386.go
│   │   │   ├── syscall_dragonfly_amd64.go
│   │   │   ├── syscall_freebsd.go
│   │   │   ├── syscall_freebsd_386.go
│   │   │   ├── syscall_freebsd_amd64.go
│   │   │   ├── syscall_freebsd_arm.go
│   │   │   ├── syscall_linux.go
│   │   │   ├── syscall_linux_386.go
│   │   │   ├── syscall_linux_amd64.go
│   │   │   ├── syscall_linux_arm.go
│   │   │   ├── syscall_netbsd.go
│   │   │   ├── syscall_netbsd_386.go
│   │   │   ├── syscall_netbsd_amd64.go
│   │   │   ├── syscall_netbsd_arm.go
│   │   │   ├── syscall_no_getwd.go
│   │   │   ├── syscall_openbsd.go
│   │   │   ├── syscall_openbsd_386.go
│   │   │   ├── syscall_openbsd_amd64.go
│   │   │   ├── syscall_plan9.go
│   │   │   ├── syscall_plan9_386.go
│   │   │   ├── syscall_plan9_amd64.go
│   │   │   ├── syscall_test.go
│   │   │   ├── syscall_unix.go
│   │   │   ├── syscall_windows.go
│   │   │   ├── syscall_windows_386.go
│   │   │   ├── syscall_windows_amd64.go
│   │   │   ├── syscall_windows_test.go
│   │   │   ├── types_darwin.go
│   │   │   ├── types_dragonfly.go
│   │   │   ├── types_freebsd.go
│   │   │   ├── types_linux.go
│   │   │   ├── types_netbsd.go
│   │   │   ├── types_openbsd.go
│   │   │   ├── types_plan9.c
│   │   │   ├── zerrors_darwin_386.go
│   │   │   ├── zerrors_darwin_amd64.go
│   │   │   ├── zerrors_dragonfly_386.go
│   │   │   ├── zerrors_dragonfly_amd64.go
│   │   │   ├── zerrors_freebsd_386.go
│   │   │   ├── zerrors_freebsd_amd64.go
│   │   │   ├── zerrors_freebsd_arm.go
│   │   │   ├── zerrors_linux_386.go
│   │   │   ├── zerrors_linux_amd64.go
│   │   │   ├── zerrors_linux_arm.go
│   │   │   ├── zerrors_netbsd_386.go
│   │   │   ├── zerrors_netbsd_amd64.go
│   │   │   ├── zerrors_netbsd_arm.go
│   │   │   ├── zerrors_openbsd_386.go
│   │   │   ├── zerrors_openbsd_amd64.go
│   │   │   ├── zerrors_plan9_386.go
│   │   │   ├── zerrors_plan9_amd64.go
│   │   │   ├── zerrors_windows.go
│   │   │   ├── zerrors_windows_386.go
│   │   │   ├── zerrors_windows_amd64.go
│   │   │   ├── zsyscall_darwin_386.go
│   │   │   ├── zsyscall_darwin_amd64.go
│   │   │   ├── zsyscall_dragonfly_386.go
│   │   │   ├── zsyscall_dragonfly_amd64.go
│   │   │   ├── zsyscall_freebsd_386.go
│   │   │   ├── zsyscall_freebsd_amd64.go
│   │   │   ├── zsyscall_freebsd_arm.go
│   │   │   ├── zsyscall_linux_386.go
│   │   │   ├── zsyscall_linux_amd64.go
│   │   │   ├── zsyscall_linux_arm.go
│   │   │   ├── zsyscall_netbsd_386.go
│   │   │   ├── zsyscall_netbsd_amd64.go
│   │   │   ├── zsyscall_netbsd_arm.go
│   │   │   ├── zsyscall_openbsd_386.go
│   │   │   ├── zsyscall_openbsd_amd64.go
│   │   │   ├── zsyscall_plan9_386.go
│   │   │   ├── zsyscall_plan9_amd64.go
│   │   │   ├── zsyscall_windows_386.go
│   │   │   ├── zsyscall_windows_amd64.go
│   │   │   ├── zsysctl_openbsd.go
│   │   │   ├── zsysnum_darwin_386.go
│   │   │   ├── zsysnum_darwin_amd64.go
│   │   │   ├── zsysnum_dragonfly_386.go
│   │   │   ├── zsysnum_dragonfly_amd64.go
│   │   │   ├── zsysnum_freebsd_386.go
│   │   │   ├── zsysnum_freebsd_amd64.go
│   │   │   ├── zsysnum_freebsd_arm.go
│   │   │   ├── zsysnum_linux_386.go
│   │   │   ├── zsysnum_linux_amd64.go
│   │   │   ├── zsysnum_linux_arm.go
│   │   │   ├── zsysnum_netbsd_386.go
│   │   │   ├── zsysnum_netbsd_amd64.go
│   │   │   ├── zsysnum_netbsd_arm.go
│   │   │   ├── zsysnum_openbsd_386.go
│   │   │   ├── zsysnum_openbsd_amd64.go
│   │   │   ├── zsysnum_plan9_386.go
│   │   │   ├── zsysnum_plan9_amd64.go
│   │   │   ├── zsysnum_windows_386.go
│   │   │   ├── zsysnum_windows_amd64.go
│   │   │   ├── ztypes_darwin_386.go
│   │   │   ├── ztypes_darwin_amd64.go
│   │   │   ├── ztypes_dragonfly_386.go
│   │   │   ├── ztypes_dragonfly_amd64.go
│   │   │   ├── ztypes_freebsd_386.go
│   │   │   ├── ztypes_freebsd_amd64.go
│   │   │   ├── ztypes_freebsd_arm.go
│   │   │   ├── ztypes_linux_386.go
│   │   │   ├── ztypes_linux_amd64.go
│   │   │   ├── ztypes_linux_arm.go
│   │   │   ├── ztypes_netbsd_386.go
│   │   │   ├── ztypes_netbsd_amd64.go
│   │   │   ├── ztypes_netbsd_arm.go
│   │   │   ├── ztypes_openbsd_386.go
│   │   │   ├── ztypes_openbsd_amd64.go
│   │   │   ├── ztypes_plan9_386.go
│   │   │   ├── ztypes_plan9_amd64.go
│   │   │   ├── ztypes_windows.go
│   │   │   ├── ztypes_windows_386.go
│   │   │   └── ztypes_windows_amd64.go
│   │   ├── testing
│   │   │   ├── allocs.go
│   │   │   ├── benchmark.go
│   │   │   ├── benchmark_test.go
│   │   │   ├── cover.go
│   │   │   ├── example.go
│   │   │   ├── export_test.go
│   │   │   ├── iotest
│   │   │   │   ├── logger.go
│   │   │   │   ├── reader.go
│   │   │   │   └── writer.go
│   │   │   ├── quick
│   │   │   │   ├── quick.go
│   │   │   │   └── quick_test.go
│   │   │   └── testing.go
│   │   ├── text
│   │   │   ├── scanner
│   │   │   │   ├── scanner.go
│   │   │   │   └── scanner_test.go
│   │   │   ├── tabwriter
│   │   │   │   ├── example_test.go
│   │   │   │   ├── tabwriter.go
│   │   │   │   └── tabwriter_test.go
│   │   │   └── template
│   │   │       ├── doc.go
│   │   │       ├── example_test.go
│   │   │       ├── examplefiles_test.go
│   │   │       ├── examplefunc_test.go
│   │   │       ├── exec.go
│   │   │       ├── exec_test.go
│   │   │       ├── funcs.go
│   │   │       ├── helper.go
│   │   │       ├── multi_test.go
│   │   │       ├── parse
│   │   │       │   ├── lex.go
│   │   │       │   ├── lex_test.go
│   │   │       │   ├── node.go
│   │   │       │   ├── parse.go
│   │   │       │   └── parse_test.go
│   │   │       ├── template.go
│   │   │       └── testdata
│   │   │           ├── file1.tmpl
│   │   │           ├── file2.tmpl
│   │   │           ├── tmpl1.tmpl
│   │   │           └── tmpl2.tmpl
│   │   ├── time
│   │   │   ├── Makefile
│   │   │   ├── example_test.go
│   │   │   ├── export_test.go
│   │   │   ├── export_windows_test.go
│   │   │   ├── format.go
│   │   │   ├── genzabbrs.go
│   │   │   ├── internal_test.go
│   │   │   ├── sleep.go
│   │   │   ├── sleep_test.go
│   │   │   ├── sys_plan9.go
│   │   │   ├── sys_unix.go
│   │   │   ├── sys_windows.go
│   │   │   ├── tick.go
│   │   │   ├── tick_test.go
│   │   │   ├── time.go
│   │   │   ├── time_test.go
│   │   │   ├── zoneinfo.go
│   │   │   ├── zoneinfo_abbrs_windows.go
│   │   │   ├── zoneinfo_plan9.go
│   │   │   ├── zoneinfo_read.go
│   │   │   ├── zoneinfo_unix.go
│   │   │   ├── zoneinfo_windows.go
│   │   │   └── zoneinfo_windows_test.go
│   │   ├── unicode
│   │   │   ├── Makefile
│   │   │   ├── casetables.go
│   │   │   ├── digit.go
│   │   │   ├── digit_test.go
│   │   │   ├── graphic.go
│   │   │   ├── graphic_test.go
│   │   │   ├── letter.go
│   │   │   ├── letter_test.go
│   │   │   ├── maketables.go
│   │   │   ├── script_test.go
│   │   │   ├── tables.go
│   │   │   ├── utf16
│   │   │   │   ├── export_test.go
│   │   │   │   ├── utf16.go
│   │   │   │   └── utf16_test.go
│   │   │   └── utf8
│   │   │       ├── example_test.go
│   │   │       ├── utf8.go
│   │   │       └── utf8_test.go
│   │   └── unsafe
│   │       └── unsafe.go
│   ├── race.bash
│   ├── race.bat
│   ├── run.bash
│   ├── run.bat
│   ├── run.rc
│   └── sudo.bash
└── test
    ├── 235.go
    ├── 64bit.go
    ├── alias.go
    ├── alias1.go
    ├── append.go
    ├── args.go
    ├── assign.go
    ├── assign1.go
    ├── bench
    │   ├── garbage
    │   │   ├── Makefile
    │   │   ├── parser.go
    │   │   ├── peano.go
    │   │   ├── stats.go
    │   │   ├── tree.go
    │   │   └── tree2.go
    │   ├── go1
    │   │   ├── binarytree_test.go
    │   │   ├── fannkuch_test.go
    │   │   ├── fasta_test.go
    │   │   ├── fmt_test.go
    │   │   ├── gob_test.go
    │   │   ├── gzip_test.go
    │   │   ├── http_test.go
    │   │   ├── json_test.go
    │   │   ├── jsondata_test.go
    │   │   ├── mandel_test.go
    │   │   ├── parser_test.go
    │   │   ├── parserdata_test.go
    │   │   ├── regexp_test.go
    │   │   ├── revcomp_test.go
    │   │   ├── template_test.go
    │   │   └── time_test.go
    │   └── shootout
    │       ├── binary-tree-freelist.go
    │       ├── binary-tree-freelist.txt
    │       ├── binary-tree.c
    │       ├── binary-tree.go
    │       ├── binary-tree.txt
    │       ├── chameneosredux.c
    │       ├── chameneosredux.go
    │       ├── chameneosredux.txt
    │       ├── fannkuch-parallel.go
    │       ├── fannkuch-parallel.txt
    │       ├── fannkuch.c
    │       ├── fannkuch.go
    │       ├── fannkuch.txt
    │       ├── fasta-1000.out
    │       ├── fasta.c
    │       ├── fasta.go
    │       ├── fasta.txt
    │       ├── k-nucleotide-parallel.go
    │       ├── k-nucleotide-parallel.txt
    │       ├── k-nucleotide.c
    │       ├── k-nucleotide.go
    │       ├── k-nucleotide.txt
    │       ├── mandelbrot.c
    │       ├── mandelbrot.go
    │       ├── mandelbrot.txt
    │       ├── meteor-contest.c
    │       ├── meteor-contest.go
    │       ├── meteor-contest.txt
    │       ├── nbody.c
    │       ├── nbody.go
    │       ├── nbody.txt
    │       ├── pidigits.c
    │       ├── pidigits.go
    │       ├── pidigits.txt
    │       ├── regex-dna-parallel.go
    │       ├── regex-dna-parallel.txt
    │       ├── regex-dna.c
    │       ├── regex-dna.go
    │       ├── regex-dna.txt
    │       ├── reverse-complement.c
    │       ├── reverse-complement.go
    │       ├── reverse-complement.txt
    │       ├── spectral-norm-parallel.go
    │       ├── spectral-norm.c
    │       ├── spectral-norm.go
    │       ├── spectral-norm.txt
    │       ├── threadring.c
    │       ├── threadring.go
    │       ├── threadring.txt
    │       ├── timing.log
    │       └── timing.sh
    ├── bigalg.go
    ├── bigmap.go
    ├── blank.go
    ├── blank1.go
    ├── bom.go
    ├── bombad.go
    ├── bounds.go
    ├── bugs
    │   ├── bug395.go
    │   └── placeholder
    ├── chan
    │   ├── doubleselect.go
    │   ├── fifo.go
    │   ├── goroutines.go
    │   ├── nonblock.go
    │   ├── perm.go
    │   ├── powser1.go
    │   ├── powser2.go
    │   ├── select.go
    │   ├── select2.go
    │   ├── select3.go
    │   ├── select4.go
    │   ├── select5.go
    │   ├── select6.go
    │   ├── select7.go
    │   ├── sendstmt.go
    │   ├── sieve1.go
    │   ├── sieve2.go
    │   └── zerosize.go
    ├── chancap.go
    ├── char_lit.go
    ├── char_lit1.go
    ├── closedchan.go
    ├── closure.go
    ├── cmp.go
    ├── cmp6.go
    ├── cmplx.go
    ├── cmplxdivide.c
    ├── cmplxdivide.go
    ├── cmplxdivide1.go
    ├── complit.go
    ├── complit1.go
    ├── compos.go
    ├── const.go
    ├── const1.go
    ├── const2.go
    ├── const3.go
    ├── const4.go
    ├── const5.go
    ├── const6.go
    ├── convT2X.go
    ├── convert.go
    ├── convert1.go
    ├── convert3.go
    ├── convlit.go
    ├── convlit1.go
    ├── copy.go
    ├── crlf.go
    ├── ddd.go
    ├── ddd1.go
    ├── ddd2.dir
    │   ├── ddd2.go
    │   └── ddd3.go
    ├── ddd2.go
    ├── decl.go
    ├── declbad.go
    ├── defer.go
    ├── deferfin.go
    ├── deferprint.go
    ├── deferprint.out
    ├── divide.go
    ├── divmod.go
    ├── dwarf
    │   ├── dwarf.dir
    │   │   ├── main.go
    │   │   ├── z1.go
    │   │   ├── z10.go
    │   │   ├── z11.go
    │   │   ├── z12.go
    │   │   ├── z13.go
    │   │   ├── z14.go
    │   │   ├── z15.go
    │   │   ├── z16.go
    │   │   ├── z17.go
    │   │   ├── z18.go
    │   │   ├── z19.go
    │   │   ├── z2.go
    │   │   ├── z20.go
    │   │   ├── z3.go
    │   │   ├── z4.go
    │   │   ├── z5.go
    │   │   ├── z6.go
    │   │   ├── z7.go
    │   │   ├── z8.go
    │   │   └── z9.go
    │   ├── dwarf.go
    │   └── linedirectives.go
    ├── empty.go
    ├── env.go
    ├── eof.go
    ├── eof1.go
    ├── errchk
    ├── escape.go
    ├── escape2.go
    ├── escape3.go
    ├── escape4.go
    ├── escape5.go
    ├── fixedbugs
    │   ├── bug000.go
    │   ├── bug002.go
    │   ├── bug003.go
    │   ├── bug004.go
    │   ├── bug005.go
    │   ├── bug006.go
    │   ├── bug007.go
    │   ├── bug008.go
    │   ├── bug009.go
    │   ├── bug010.go
    │   ├── bug011.go
    │   ├── bug012.go
    │   ├── bug013.go
    │   ├── bug014.go
    │   ├── bug015.go
    │   ├── bug016.go
    │   ├── bug017.go
    │   ├── bug020.go
    │   ├── bug021.go
    │   ├── bug022.go
    │   ├── bug023.go
    │   ├── bug024.go
    │   ├── bug026.go
    │   ├── bug027.go
    │   ├── bug028.go
    │   ├── bug030.go
    │   ├── bug031.go
    │   ├── bug035.go
    │   ├── bug037.go
    │   ├── bug039.go
    │   ├── bug040.go
    │   ├── bug045.go
    │   ├── bug046.go
    │   ├── bug047.go
    │   ├── bug048.go
    │   ├── bug049.go
    │   ├── bug050.go
    │   ├── bug051.go
    │   ├── bug052.go
    │   ├── bug053.go
    │   ├── bug054.go
    │   ├── bug055.go
    │   ├── bug056.go
    │   ├── bug057.go
    │   ├── bug058.go
    │   ├── bug059.go
    │   ├── bug060.go
    │   ├── bug061.go
    │   ├── bug062.go
    │   ├── bug063.go
    │   ├── bug064.go
    │   ├── bug065.go
    │   ├── bug066.go
    │   ├── bug067.go
    │   ├── bug068.go
    │   ├── bug069.go
    │   ├── bug070.go
    │   ├── bug071.go
    │   ├── bug072.go
    │   ├── bug073.go
    │   ├── bug074.go
    │   ├── bug075.go
    │   ├── bug076.go
    │   ├── bug077.go
    │   ├── bug078.go
    │   ├── bug080.go
    │   ├── bug081.go
    │   ├── bug082.go
    │   ├── bug083.dir
    │   │   ├── bug0.go
    │   │   └── bug1.go
    │   ├── bug083.go
    │   ├── bug084.go
    │   ├── bug085.go
    │   ├── bug086.go
    │   ├── bug087.go
    │   ├── bug088.dir
    │   │   ├── bug0.go
    │   │   └── bug1.go
    │   ├── bug088.go
    │   ├── bug089.go
    │   ├── bug090.go
    │   ├── bug091.go
    │   ├── bug092.go
    │   ├── bug093.go
    │   ├── bug094.go
    │   ├── bug096.go
    │   ├── bug097.go
    │   ├── bug098.go
    │   ├── bug099.go
    │   ├── bug101.go
    │   ├── bug102.go
    │   ├── bug103.go
    │   ├── bug104.go
    │   ├── bug106.dir
    │   │   ├── bug0.go
    │   │   └── bug1.go
    │   ├── bug106.go
    │   ├── bug107.go
    │   ├── bug108.go
    │   ├── bug109.go
    │   ├── bug110.go
    │   ├── bug111.go
    │   ├── bug112.go
    │   ├── bug113.go
    │   ├── bug114.go
    │   ├── bug115.go
    │   ├── bug116.go
    │   ├── bug117.go
    │   ├── bug118.go
    │   ├── bug119.go
    │   ├── bug120.go
    │   ├── bug121.go
    │   ├── bug122.go
    │   ├── bug123.go
    │   ├── bug126.go
    │   ├── bug127.go
    │   ├── bug128.go
    │   ├── bug129.go
    │   ├── bug130.go
    │   ├── bug131.go
    │   ├── bug132.go
    │   ├── bug133.dir
    │   │   ├── bug0.go
    │   │   ├── bug1.go
    │   │   └── bug2.go
    │   ├── bug133.go
    │   ├── bug135.go
    │   ├── bug136.go
    │   ├── bug137.go
    │   ├── bug139.go
    │   ├── bug140.go
    │   ├── bug141.go
    │   ├── bug142.go
    │   ├── bug143.go
    │   ├── bug144.go
    │   ├── bug145.go
    │   ├── bug146.go
    │   ├── bug147.go
    │   ├── bug148.go
    │   ├── bug149.go
    │   ├── bug150.go
    │   ├── bug151.go
    │   ├── bug1515.go
    │   ├── bug152.go
    │   ├── bug154.go
    │   ├── bug155.go
    │   ├── bug156.go
    │   ├── bug157.go
    │   ├── bug158.go
    │   ├── bug159.go
    │   ├── bug160.dir
    │   │   ├── x.go
    │   │   └── y.go
    │   ├── bug160.go
    │   ├── bug161.go
    │   ├── bug163.go
    │   ├── bug164.go
    │   ├── bug165.go
    │   ├── bug167.go
    │   ├── bug168.go
    │   ├── bug169.go
    │   ├── bug170.go
    │   ├── bug171.go
    │   ├── bug172.go
    │   ├── bug173.go
    │   ├── bug174.go
    │   ├── bug175.go
    │   ├── bug176.go
    │   ├── bug177.go
    │   ├── bug178.go
    │   ├── bug179.go
    │   ├── bug180.go
    │   ├── bug181.go
    │   ├── bug182.go
    │   ├── bug183.go
    │   ├── bug184.go
    │   ├── bug185.go
    │   ├── bug186.go
    │   ├── bug187.go
    │   ├── bug188.go
    │   ├── bug189.go
    │   ├── bug190.go
    │   ├── bug191.dir
    │   │   ├── a.go
    │   │   ├── b.go
    │   │   └── main.go
    │   ├── bug191.go
    │   ├── bug191.out
    │   ├── bug192.go
    │   ├── bug193.go
    │   ├── bug194.go
    │   ├── bug195.go
    │   ├── bug196.go
    │   ├── bug197.go
    │   ├── bug198.go
    │   ├── bug199.go
    │   ├── bug200.go
    │   ├── bug201.go
    │   ├── bug202.go
    │   ├── bug203.go
    │   ├── bug204.go
    │   ├── bug205.go
    │   ├── bug206.go
    │   ├── bug206.out
    │   ├── bug207.go
    │   ├── bug208.go
    │   ├── bug209.go
    │   ├── bug211.go
    │   ├── bug212.go
    │   ├── bug213.go
    │   ├── bug214.go
    │   ├── bug215.go
    │   ├── bug216.go
    │   ├── bug217.go
    │   ├── bug218.go
    │   ├── bug219.go
    │   ├── bug221.go
    │   ├── bug222.dir
    │   │   ├── chanbug.go
    │   │   └── chanbug2.go
    │   ├── bug222.go
    │   ├── bug223.go
    │   ├── bug224.go
    │   ├── bug225.go
    │   ├── bug227.go
    │   ├── bug228.go
    │   ├── bug229.go
    │   ├── bug230.go
    │   ├── bug231.go
    │   ├── bug232.go
    │   ├── bug233.go
    │   ├── bug234.go
    │   ├── bug235.go
    │   ├── bug236.go
    │   ├── bug237.go
    │   ├── bug238.go
    │   ├── bug239.go
    │   ├── bug240.go
    │   ├── bug241.go
    │   ├── bug242.go
    │   ├── bug243.go
    │   ├── bug244.go
    │   ├── bug245.go
    │   ├── bug246.go
    │   ├── bug247.go
    │   ├── bug248.dir
    │   │   ├── bug0.go
    │   │   ├── bug1.go
    │   │   ├── bug2.go
    │   │   └── bug3.go
    │   ├── bug248.go
    │   ├── bug249.go
    │   ├── bug250.go
    │   ├── bug251.go
    │   ├── bug252.go
    │   ├── bug253.go
    │   ├── bug254.go
    │   ├── bug255.go
    │   ├── bug256.go
    │   ├── bug257.go
    │   ├── bug258.go
    │   ├── bug259.go
    │   ├── bug260.go
    │   ├── bug261.go
    │   ├── bug262.go
    │   ├── bug263.go
    │   ├── bug264.go
    │   ├── bug265.go
    │   ├── bug266.go
    │   ├── bug267.go
    │   ├── bug269.go
    │   ├── bug271.go
    │   ├── bug272.go
    │   ├── bug273.go
    │   ├── bug274.go
    │   ├── bug275.go
    │   ├── bug276.go
    │   ├── bug277.go
    │   ├── bug278.go
    │   ├── bug279.go
    │   ├── bug280.go
    │   ├── bug281.go
    │   ├── bug282.dir
    │   │   ├── p1.go
    │   │   └── p2.go
    │   ├── bug282.go
    │   ├── bug283.go
    │   ├── bug284.go
    │   ├── bug285.go
    │   ├── bug286.go
    │   ├── bug287.go
    │   ├── bug288.go
    │   ├── bug289.go
    │   ├── bug290.go
    │   ├── bug291.go
    │   ├── bug292.go
    │   ├── bug293.go
    │   ├── bug294.go
    │   ├── bug295.go
    │   ├── bug296.go
    │   ├── bug297.go
    │   ├── bug298.go
    │   ├── bug299.go
    │   ├── bug300.go
    │   ├── bug301.go
    │   ├── bug302.dir
    │   │   ├── main.go
    │   │   └── p.go
    │   ├── bug302.go
    │   ├── bug303.go
    │   ├── bug304.go
    │   ├── bug305.go
    │   ├── bug306.dir
    │   │   ├── p1.go
    │   │   └── p2.go
    │   ├── bug306.go
    │   ├── bug307.go
    │   ├── bug308.go
    │   ├── bug309.go
    │   ├── bug311.go
    │   ├── bug312.go
    │   ├── bug313.dir
    │   │   ├── a.go
    │   │   └── b.go
    │   ├── bug313.go
    │   ├── bug314.go
    │   ├── bug315.go
    │   ├── bug316.go
    │   ├── bug317.go
    │   ├── bug318.go
    │   ├── bug319.go
    │   ├── bug320.go
    │   ├── bug321.go
    │   ├── bug322.dir
    │   │   ├── lib.go
    │   │   └── main.go
    │   ├── bug322.go
    │   ├── bug323.go
    │   ├── bug324.dir
    │   │   ├── p.go
    │   │   └── prog.go
    │   ├── bug324.go
    │   ├── bug325.go
    │   ├── bug326.go
    │   ├── bug327.go
    │   ├── bug328.go
    │   ├── bug328.out
    │   ├── bug329.go
    │   ├── bug330.go
    │   ├── bug331.go
    │   ├── bug332.go
    │   ├── bug333.go
    │   ├── bug334.go
    │   ├── bug335.dir
    │   │   ├── a.go
    │   │   └── b.go
    │   ├── bug335.go
    │   ├── bug336.go
    │   ├── bug337.go
    │   ├── bug338.go
    │   ├── bug339.go
    │   ├── bug340.go
    │   ├── bug341.go
    │   ├── bug342.go
    │   ├── bug343.go
    │   ├── bug344.go
    │   ├── bug345.dir
    │   │   ├── io.go
    │   │   └── main.go
    │   ├── bug345.go
    │   ├── bug346.go
    │   ├── bug347.go
    │   ├── bug348.go
    │   ├── bug349.go
    │   ├── bug350.go
    │   ├── bug351.go
    │   ├── bug352.go
    │   ├── bug353.go
    │   ├── bug354.go
    │   ├── bug355.go
    │   ├── bug356.go
    │   ├── bug357.go
    │   ├── bug358.go
    │   ├── bug361.go
    │   ├── bug362.go
    │   ├── bug363.go
    │   ├── bug364.go
    │   ├── bug365.go
    │   ├── bug366.go
    │   ├── bug367.dir
    │   │   ├── p.go
    │   │   └── prog.go
    │   ├── bug367.go
    │   ├── bug368.go
    │   ├── bug369.dir
    │   │   └── pkg.go
    │   ├── bug369.go
    │   ├── bug370.go
    │   ├── bug371.go
    │   ├── bug372.go
    │   ├── bug373.go
    │   ├── bug374.go
    │   ├── bug375.go
    │   ├── bug376.go
    │   ├── bug377.dir
    │   │   ├── one.go
    │   │   └── two.go
    │   ├── bug377.go
    │   ├── bug378.go
    │   ├── bug379.go
    │   ├── bug380.go
    │   ├── bug381.go
    │   ├── bug382.dir
    │   │   ├── pkg.go
    │   │   └── prog.go
    │   ├── bug382.go
    │   ├── bug383.go
    │   ├── bug384.go
    │   ├── bug385_32.go
    │   ├── bug385_64.go
    │   ├── bug386.go
    │   ├── bug387.go
    │   ├── bug388.go
    │   ├── bug389.go
    │   ├── bug390.go
    │   ├── bug391.go
    │   ├── bug392.dir
    │   │   ├── one.go
    │   │   ├── pkg2.go
    │   │   └── pkg3.go
    │   ├── bug392.go
    │   ├── bug393.go
    │   ├── bug394.go
    │   ├── bug396.dir
    │   │   ├── one.go
    │   │   └── two.go
    │   ├── bug396.go
    │   ├── bug397.go
    │   ├── bug398.go
    │   ├── bug399.go
    │   ├── bug401.go
    │   ├── bug402.go
    │   ├── bug403.go
    │   ├── bug404.dir
    │   │   ├── one.go
    │   │   └── two.go
    │   ├── bug404.go
    │   ├── bug405.go
    │   ├── bug406.go
    │   ├── bug407.dir
    │   │   ├── one.go
    │   │   └── two.go
    │   ├── bug407.go
    │   ├── bug409.go
    │   ├── bug409.out
    │   ├── bug410.go
    │   ├── bug411.go
    │   ├── bug412.go
    │   ├── bug413.go
    │   ├── bug414.dir
    │   │   ├── p1.go
    │   │   └── prog.go
    │   ├── bug414.go
    │   ├── bug415.dir
    │   │   ├── p.go
    │   │   └── prog.go
    │   ├── bug415.go
    │   ├── bug416.go
    │   ├── bug417.go
    │   ├── bug418.go
    │   ├── bug419.go
    │   ├── bug420.go
    │   ├── bug421.go
    │   ├── bug422.go
    │   ├── bug423.go
    │   ├── bug424.dir
    │   │   ├── lib.go
    │   │   └── main.go
    │   ├── bug424.go
    │   ├── bug425.go
    │   ├── bug426.go
    │   ├── bug427.go
    │   ├── bug428.go
    │   ├── bug429.go
    │   ├── bug430.go
    │   ├── bug431.go
    │   ├── bug432.go
    │   ├── bug433.go
    │   ├── bug434.go
    │   ├── bug435.go
    │   ├── bug436.go
    │   ├── bug437.dir
    │   │   ├── one.go
    │   │   ├── two.go
    │   │   └── x.go
    │   ├── bug437.go
    │   ├── bug438.go
    │   ├── bug439.go
    │   ├── bug440_32.go
    │   ├── bug440_64.go
    │   ├── bug441.go
    │   ├── bug442.go
    │   ├── bug443.go
    │   ├── bug444.go
    │   ├── bug445.go
    │   ├── bug446.go
    │   ├── bug447.go
    │   ├── bug448.dir
    │   │   ├── pkg1.go
    │   │   └── pkg2.go
    │   ├── bug448.go
    │   ├── bug449.go
    │   ├── bug450.go
    │   ├── bug451.go
    │   ├── bug452.go
    │   ├── bug453.go
    │   ├── bug454.go
    │   ├── bug455.go
    │   ├── bug456.go
    │   ├── bug457.go
    │   ├── bug458.go
    │   ├── bug459.go
    │   ├── bug460.dir
    │   │   ├── a.go
    │   │   └── b.go
    │   ├── bug460.go
    │   ├── bug461.go
    │   ├── bug462.go
    │   ├── bug463.go
    │   ├── bug464.go
    │   ├── bug465.dir
    │   │   ├── a.go
    │   │   └── b.go
    │   ├── bug465.go
    │   ├── bug466.dir
    │   │   ├── a.go
    │   │   └── b.go
    │   ├── bug466.go
    │   ├── bug467.dir
    │   │   ├── p1.go
    │   │   ├── p2.go
    │   │   └── p3.go
    │   ├── bug467.go
    │   ├── bug468.dir
    │   │   ├── p1.go
    │   │   └── p2.go
    │   ├── bug468.go
    │   ├── bug470.go
    │   ├── bug471.go
    │   ├── bug472.dir
    │   │   ├── p1.go
    │   │   ├── p2.go
    │   │   └── z.go
    │   ├── bug472.go
    │   ├── bug473.go
    │   ├── bug474.go
    │   ├── bug475.go
    │   ├── bug476.go
    │   ├── bug477.go
    │   ├── bug478.dir
    │   │   ├── a.go
    │   │   └── b.go
    │   ├── bug478.go
    │   ├── bug479.dir
    │   │   ├── a.go
    │   │   └── b.go
    │   ├── bug479.go
    │   ├── issue2615.go
    │   ├── issue3552.dir
    │   │   ├── one.go
    │   │   └── two.go
    │   ├── issue3552.go
    │   ├── issue3705.go
    │   ├── issue3783.go
    │   ├── issue3924.go
    │   ├── issue3925.go
    │   ├── issue4066.go
    │   ├── issue4085a.go
    │   ├── issue4085b.go
    │   ├── issue4097.go
    │   ├── issue4099.go
    │   ├── issue4162.go
    │   ├── issue4167.go
    │   ├── issue4232.go
    │   ├── issue4251.go
    │   ├── issue4252.dir
    │   │   ├── a.go
    │   │   └── main.go
    │   ├── issue4252.go
    │   ├── issue4264.go
    │   ├── issue4283.go
    │   ├── issue4313.go
    │   ├── issue4316.go
    │   ├── issue4323.go
    │   ├── issue4326.dir
    │   │   ├── p1.go
    │   │   ├── p2.go
    │   │   ├── q1.go
    │   │   ├── q2.go
    │   │   └── z.go
    │   ├── issue4326.go
    │   ├── issue4348.go
    │   ├── issue4353.go
    │   ├── issue4359.go
    │   ├── issue4370.dir
    │   │   ├── p1.go
    │   │   ├── p2.go
    │   │   └── p3.go
    │   ├── issue4370.go
    │   ├── issue4396a.go
    │   ├── issue4396b.go
    │   ├── issue4399.go
    │   ├── issue4405.go
    │   ├── issue4429.go
    │   ├── issue4448.go
    │   ├── issue4452.go
    │   ├── issue4458.go
    │   ├── issue4463.go
    │   ├── issue4468.go
    │   ├── issue4470.go
    │   ├── issue4495.go
    │   ├── issue4510.dir
    │   │   ├── f1.go
    │   │   └── f2.go
    │   ├── issue4510.go
    │   ├── issue4517a.go
    │   ├── issue4517b.go
    │   ├── issue4517c.go
    │   ├── issue4517d.go
    │   ├── issue4518.go
    │   ├── issue4529.go
    │   ├── issue4545.go
    │   ├── issue4562.go
    │   ├── issue4585.go
    │   ├── issue4590.dir
    │   │   ├── pkg1.go
    │   │   ├── pkg2.go
    │   │   └── prog.go
    │   ├── issue4590.go
    │   ├── issue4610.go
    │   ├── issue4614.go
    │   ├── issue4618.go
    │   ├── issue4620.go
    │   ├── issue4654.go
    │   ├── issue4663.go
    │   ├── issue4667.go
    │   ├── issue4734.go
    │   ├── issue4748.go
    │   ├── issue4752.go
    │   ├── issue4776.go
    │   ├── issue4785.go
    │   ├── issue4813.go
    │   ├── issue4847.go
    │   ├── issue4879.dir
    │   │   ├── a.go
    │   │   └── b.go
    │   ├── issue4879.go
    │   ├── issue4909a.go
    │   ├── issue4909b.go
    │   ├── issue4932.dir
    │   │   ├── foo.go
    │   │   ├── state.go
    │   │   └── state2.go
    │   ├── issue4932.go
    │   ├── issue4964.dir
    │   │   ├── a.go
    │   │   └── b.go
    │   ├── issue4964.go
    │   ├── issue5002.go
    │   ├── issue5056.go
    │   ├── issue5089.go
    │   ├── issue5105.dir
    │   │   ├── a.go
    │   │   └── b.go
    │   ├── issue5105.go
    │   ├── issue5125.dir
    │   │   ├── bug.go
    │   │   └── main.go
    │   ├── issue5125.go
    │   ├── issue5162.go
    │   ├── issue5172.go
    │   ├── issue5231.go
    │   ├── issue5244.go
    │   ├── issue5259.dir
    │   │   ├── bug.go
    │   │   └── main.go
    │   ├── issue5259.go
    │   ├── issue5260.dir
    │   │   ├── a.go
    │   │   └── b.go
    │   ├── issue5260.go
    │   ├── issue5291.dir
    │   │   ├── pkg1.go
    │   │   └── prog.go
    │   ├── issue5291.go
    │   ├── issue5358.go
    │   ├── issue5470.dir
    │   │   ├── a.go
    │   │   └── b.go
    │   ├── issue5470.go
    │   ├── issue5493.go
    │   ├── issue5515.go
    │   ├── issue5581.go
    │   ├── issue5607.go
    │   ├── issue5609.go
    │   ├── issue5614.dir
    │   │   ├── rethinkgo.go
    │   │   ├── x.go
    │   │   └── y.go
    │   ├── issue5614.go
    │   ├── issue5698.go
    │   ├── issue5704.go
    │   ├── issue5753.go
    │   ├── issue5755.dir
    │   │   ├── a.go
    │   │   └── main.go
    │   ├── issue5755.go
    │   ├── issue5809.go
    │   ├── issue5820.go
    │   ├── issue5841.go
    │   ├── issue5856.go
    │   ├── issue5910.dir
    │   │   ├── a.go
    │   │   └── main.go
    │   ├── issue5910.go
    │   ├── issue5957.dir
    │   │   ├── a.go
    │   │   ├── b.go
    │   │   └── c.go
    │   ├── issue5957.go
    │   ├── issue5963.go
    │   ├── issue6004.go
    │   ├── issue6036.go
    │   ├── issue6055.go
    │   ├── issue6131.go
    │   ├── issue6140.go
    │   ├── issue6247.go
    │   ├── issue6269.go
    │   ├── issue6298.go
    │   ├── issue6399.go
    │   ├── issue6513.dir
    │   │   ├── a.go
    │   │   ├── b.go
    │   │   └── main.go
    │   ├── issue6513.go
    │   └── issue887.go
    ├── float_lit.go
    ├── floatcmp.go
    ├── for.go
    ├── func.go
    ├── func1.go
    ├── func2.go
    ├── func3.go
    ├── func4.go
    ├── func5.go
    ├── func6.go
    ├── func7.go
    ├── func8.go
    ├── funcdup.go
    ├── funcdup2.go
    ├── gc.go
    ├── gc1.go
    ├── gc2.go
    ├── golden.out
    ├── goprint.go
    ├── goprint.out
    ├── goto.go
    ├── helloworld.go
    ├── helloworld.out
    ├── if.go
    ├── import.go
    ├── import1.go
    ├── import2.dir
    │   ├── import2.go
    │   └── import3.go
    ├── import2.go
    ├── import4.dir
    │   ├── empty.go
    │   └── import4.go
    ├── import4.go
    ├── import5.go
    ├── index.go
    ├── index0.go
    ├── index1.go
    ├── index2.go
    ├── indirect.go
    ├── indirect1.go
    ├── init.go
    ├── init1.go
    ├── initcomma.go
    ├── initialize.go
    ├── initializerr.go
    ├── int_lit.go
    ├── intcvt.go
    ├── interface
    │   ├── bigdata.go
    │   ├── convert.go
    │   ├── convert1.go
    │   ├── convert2.go
    │   ├── embed.go
    │   ├── embed1.dir
    │   │   ├── embed0.go
    │   │   └── embed1.go
    │   ├── embed1.go
    │   ├── embed2.go
    │   ├── explicit.go
    │   ├── fail.go
    │   ├── fake.go
    │   ├── noeq.go
    │   ├── pointer.go
    │   ├── private.dir
    │   │   ├── private1.go
    │   │   └── prog.go
    │   ├── private.go
    │   ├── receiver.go
    │   ├── receiver1.go
    │   ├── recursive.go
    │   ├── recursive1.dir
    │   │   ├── recursive1.go
    │   │   └── recursive2.go
    │   ├── recursive1.go
    │   ├── returntype.go
    │   └── struct.go
    ├── iota.go
    ├── ken
    │   ├── array.go
    │   ├── chan.go
    │   ├── chan1.go
    │   ├── complit.go
    │   ├── convert.go
    │   ├── cplx0.go
    │   ├── cplx0.out
    │   ├── cplx1.go
    │   ├── cplx2.go
    │   ├── cplx3.go
    │   ├── cplx4.go
    │   ├── cplx5.go
    │   ├── divconst.go
    │   ├── divmod.go
    │   ├── embed.go
    │   ├── for.go
    │   ├── interbasic.go
    │   ├── interfun.go
    │   ├── intervar.go
    │   ├── label.go
    │   ├── litfun.go
    │   ├── mfunc.go
    │   ├── modconst.go
    │   ├── ptrfun.go
    │   ├── ptrvar.go
    │   ├── range.go
    │   ├── rob1.go
    │   ├── rob2.go
    │   ├── robfor.go
    │   ├── robfunc.go
    │   ├── shift.go
    │   ├── simparray.go
    │   ├── simpbool.go
    │   ├── simpconv.go
    │   ├── simpfun.go
    │   ├── simpswitch.go
    │   ├── simpvar.go
    │   ├── slicearray.go
    │   ├── sliceslice.go
    │   ├── string.go
    │   ├── string.out
    │   └── strvar.go
    ├── label.go
    ├── label1.go
    ├── linkx.go
    ├── literal.go
    ├── mallocfin.go
    ├── map.go
    ├── map1.go
    ├── mapnan.go
    ├── method.go
    ├── method1.go
    ├── method2.go
    ├── method3.go
    ├── method4.dir
    │   ├── method4a.go
    │   └── prog.go
    ├── method4.go
    ├── method5.go
    ├── named.go
    ├── named1.go
    ├── nil.go
    ├── nilcheck.go
    ├── nilptr.go
    ├── nilptr2.go
    ├── nilptr3.go
    ├── nul1.go
    ├── parentype.go
    ├── peano.go
    ├── printbig.go
    ├── printbig.out
    ├── range.go
    ├── recover.go
    ├── recover1.go
    ├── recover2.go
    ├── recover3.go
    ├── rename.go
    ├── rename1.go
    ├── reorder.go
    ├── reorder2.go
    ├── return.go
    ├── rotate.go
    ├── rotate0.go
    ├── rotate1.go
    ├── rotate2.go
    ├── rotate3.go
    ├── run
    ├── run.go
    ├── rune.go
    ├── runtime.go
    ├── safe
    │   ├── main.go
    │   ├── nousesafe.go
    │   ├── pkg.go
    │   └── usesafe.go
    ├── shift1.go
    ├── shift2.go
    ├── sieve.go
    ├── sigchld.go
    ├── sigchld.out
    ├── simassign.go
    ├── sinit.go
    ├── sizeof.go
    ├── slice3.go
    ├── slice3err.go
    ├── solitaire.go
    ├── stack.go
    ├── stress
    │   ├── maps.go
    │   ├── parsego.go
    │   └── runstress.go
    ├── string_lit.go
    ├── stringrange.go
    ├── struct0.go
    ├── switch.go
    ├── switch3.go
    ├── switch4.go
    ├── syntax
    │   ├── chan.go
    │   ├── chan1.go
    │   ├── composite.go
    │   ├── else.go
    │   ├── forvar.go
    │   ├── if.go
    │   ├── import.go
    │   ├── interface.go
    │   ├── semi1.go
    │   ├── semi2.go
    │   ├── semi3.go
    │   ├── semi4.go
    │   ├── semi5.go
    │   ├── semi6.go
    │   ├── semi7.go
    │   ├── topexpr.go
    │   ├── typesw.go
    │   ├── vareq.go
    │   └── vareq1.go
    ├── testlib
    ├── torture.go
    ├── turing.go
    ├── typecheck.go
    ├── typeswitch.go
    ├── typeswitch1.go
    ├── typeswitch2.go
    ├── typeswitch3.go
    ├── undef.go
    ├── utf.go
    ├── varerr.go
    ├── varinit.go
    └── zerodivide.go

386 directories, 3814 files
