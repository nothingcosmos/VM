PrintCompilation
####

option
-XX:+PrintCompilation

オプションに応じて変数が有効になる。
PrintCompilation

CompileTask::print_compilation

実装
====

hotspot/src/share/vm/print_compilation_impl() ::

  //print timestamp
  //print compilation number

  //% is_osr_method
  //s is_synchronized
  //! has_exception_handler
  //b is_blocking
  //n is_native

  //comp_level comp_level

  //@ nn  //osr_bci

  //(xx bytes) // methodのcode_size()

  //msg


  comp_level  non < comp_level < CompLevel_full_optimization

  is_c2_compile  CompLevel_full_optimization


  enum CompLevel {
    CompLevel_any               = -1,
    CompLevel_all               = -1,
    CompLevel_none              = 0,         // Interpreter
    CompLevel_simple            = 1,         // C1
    CompLevel_limited_profile   = 2,         // C1, invocation & backedge counters
    CompLevel_full_profile      = 3,         // C1, invocation & backedge counters + mdo
    CompLevel_full_optimization = 4,         // C2 or Shark

  mdo <= methoddata

    branches
    calls
    checkcasts
    parameters
    arguments
    return

  C1UpdateMethodData

  c1_LIRGenerator

  profile_branch
  profile_type
  profile_parameters
  profile_arguments
  profile_parameters_at_call

  GraphBuilderのほうでも埋め込む。
  profile_call
  profile_return_type
  profile_invocation

  profile_checkcasts
  profile_branches


====
====
====
