vm/class_finalizerは、いつ呼ばれるのか。
class loadingの直後？

Class finalization occurs:
// a) when bootstrap process completes (VerifyBootstrapClasses).
// b) after the user classes are loaded (dart_api).

// compiled


after compile, before install
