Dart Advent Calendar 2013/12/19 Dart VMのオプション紹介
###############################################################################

dartのオプションを頻繁に参照する人なんてほとんどいないと思いますが、
私自身の勉強のためにまとめました。

オプションの一覧は、dart -vで出力されます。大変便利ですね。

dartのオプション一覧
*******************************************************************************

::

  $ dart -v
  Usage: dart [<vm-flags>] <dart-script-file> [<dart-options>]

  Executes the Dart script passed as <dart-script-file>.

  Supported options:


--checked or -c
===============================================================================
Insert runtime type checks and enable assertions (checked mode).

checked modeでvmを起動します。
productionと比較し、checked modeでは以下の特徴があります。

#1 JITコンパイル時の型エラーを無視しない。
#2 JITコンパイル時にassignable系の命令を生成し、挿入する。
#3 実行時にassignable命令で型チェックを行い、型エラーがあればAssertionを投げる。

もしかしたら他にもたくさんの型チェックが走るかもしれない。

--help or -h
===============================================================================
Display this message (add -v or --verbose for information about all VM options).

--package-root=<path> or -p<path>
===============================================================================
Where to find packages, that is, "package:..." imports.

--version
===============================================================================
Print the VM version.

VMのバージョンを表示します。
例
Dart VM version: 1.1.0-edge.31135 (Sat Dec 14 09:04:26 2013) on "linux_ia32"

--debug[:<port number>]
===============================================================================
enables debugging and listens on specified port for debugger connections
(default port number is 5858)

JVMのリモートデバッグみたいな機能で、特定のportでデバッガの接続待ちを行います。

--break-at=<location>
===============================================================================
sets a breakpoint at specified location where <location> is one of :
url:<line_num> e.g. test.dart:10
[<class_name>.]<function_name> e.g. B.foo

ブレークポイントを設定します。これはDart Editorとの連携用かな。

--snapshot=<file_name>
===============================================================================
loads Dart script and generates a snapshot in the specified file

対象のDartのソースコードをsnapshotして、hexに出力したファイルを生成します。

snapshotファイルは、dartのcoreのscriptと、ユーザが指定したソースコード一式を
scanした状態をsnapshotファイル(バイナリファイル)に出力します。
snapshotファイルからdeserializeして読み込むことにより、高速に起動できます。

どのくらい起動が短縮されるのかは、dartのtime系のオプションで測定することができます。
coreのscriptをファイルからloadする場合、1000 ms程度かかりますが、
snapshotからdeserializeすることにより、1000 nsに短縮されます。
読み込んだ後にも初期化処理やisolatの生成、コンパイル処理が走るため、起動時間トータルでは1/10程度に短縮されます。
//dartはデフォルトで、coreのscriptファイルをsnapshot形式にserializeし、dartのバイナリに埋め込まれています。

--print-script
===============================================================================
generates Dart source code back and prints it after parsing a Dart script

上記のsnapshotと関連し、デフォルトではDartのcoreのソースコードはsnapshotされているため、
snapshotからdeserializeしたソースコードをprintします。

--enable-vm-service[:<port number>]
===============================================================================
enables the VM service and listens on specified port for connections
(default port number is 8181)

The following options are only used for VM development and may
be changed in any future version:

外部連携用の待ち受けportを指定し、HTTP Serverを起動します。
主にvmの内部情報を参照したり、統計情報を参照できます。
今のところGETで入力データを指定し、JSONで結果を返します。


VMのオプション一覧
*******************************************************************************

-vでダンプする書式は、フラグ名:初期値 (説明文)に統一されています。

フラグを指定する場合、
dart --allocation_sinking=false や、dart --allocation-sinking=trueのように指定可能です。

_と-は、どちらを使用してもOKです。bool型のオプションは、=trueを省略してもOKです。


また、紹介するオプションには、わかりやすいようにタグ付けして分類します。
タグ付けは以下になります。

