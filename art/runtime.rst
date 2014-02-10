Runtime
###############################################################################

runtimeの仕事ってなんだろう。。


*******************************************************************************

===============================================================================

===============================================================================


llvmのintrinsics一覧
*******************************************************************************

declare %JavaObject* @art_portable_get_current_thread_from_code()
declare %JavaObject* @art_portable_set_current_thread_from_code(%JavaObject*)

declare void @art_portable_lock_object_from_code(%JavaObject*, %JavaObject*)
declare void @art_portable_unlock_object_from_code(%JavaObject*, %JavaObject*)

declare void @art_portable_test_suspend_from_code(%JavaObject*)

declare %ShadowFrame* @art_portable_push_shadow_frame_from_code(%JavaObject*, %ShadowFrame*, %JavaObject*,
declare void @art_portable_pop_shadow_frame_from_code(%ShadowFrame*)



declare %JavaObject* @art_portable_get_and_clear_exception(%JavaObject*)
declare void @art_portable_throw_div_zero_from_code()
declare void @art_portable_throw_array_bounds_from_code(i32, i32)
declare void @art_portable_throw_no_such_method_from_code(i32)
declare void @art_portable_throw_null_pointer_exception_from_code(i32)
declare void @art_portable_throw_stack_overflow_from_code()
declare void @art_portable_throw_exception_from_code(%JavaObject*)

declare i32 @art_portable_find_catch_block_from_code(%JavaObject*, i32)



declare %JavaObject* @art_portable_alloc_object_from_code(i32, %JavaObject*, %JavaObject*)
declare %JavaObject* @art_portable_alloc_object_from_code_with_access_check(i32, %JavaObject*, %JavaObject

declare %JavaObject* @art_portable_alloc_array_from_code(i32, %JavaObject*, i32, %JavaObject*)
declare %JavaObject* @art_portable_alloc_array_from_code_with_access_check(i32, %JavaObject*, i32, %JavaOb
declare %JavaObject* @art_portable_check_and_alloc_array_from_code(i32, %JavaObject*, i32, %JavaObject*)
declare %JavaObject* @art_portable_check_and_alloc_array_from_code_with_access_check(i32, %JavaObject*, i3

declare void @art_portable_find_instance_field_from_code(i32, %JavaObject*)
declare void @art_portable_find_static_field_from_code(i32, %JavaObject*)

declare %JavaObject* @art_portable_find_static_method_from_code_with_access_check(i32, %JavaObject*, %Java
declare %JavaObject* @art_portable_find_direct_method_from_code_with_access_check(i32, %JavaObject*, %Java
declare %JavaObject* @art_portable_find_virtual_method_from_code_with_access_check(i32, %JavaObject*, %Jav
declare %JavaObject* @art_portable_find_super_method_from_code_with_access_check(i32, %JavaObject*, %JavaO
declare %JavaObject* @art_portable_find_interface_method_from_code_with_access_check(i32, %JavaObject*, %J
declare %JavaObject* @art_portable_find_interface_method_from_code(i32, %JavaObject*, %JavaObject*, %JavaO

declare %JavaObject* @art_portable_initialize_static_storage_from_code(i32, %JavaObject*, %JavaObject*)
declare %JavaObject* @art_portable_initialize_type_from_code(i32, %JavaObject*, %JavaObject*)
declare %JavaObject* @art_portable_initialize_type_and_verify_access_from_code(i32, %JavaObject*, %JavaObj

declare %JavaObject* @art_portable_resolve_string_from_code(%JavaObject*, i32)

declare i32 @art_portable_set32_static_from_code(i32, %JavaObject*, i32)
declare i32 @art_portable_set64_static_from_code(i32, %JavaObject*, i64)
declare i32 @art_portable_set_obj_static_from_code(i32, %JavaObject*, %JavaObject*)

declare i32 @art_portable_get32_static_from_code(i32, %JavaObject*)
declare i64 @art_portable_get64_static_from_code(i32, %JavaObject*)
declare %JavaObject* @art_portable_get_obj_static_from_code(i32, %JavaObject*)

declare i32 @art_portable_set32_instance_from_code(i32, %JavaObject*, %JavaObject*, i32)
declare i32 @art_portable_set64_instance_from_code(i32, %JavaObject*, %JavaObject*, i64)
declare i32 @art_portable_set_obj_instance_from_code(i32, %JavaObject*, %JavaObject*, %JavaObject*)

declare i32 @art_portable_get32_instance_from_code(i32, %JavaObject*, %JavaObject*)
declare i64 @art_portable_get64_instance_from_code(i32, %JavaObject*, %JavaObject*)
declare %JavaObject* @art_portable_get_obj_instance_from_code(i32, %JavaObject*, %JavaObject*)

declare %JavaObject* @art_portable_decode_jobject_in_thread(%JavaObject*, %JavaObject*)

declare void @art_portable_fill_array_data_from_code(%JavaObject*, i32, %JavaObject*, i32)


declare i32 @art_portable_is_assignable_from_code(%JavaObject*, %JavaObject*)
declare void @art_portable_check_cast_from_code(%JavaObject*, %JavaObject*)
declare void @art_portable_check_put_array_element_from_code(%JavaObject*, %JavaObject*)


declare i32 @art_portable_jni_method_start(%JavaObject*)
declare i32 @art_portable_jni_method_start_synchronized(%JavaObject*, %JavaObject*)

declare void @art_portable_jni_method_end(i32, %JavaObject*)
declare void @art_portable_jni_method_end_synchronized(i32, %JavaObject*, %JavaObject*)
declare %JavaObject* @art_portable_jni_method_end_with_reference(%JavaObject*, i32, %JavaObject*)
declare %JavaObject* @art_portable_jni_method_end_with_reference_synchronized(%JavaObject*, i32, %JavaObje


declare i1 @art_portable_is_exception_pending_from_code()
declare void @art_portable_mark_gc_card_from_code(%JavaObject*, %JavaObject*)
declare void @art_portable_proxy_invoke_handler_from_code(%JavaObject*, ...)



Runtime symbol
===============================================================================

GetRuntimeSupportFunction の引数の関数ポインタ

runtime_support::GetCurrentThread
runtime_support::SetCurrentThread
runtime_support::PushShadowFrame
runtime_support::GetAndClearException
runtime_support::TestSuspend
runtime_support::LockObject
runtime_support::UnlockObject
runtime_support::RuntimeId

基本的には、runtime_support_llvm_func_list.h
で定義されているシンボルが、runtime側で実態が定義されている。

runtime/entrypoints
===============================================================================

mirror::Object*


jni_internal

もしくはthread.cc



===============================================================================
===============================================================================
