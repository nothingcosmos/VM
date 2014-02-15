内部ではlatin-1とutf-16で管理しているのかな。
2bytestringってのがいる。


Improving string performance is a critical goal for the VM team this quarter, as it looks like that's perhaps the biggest advantage V8 has over Dart in the Dromaeo benchmarks.  You can't have fast DOM performance with slow string support.

We're moving to both 1-byte and 2-byte raw string encodings that match WebKit's, because right now any string shared between Dart and WebKit needs to be converted each way.  Strings that don't require UTF-16 will use UTF-8, plus the Dartium engineers have requested support for known ASCII strings to avoid encoder overhead.


r14989 | asiva@google.com | 2012-11-16 09:13:18 +0900 (金, 16 11月 2012) | 3 lines
Revert OneByteString back to ISO Latin-1 instead of ASCII
as webkit supports ISO Latin-1 and UTF-16 encodings for strings.
Review URL: https://codereview.chromium.org//11365243


r14887 | sgjesse@google.com | 2012-11-14 22:01:57 +0900 (水, 14 11月 2012) | 15 lines
Add support for non ASCII strings when communicating with native ports.
The string representation in a Dart_CObject strructure is now UTF8.
All strings read are now converted to UTF8 from either ASCII or UTF16 serialization.
All strings posted should be valid UTF8 and are
serialized as either ASCII or UTF16 depending on the content.
Proper andling of surrogate pairs is missing, but will be added when
https://codereview.chromium.org/11368138/ lands.
R=ager@google.com, erikcorry@google.com, asiva@google.com
Review URL: https://codereview.chromium.org//11410032


r14357
Issue 11275008: - Represent strings internally in UTF-16 format, this makes it (Closed)

Description
- Represent strings internally in UTF-16 format, this makes it 
  compatible with webkit and will allow for easy externalization of strings 
  (The language specification was changed recently to reflect this as 
  follows "A string is a sequence of UTF-16 code units"). 
- Remove four byte string class and all references to it. 
- Rename some of the string functions in Dart API to make them consistent 
  and better describe the underlying functionality 
  Dart_NewString => Dart_NewStringFromCString 
  Dart_NewString8 => Dart_NewStringFromUTF8 
  Dart_NewString16 => Dart_NewStringFromUTF16 
  Dart_NewString32 => Dart_NewStringFromUTF32 
  Dart_NewExternalString8 => Dart_NewExternalUTF8String 
  Dart_NewExternalString16 => Dart_NewExternalUTF16String 
  Dart_NewExternalString32 => Dart_NewExternalUTF32String 
  Dart_StringGet8 => Dart_StringToUTF8 
  Dart_StringGet16 => Dart_StringToUTF16 
  Dart_StringToCString => Dart_StringToCString 
  Dart_IsString8 => Removed 
  Dart_IsString16 -> Removed 
  Dart_StringToBytes -> Removed 
  Dart_StringGet32 -> Removed