[Parser] Parserの制御、errorやwarningや型チェックなどなど
[Optimize] 最適化関連。性能向上するもの。
[Runtime] Runtimeの挙動の制御。
[GC] GCの制御。
[Trace] VM内部のデバッグに有効活用できる、内部処理のTrace情報を出力する処理。
[Service] VMの外部サービス(デバッガやプロファイラ)との連携を制御する。
[Print] VMの内部状態やIRをprintする処理。
[Time] VM内部の処理時間を測定する処理。
[Verify] 実行時にverifyを行い、不正な状態になったらassertします。

allocation_sinking: true (Attempt to sink temporary allocations to side exits)
===============================================================================
[Optimize]
allocation_sinking最適化を適応します。
一時的なオブジェクトの新規生成(new)をstackへの確保に置換します。


always_drop_code: false (Always try to drop code if the function's usage counter is >= 0)
===============================================================================
[GC]
不要なコードをGCで回収します。
例えば、最適化前と最適化後のコードが混在する場合、最適化前のコードは冗長とみなし削除可能です。


array_bounds_check_elimination: true (Eliminate redundant bounds checks.)
===============================================================================
[Optimize]
冗長な配列の境界チェックコードを除去します。


check_function_fingerprints: false (Check function fingerprints)
===============================================================================
[Runtime]
組み込み関数には、すべてfingerprint(hash)が組み込まれており、
起動時に書き換えられていないかチェックします。


checked: (Enable checked mode.)
===============================================================================
[Runtime]
VMをcheckedモードで起動します。


code_collection_interval_in_us: 30000000 (Time between attempts to collect unused code.)
===============================================================================
[GC]
最適化前のコードなど、まったく呼び出されないコードをGCする際のしきい値です。
30sec以上呼び出されないコードのGCを試します。

code_comments: false (Include comments into code and disassembly)
===============================================================================
[Runtime]
アセンブルする際に、コメントを埋め込みます。
アセンブルしたコードのデバッグ時に有効です。

collect_code: true (Attempt to GC infrequently used code.)
===============================================================================
[GC]
不要と判断したコードをGCします。

common_subexpression_elimination: true (Do common subexpression elimination.)
===============================================================================
[Optimize]
冗長なコードを除去します。
処理的にはGlobalValueNumberingと同等です。


compiler_stats: false (Compiler stat counters.)
===============================================================================
[Time][Print]
コンパイラがコンパイル時に各種統計情報を収集し、出力します。

ex) ::

  ==== Compiler Stats ====
  Number of tokens:   203
    Literal tokens:   14
    Ident tokens:     41
  Tokens consumed:    33157 (163.33 times number of tokens)
  Tokens checked:     120021  (3.62 times tokens consumed)
  Token rewind:       2757 (2% of tokens checked)
  Token lookahead:    4848 (4% of tokens checked)
  Source length:      728 characters
  Scanner time:       0 msecs
  Parser time:        15 msecs
  Code gen. time:     13 msecs
    Graph builder:    3 msecs
    Graph SSA:        0 msecs
    Graph inliner:    0 msecs
      Parsing:        0 msecs
      Building:       0 msecs
      SSA:            0 msecs
      Optimization:   0 msecs
      Substitution:   0 msecs
    Graph optimizer:  0 msecs
    Graph compiler:   6 msecs
    Code finalizer:   1 msecs
  Compilation speed:  6 tokens per msec
  Code size:          111 KB
  Code density:       1 tokens per KB

compress_deopt_info: true (Compress the size of the deoptimization info for optimized code.)
===============================================================================
[Runtime]
冗長なdeopt infoを畳み込んで、サイズを縮小します。


constant_propagation: true (Do conditional constant propagation/unreachable code elimination.)
===============================================================================
[Optimize]
定数伝搬最適化を適応します。
あと、定数伝搬の結果、条件式を畳み込み、到達しない分岐のコードの除去を行います。

coverage_dir: (null) (Enable writing coverage data into specified directory.)
===============================================================================
[Service]
実行したコードのカバレージ情報をjson形式で出力します。その出力するディレクトリを指定します。
デフォルトの出力ファイル名は、dart-cov-プロセスNo-謎の番号.jsonです。

