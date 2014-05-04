unsafe api
####

unsafe系はhotspot/src/share/vm/classfile/vmSymbol.hppで全部intrinsicsになってますね。。

do_intrinsic(_getObject,                sun_misc_Unsafe,        getObject_name, getObject_signature,    
do_intrinsic(_getBoolean,               sun_misc_Unsafe,        getBoolean_name, getBoolean_signature,  
do_intrinsic(_getByte,                  sun_misc_Unsafe,        getByte_name, getByte_signature,        
do_intrinsic(_getShort,                 sun_misc_Unsafe,        getShort_name, getShort_signature,      
do_intrinsic(_getChar,                  sun_misc_Unsafe,        getChar_name, getChar_signature,        
do_intrinsic(_getInt,                   sun_misc_Unsafe,        getInt_name, getInt_signature,          
do_intrinsic(_getLong,                  sun_misc_Unsafe,        getLong_name, getLong_signature,        
do_intrinsic(_getFloat,                 sun_misc_Unsafe,        getFloat_name, getFloat_signature,      
do_intrinsic(_getDouble,                sun_misc_Unsafe,        getDouble_name, getDouble_signature,    
do_intrinsic(_putObject,                sun_misc_Unsafe,        putObject_name, putObject_signature,    
do_intrinsic(_putBoolean,               sun_misc_Unsafe,        putBoolean_name, putBoolean_signature,  
do_intrinsic(_putByte,                  sun_misc_Unsafe,        putByte_name, putByte_signature,        
do_intrinsic(_putShort,                 sun_misc_Unsafe,        putShort_name, putShort_signature,      
do_intrinsic(_putChar,                  sun_misc_Unsafe,        putChar_name, putChar_signature,        
do_intrinsic(_putInt,                   sun_misc_Unsafe,        putInt_name, putInt_signature,          
do_intrinsic(_putLong,                  sun_misc_Unsafe,        putLong_name, putLong_signature,        
do_intrinsic(_putFloat,                 sun_misc_Unsafe,        putFloat_name, putFloat_signature,      
do_intrinsic(_putDouble,                sun_misc_Unsafe,        putDouble_name, putDouble_signature, 


/home/elise/language/java/openjdk/jdk8/hotspot/src/share/vm/opto/library_call.cpp

case vmIntrinsics::_getObject:                return inline_unsafe_access(!is_native_ptr, !is_store, T_OBJECT,  !is_volatile);
case vmIntrinsics::_getBoolean:               return inline_unsafe_access(!is_native_ptr, !is_store, T_BOOLEAN, !is_volatile);
case vmIntrinsics::_getByte:                  return inline_unsafe_access(!is_native_ptr, !is_store, T_BYTE,    !is_volatile);
case vmIntrinsics::_getShort:                 return inline_unsafe_access(!is_native_ptr, !is_store, T_SHORT,   !is_volatile);
case vmIntrinsics::_getChar:                  return inline_unsafe_access(!is_native_ptr, !is_store, T_CHAR,    !is_volatile);
case vmIntrinsics::_getInt:                   return inline_unsafe_access(!is_native_ptr, !is_store, T_INT,     !is_volatile);
case vmIntrinsics::_getLong:                  return inline_unsafe_access(!is_native_ptr, !is_store, T_LONG,    !is_volatile);
case vmIntrinsics::_getFloat:                 return inline_unsafe_access(!is_native_ptr, !is_store, T_FLOAT,   !is_volatile);
case vmIntrinsics::_getDouble:                return inline_unsafe_access(!is_native_ptr, !is_store, T_DOUBLE,  !is_volatile);

case vmIntrinsics::_putByte_raw:              return inline_unsafe_access( is_native_ptr,  is_store, T_BYTE,    !is_volatile);
case vmIntrinsics::_putShort_raw:             return inline_unsafe_access( is_native_ptr,  is_store, T_SHORT,   !is_volatile);
case vmIntrinsics::_putChar_raw:              return inline_unsafe_access( is_native_ptr,  is_store, T_CHAR,    !is_volatile);
case vmIntrinsics::_putInt_raw:               return inline_unsafe_access( is_native_ptr,  is_store, T_INT,     !is_volatile);
case vmIntrinsics::_putLong_raw:              return inline_unsafe_access( is_native_ptr,  is_store, T_LONG,    !is_volatile);
case vmIntrinsics::_putFloat_raw:             return inline_unsafe_access( is_native_ptr,  is_store, T_FLOAT,   !is_volatile);
case vmIntrinsics::_putDouble_raw:            return inline_unsafe_access( is_native_ptr,  is_store, T_DOUBLE,  !is_volatile);
case vmIntrinsics::_putAddress_raw:           return inline_unsafe_access( is_native_ptr,  is_store, T_ADDRESS, !is_volatile);
case vmIntrinsics::_getObjectVolatile:        return inline_unsafe_access(!is_native_ptr, !is_store, T_OBJECT,   is_volatile);
case vmIntrinsics::_getBooleanVolatile:       return inline_unsafe_access(!is_native_ptr, !is_store, T_BOOLEAN,  is_volatile);
case vmIntrinsics::_getByteVolatile:          return inline_unsafe_access(!is_native_ptr, !is_store, T_BYTE,     is_volatile);
case vmIntrinsics::_getShortVolatile:         return inline_unsafe_access(!is_native_ptr, !is_store, T_SHORT,    is_volatile);
case vmIntrinsics::_getCharVolatile:          return inline_unsafe_access(!is_native_ptr, !is_store, T_CHAR,     is_volatile);
case vmIntrinsics::_getIntVolatile:           return inline_unsafe_access(!is_native_ptr, !is_store, T_INT,      is_volatile);
case vmIntrinsics::_getLongVolatile:          return inline_unsafe_access(!is_native_ptr, !is_store, T_LONG,     is_volatile);
case vmIntrinsics::_getFloatVolatile:         return inline_unsafe_access(!is_native_ptr, !is_store, T_FLOAT,    is_volatile);
case vmIntrinsics::_getDoubleVolatile:        return inline_unsafe_access(!is_native_ptr, !is_store, T_DOUBLE,   is_volatile);
vmIntrinsics::_putBooleanVolatile:       return inline_unsafe_access(!is_native_ptr,  is_store, T_BOOLEAN,  is_volatile);
case vmIntrinsics::_putByteVolatile:          return inline_unsafe_access(!is_native_ptr,  is_store, T_BYTE,     is_volatile);
case vmIntrinsics::_putShortVolatile:         return inline_unsafe_access(!is_native_ptr,  is_store, T_SHORT,    is_volatile);



is_storeフラグを負荷する
inline_unsafe_access

store

load

need_read_barrier




hotspot/src/share/vm/opto/library_call.cpp
inline_unsafe_access
に置き換わる、load系の場合は、make_loadでload系のNodeに置き換わる。

make_load

dstore_rounding
store_to_memory