deoptimization_counter_inlining_threshold: 12 (How many times we allow deoptimization before we stop inlining.)
===============================================================================
[Optimize]
頻繁にdeoptされたコードのinliningを抑止します。deoptimizeされた回数のしきい値です。


deoptimization_counter_licm_threshold: 8 (How many times we allow deoptimization before we disable LICM.)
===============================================================================
[Optimize]
頻繁にdeoptされたコードのlicmを抑止します。deoptimizeされた回数のしきい値です。

deoptimization_counter_threshold: 16 (How many times we allow deoptimization before we disallow optimization.)
===============================================================================
[Runtime]
deoptimizeの回数をカウントし、上限に達すると、そのmethodは最適化JITコンパイルされなくなります。


deoptimize_alot: false (Deoptimizes all live frames when we are about to return to Dart code from native entries.)
===============================================================================
[Runtime]
Deoptimize時に全部戻します。

disassemble: false (Disassemble dart code.)
===============================================================================
[Print]
dartが最初にJITコンパイルしたコードをdisassembleして出力します。

disassemble_optimized: false (Disassemble optimized code.)
===============================================================================
[Print]
dartがhotなコードを対象に、再JITコンパイルして最適化したコードをdisassembleして出力します。

disassemble_stubs: false (Disassemble generated stubs.)
===============================================================================
[Print]
dart vmが起動時に生成するstabのコードをdisassembleして出力します。

dump_symbol_stats: false (Dump symbol table statistics)
===============================================================================
[Print]

eliminate_type_checks: true (Eliminate type checks when allowed by static type analysis.)
===============================================================================
[Optimize]
冗長な型チェック、型キャストを除去します。
たとえば、JITコンパイルが安全のために生成する、checkSmiとかcheckDouble等の命令です。


enable_asserts: false (Enable assert statements.)
===============================================================================
[Runtime]
asignable命令を挿入し、実行時の型チェックのassertionを埋め込みます。


enable_checked_mode: (Enable checked mode.)
===============================================================================
[Runtime]
checkedモードを有効にします。


enable_simd_inline: true (Enable inlining of SIMD related method calls.)
===============================================================================
[Optimize]
simdのレジスタを、unboxの対象にしたり、simd系のintrinsicsをVM内部のIRのレベルでinlineします。

enable_type_checks: false (Enable type checks.)
===============================================================================
[Runtime]
JITコンパイル時の型チェックを有効にします。
checkedモードに応じてtrueになります。


error_on_bad_override: false (Report error for bad overrides.)
===============================================================================
[Parser]
parser時とコンパイルしたコードのfinalize時にbad_overrideかチェックを行い、
Reportを出力します。


error_on_bad_type: false (Report error for malformed types.)
===============================================================================
[Parser]
parser時とコンパイルしたコードのfinalize時にbad_overrideかチェックを行い、
Reportを出力します。

gc_at_alloc: false (GC at every allocation.)
===============================================================================
[GC]
allocのたびにGCを起動します。
これはGCのデバッグ用のオプションかな。


generate_gdb_symbols: false (Generate symbols of generated dart functions for debugging with GDB)
===============================================================================
[Service]
VM自体のgdbシンボルを生成します。
VM自体をリモートでデバッグしたりできるはず。
linuxとandroidで有効です。

generate_perf_events_symbols: false (Generate events symbols for profiling with perf)
===============================================================================
[Service]
vmの中身をperfでプロファイル取りたい場合、
perf用にsymbol tableを出力します。


generate_pprof_symbols: (null) (Writes pprof events symbols to the provided file)
===============================================================================
[Service]
google-perftools pprof用のシンボルテーブルを生成します。


heap_growth_rate: 4 (The size the heap is grown, in heap pages)
===============================================================================
[GC]


heap_growth_space_ratio: 10 (The desired maximum percentage of free space after GC)
===============================================================================
[GC]


heap_growth_time_ratio: 3 (The desired maximum percentage of time spent in GC)
===============================================================================
[GC]


heap_profile_initialize: false (Writes a heap profile on isolate initialization.)
===============================================================================
[GC]


heap_profile_out_of_memory: false (Writes a heap profile on unhandled out-of-memory exceptions.)
===============================================================================
[GC]


huge_method_cutoff_in_code_size: 200000 (Huge method cutoff in unoptimized code size (in bytes).)
===============================================================================
[Optimize]


huge_method_cutoff_in_tokens: 20000 (Huge method cutoff in tokens: Disables optimizations for huge methods.)
===============================================================================
[Optimize]


ignore_unrecognized_flags: false (Ignore unrecognized flags.)
===============================================================================
[Optimize]

inline_alloc: true (Inline allocation of objects.)
==============================================================================
alloc処理をinline展開します。
heapのalloc命令呼び出しのオーバーヘッドを削除できます。

inline_recursive: true (Inline recursive calls.)
===============================================================================
再帰関数のinline展開を有効にします。
このオプションを有効にすると、fiboみたいな再帰関数もなんどかインライン展開できます。

inlining_callee_call_sites_threshold: 1 (Always inline functions containing threshold or fewer calls.)
===============================================================================
[Optimize]
inline対象の関数を呼んでいるcalleeが1つ以下の場合、積極的にinline展開します。

inlining_caller_size_threshold: 50000 (Stop inlining once caller reaches the threshold.)
===============================================================================
[Optimize]
inline展開したメソッドの命令数のサイズの閾値です。これ以上にならないようにインライン展開します。

inlining_constant_arguments_count: 1 (Inline function calls with sufficient constant arguments and up to the increased threshold on instructions)
===============================================================================
[Optimize]
inline展開するメソッドに、定数の引数が1つ以上あれば、定数伝搬による更なる最適化が期待できるため、
積極的にインライン展開します。

inlining_constant_arguments_size_threshold: 60 (Inline function calls with sufficient constant arguments and up to the increased threshold on instructions)
===============================================================================
[Optimize]

inlining_depth_threshold: 3 (Inline function calls up to threshold nesting depth)
===============================================================================
[Optimize]
インライン展開する関数のcall chainの深さの閾値を指定します。

inlining_filter: (null) (Inline only in named function)
===============================================================================
[Optimize]
inline展開の対象関数を指定します。
null以外の場合、指定された関数以外をinline展開しません。

inlining_hotness: 10 (Inline only hotter calls, in percents (0 .. 100); default 10%: calls above-equal 10% of max-count are inlined.)
===============================================================================
[Optimize]

inlining_size_threshold: 25 (Always inline functions that have threshold or fewer instructions)
===============================================================================
[Optimize]
インライン展開のしきい値をしています。
インライン展開対象が大きすぎないように、25より少ないinstructionを内包する関数のみ展開します。

intrinsify: true (Instrinsify when possible)
===============================================================================


ll_prof: false (Generate compiled code log file for processing with ll_prof.py.)
===============================================================================
[Service]
ll_profツール用のlogファイルを生成します。
V8にも同様のオプションが存在する。

load_cse: true (Use redundant load elimination.)
===============================================================================
[Optimize]
冗長なload命令の削除を行い、先行してloadした値で置き換えます。


log_code_drop: false (Emit a log message when pointers to unused code are dropped.)
===============================================================================
[GC]
コードをGCで回収した場合にlogを出力します。


loop_invariant_code_motion: true (Do loop invariant code motion.)
===============================================================================
[Optimize]
通称LICM
ループ中の不変式を、ループの外に追い出します。


max_equality_polymorphic_checks: 32 (Maximum number of polymorphic checks in equality operator, otherwise use megamorphic dispatch.)
===============================================================================
[Optimize]


max_polymorphic_checks: 4 (Maximum number of polymorphic check, otherwise it is megamorphic.)
===============================================================================
[Optimize]


max_subtype_cache_entries: 100 (Maximum number of subtype cache entries (number of checks cached).)
===============================================================================
[Optimize]

new_gen_heap_size: 32 (new gen heap size in MB,e.g: --new_gen_heap_size=64 allocates a 64MB new gen heap)
===============================================================================
[GC]
new領域のサイズを指定します。デフォルトは32MBです。

old_gen_heap_size: 512 (old gen heap size in MB,e.g: --old_gen_heap_size=1024 allocates a 1024MB old gen heap)
===============================================================================
[GC]
old領域の最大値を指定します。デフォルトは512MBです。
最初の起動時は1MBだったりしますが、自動的に伸長していきます。

optimization_counter_threshold: 15000 (Function's usage-counter value before it is optimized, -1 means never)
===============================================================================
[Optimize]
最適化コンパイルのしきい値です。このcounterが何度もmethodを呼ばれたり、内包するループを回ると現象していきます。
0になると最適化JITコンパイラが起動します。

optimization_filter: (null) (Optimize only named function)
===============================================================================
[Optimize]
最適化対象の関数を指定します。
もしnull以外の場合、指定の関数以外を最適化しません。

optimize_try_catch: true (Optimization of try-catch)
===============================================================================
[Optimize]
try-catchおよび例外を投げるBBやpathを最適化します。


overlap_type_arguments: true (When possible, partially or fully overlap the type arguments of a type with the type arguments of its super type.)
===============================================================================
[Runtime]

print_ast: false (Print abstract syntax tree.)
===============================================================================
[Print]

print_class_table: false (Print initial class table.)
===============================================================================
[Print]

print_classes: false (Prints details about loaded classes.)
===============================================================================
[Print]

print_environments: false (Print SSA environments.)
===============================================================================
[Print]

print_flags: true (Print flags as they are being parsed.)
===============================================================================
[Print]
print_flow_graph: false (Print the IR flow graph.)
===============================================================================
[Print]
FlowGraphは、VM内の中間表現です。

print_flow_graph_optimized: false (Print the IR flow graph when optimizing.)
===============================================================================
[Print]
最適化後のIRをprintします。

print_free_list_after_gc: false (Print free list statistics after a GC)
===============================================================================
[Print]
free_listを使用するのは、old領域のmark&sweep GCです

print_free_list_before_gc: false (Print free list statistics before a GC)
===============================================================================
[Print]
free_listを使用するのは、old領域のmark&sweep GCです

print_object_histogram: false (Print average object histogram at isolate shutdown)
===============================================================================
[Print]

print_scopes: false (Print scopes of local variables.)
===============================================================================
[Print]

print_ssa_liveness: false (Print liveness for ssa variables.)
===============================================================================
[Print]
レジスタ割付前の、liveness解析の結果をprintします。

print_ssa_liveranges: false (Print live ranges after allocation.)
===============================================================================
[Print]
レジスタ割付前の、liverangeをprintします。

print_stacktrace_at_throw: false (Prints a stack trace everytime a throw occurs.)
===============================================================================
[Print]

print_stop_message: true (Print stop message.)
===============================================================================
[Print]

print_tokens: false (Print scanned tokens.)
===============================================================================
[Print]


profile: false (Enable Sampling Profiler)
===============================================================================
[Runtime]

propagate_ic_data: true (Propagate IC data from unoptimized to optimized IC calls.)
===============================================================================
[Ooptimize]
IC callを最適化し、最適化したIRに変換します。

random_seed: 0 (Override the random seed for debugging.)
===============================================================================
[Runtime]
VM内に埋め込まれた乱数生成機のSeedを指定します。


range_analysis: true (Enable range analysis)
===============================================================================
[Optimize]
変数や定数のRange Analysisを行います。


remove_redundant_phis: true (Remove redundant phis.)
===============================================================================
[Optimize]
冗長なphiノードを除去します。

reoptimization_counter_threshold: 2000 (Counter threshold before a function gets reoptimized.)
===============================================================================
[Optimize]
Deoptimizeされた後に、カウンターをリセットします。
再度カウンターが0になったら最適化を行います。

reorder_basic_blocks: true (Enable basic-block reordering.)
===============================================================================
[Optimize]
BBの並び替えを行います。blog参照。


report_usage_count: false (Track function usage and report.)
===============================================================================
[Runtime]
関数単位にusage_countを出力します。
usage_countは、呼び出された回数と、内包しているループの回転数により減少していきます。

show_internal_names: false (Show names of internal classes (e.g. "OneByteString") in error messages instead of showing the corresponding interface names (e.g. "String"))
===============================================================================
[Runtime]
todo
VM内部のC++オブジェクトの名称を出力


silent_warnings: false (Silence warnings.)
===============================================================================
todo


stop_on_excessive_deoptimization: false (Debugging: stops program if deoptimizing same function too often)
===============================================================================


support_find_in_context: false (Experimental support for ClosureMirror.findInContext.)
===============================================================================


throw_on_javascript_int_overflow: false (Throw an exception when the result of an integer calculation will not fit into a javascript integer.)
===============================================================================
[Runtime]
javascriptとの互換性のために、intの実行時の範囲チェックを行います。
dartのintはsmi/mint/bigintgerまでスケールしますが、dart2jsで生成したjavascriptはそうではありません。
dartの各種演算の結果をチェックし、javascriptで表現できる限界を越えた際に例外を投げるコードを、
コンパイル時に埋め込みます。


time_all: false (Time all functionality)
===============================================================================
[Time]

time_bootstrap: false (time_bootstrap)
===============================================================================
[Time]

time_compilation: false (time_compilation)
===============================================================================
[Time]

time_creating_snapshot: false (time_creating_snapshot)
===============================================================================
[Time]

time_isolate_initialization: false (time_isolate_initialization)
===============================================================================
[Time]

time_script_loading: false (time_script_loading)
===============================================================================
[Time]

time_total_runtime: false (time_total_runtime)
===============================================================================
[Time]

trace_api: false (Trace invocation of API calls (debug mode only))
===============================================================================
[Trace]

trace_bailout: false (Print bailout from ssa compiler.)
===============================================================================
[Trace]

trace_class_finalization: false (Trace class finalization.)
===============================================================================
[Trace]

trace_compiler: false (Trace compiler operations.)
===============================================================================
[Trace]

trace_constant_propagation: false (Print constant propagation and useless code elimination.)
===============================================================================
[Trace]

trace_deoptimization: false (Trace deoptimization)
===============================================================================
[Trace]

trace_deoptimization_verbose: false (Trace deoptimization verbose)
===============================================================================
[Trace]

trace_disabling_optimized_code: false (Trace disabling optimized code.)
===============================================================================
[Trace]

trace_failed_optimization_attempts: false (Traces all failed optimization attempts)
===============================================================================
[Trace]

trace_ic: false (Trace IC handling)
===============================================================================
[Trace]

trace_ic_miss_in_optimized: false (Trace IC miss in optimized code)
===============================================================================
[Trace]

trace_inlining: false (Trace inlining)
===============================================================================
[Trace]

trace_intrinsified_natives: false (Report if any of the intrinsified natives are called)
===============================================================================
[Trace]

trace_isolates: false (Trace isolate creation and shut down.)
===============================================================================
[Trace]

trace_load_optimization: false (Print live sets for load optimization pass.)
===============================================================================
[Trace]

trace_natives: false (Trace invocation of natives (debug mode only))
===============================================================================
[Trace]

trace_optimization: false (Print optimization details.)
===============================================================================
[Trace]

trace_optimized_ic_calls: false (Trace IC calls in optimized code.)
===============================================================================
[Trace]

trace_osr: false (Trace attempts at on-stack replacement.)
===============================================================================
[Trace]

trace_parser: false (Trace parser operations.)
===============================================================================
[Trace]

trace_patching: false (Trace patching of code.)
===============================================================================
[Trace]

trace_profiled_isolates: false (Trace profiled isolates.)
===============================================================================
[Trace]

trace_range_analysis: false (Trace range analysis progress)
===============================================================================
[Trace]

trace_resolving: false (Trace resolving.)
===============================================================================
[Trace]

trace_runtime_calls: false (Trace runtime calls)
===============================================================================
[Trace]

trace_ssa_allocator: false (Trace register allocation over SSA.)
===============================================================================
[Trace]

trace_type_check_elimination: false (Trace type check elimination at compile time.)
===============================================================================
[Trace]

trace_type_checks: false (Trace runtime type checks.)
===============================================================================
[Trace]

trace_type_finalization: false (Trace type finalization.)
===============================================================================
[Trace]

trace_type_propagation: false (Trace flow graph type propagation)
===============================================================================
[Trace]

trap_on_deoptimization: false (Trap on deoptimization.)
===============================================================================
[Runtime]
deoptimize起動の直前に、int3でtrapできるように埋め込んで置きます。

truncating_left_shift: true (Optimize left shift to truncate if possible)
===============================================================================
[Optimize]
左シフトの最適化を行います。
具体的には、左シフトの数が定数、もしくはrange checkの結果
SmiやMintの範囲からあふれない場合、割り切ったshiftを行います。

unbox_mints: true (Optimize 64-bit integer arithmetic.)
===============================================================================
[Optimize]
mintをunboxする最適化を行います。
mintは32bit環境化では
63bitのintegerをxmmにunboxして計算を行います。


use_cha: true (Use class hierarchy analysis.)
===============================================================================
[Runtime]
class hierarchy analysisを有効にし、type checkやfinalize時にloadしすぎた不要なクラスを削除します。


use_inlining: true (Enable call-site inlining)
===============================================================================
[Optimize]
インライン展開を行います。


use_mirrored_compilation_error: false
===============================================================================
(Wrap compilation errors that occur during reflective access in a MirroredCompilationError,
rather than suspending the isolate.)


use_osr: true (Use on-stack replacement.)
===============================================================================
[Optimize]
On-Stack-Replacementを有効にします。
その結果、ループ実行途中から最適化したコードにjumpできるようになります。


use_slow_path: false (Set to true for debugging & verifying the slow paths.)
===============================================================================
[VMDebug]
起動時に生成したStubコードにおいて、ハンドアセンブルして最適化したコードの使用をスキップします。
主にハンドアセンブルしたコードのデバッグに使います。

use_sse41: true (Use SSE 4.1 if available)
===============================================================================
[Runtime]
sse4.1を有効にします。

verbose_debug: false (Verbose debugger messages)
===============================================================================
[Print]

verbose_gc: false (Enables verbose GC.)
===============================================================================
[GC]
GCの詳細を出力します。

verbose_gc_hdr: 40 (Print verbose GC header interval.)
===============================================================================
[GC]
GCの詳細を出力する際に、40行ずつにgc_hdrを出力します。
なんとなくGCの出力カラムと合わせて見やすくなります。

verbose_stacktrace: false (Stack traces will include methods marked invisible.)
===============================================================================
[Print]

verify_after_gc: false (Enables heap verification after GC.)
===============================================================================
[Verify]

verify_before_gc: false (Enables heap verification before GC.)
===============================================================================
[Verify]

verify_compiler: false (Enable compiler verification assertions)
===============================================================================
[Verify]
コンパイルの途中等で、IRがおかしくなっていないかチェックします。
具体的には、SSA形式のUseListが正しく設定されているかverifyします。

verify_handles: false (Verify handles.)
===============================================================================
[Verify]

verify_on_transition: false (Verify on dart <==> VM.)
===============================================================================
[Verify]

warn_mixin_typedef: true (Warning on legacy mixin typedef)
===============================================================================

warning_as_error: false (Treat warnings as errors.)
===============================================================================

worker_timeout_millis: 5000 (Free workers when they have been idle for this amount of time.)
===============================================================================

