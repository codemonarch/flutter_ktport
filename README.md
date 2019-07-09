# KTFlutter

A flutter library for lazier programmers.

## Getting Started

Add dependence of ```KTFlutter``` to your project. The last version is ```1.0.2``` .

```
dependencies:
    ... ...
    ktflutter: 1.0.2
```

## Functions

Functions in the library are ported from kotlin, also included some useful utils like http.

Here is a list for cognition:

| Class | Method | Definition | Note |
| :-- | :-- | :-- | :-- |
| _GLOBAL | krun | T krun&lt;T&gt;(T block()) | |
| | krepeat | krepeat(int times, void action(int)) | |
| | kalso | T kalso&lt;T&gt;(T t, void block(T obj)) | |
| | klet | R klet&lt;T, R&gt;(T t, R block(T obj)) | |
| | platform | platform(void block(String s)) | call from native |
| | appVersionCode | appVersionCode(void block(String s)) | call from native |
| | appVersionName | appVersionName(void block(String s)) | call from native |
| | deviceVersion | deviceVersion(void block(String s)) | call from native |
| | deviceModel | deviceModel(void block(String s)) | call from native |
| | deviceId | deviceId(void block(String s)) | call from native |
| | appBundle | appBundle(void block(String s)) | call from native, iOS only |
| | appPackage | appPackage(void block(String s)) | call from native, Android only |
| | deviceDocumentPath | deviceDocumentPath(void block(String path)) | call from native |
| | deviceFilePath | deviceFilePath(void block(String path)) | call from native |
| | deviceCachePath | deviceCachePath(void block(String path)) | call from native |
| | deviceExternalPath | deviceExternalPath(void block(String path)) | call from native, Android only |
| | deviceExternalDocumentPath | deviceExternalDocumentPath(void block(String path)) | call from native, Android only |
| | deviceExternalFilePath | deviceExternalFilePath(void block(String path)) | call from native, Android only |
| | deviceExternalCachePath | deviceExternalCachePath(void block(String path)) | call from native, Android only |
| | deviceObbPath | deviceObbPath(void block(String path)) | call from native, Android only |
| _ROUTE | route | route&lt;T&gt;(String name, dynamic arguments, void block(T obj)) | |
| | routeList | routeList&lt;T&gt;(String name, dynamic arguments, void block(List&lt;T&gt; list)) | |
| | routeMap | routeMap&lt;K, V&gt;(String name, dynamic arguments, void block(Map&lt;K, V&gt; map)) | |
| | routeObj | routeObj&lt;T&gt;(String name, dynamic arguments, T parse(dynamic p), void block(T obj)) | |
| | routeObjList | routeObjList&lt;T&gt;(String name, dynamic arguments, T parse(dynamic p), void block(List&lt;T&gt; list)) | |
| | routeObjMap | routeObjMap&lt;K, V&gt;(String name, dynamic arguments, V parse(dynamic p), void block(Map&lt;K, V&gt; map)) | |
| HttpMethod | | GET, HEAD, POST, PUT, DELETE | |
| HttpResponse | | | |
| HttpError | | | |
| _HTTP | http | Future&lt;HttpResponse&gt; http(String url, HttpMethod method, {Map&lt;String, String&gt; param,String mimeType='application/json', String body, Map&lt;String, String&gt; postParam, Map&lt;String, String&gt; fileParam, Map&lt;String, String&gt; headers, int timeout=15}) | |
| | httpGet | Future&lt;HttpResponse&gt; httpGet(String url, {Map&lt;String, String&gt; param, Map&lt;String, String&gt; headers}) | |
| | httpPost | Future&lt;HttpResponse&gt; httpPost(String url, {Map&lt;String, String&gt; param, String body, Map&lt;String, String&gt; headers}) | |
| DownloadState | | Start, Progress, Complete, Error | |
| DownloadCallback | | void Function(DownloadState state, int position, int filesize, String error) | |
| _ DOWNLOAD| download | Future&lt;bool&gt; download(String url, String localFile, DownloadCallback callback) | |
| _TOAST | toast | toast(BuildContext context, String message, [int duration = 2]) | |
| KFPair | toList | KFList&lt;T&gt; toList() | |
| KFString | stringOf | KFString stringOf(String str) | |
| | also | KFString also(void block(KFString s)) | |
| | let | R let&lt;R&gt;(R block(KFString s)) | |
| | takeIf | KFString takeIf(bool block(KFString s)) | |
| | takeUnless | KFString takeUnless(bool block(KFString s)) | |
| | substringBefore | KFString substringBefore(Pattern pattern) | |
| | substringAfter | KFString substringAfter(Pattern pattern) | |
| | substringBeforeLast | KFString substringBeforeLast(Pattern pattern) | |
| | substringAfterLast | KFString substringAfterLast(Pattern pattern) | |
| | removeRange | KFString removeRange(int startIdx, int endIdx) | |
| | removePrefix | KFString removePrefix(Pattern pattern) | |
| | removeSuffix | KFString removeSuffix(Pattern pattern) | |
| | removeSurrounding | KFString removeSurrounding(Pattern pattern) | |
| | replaceBefore | KFString replaceBefore(Pattern pattern, Object replacement) | Object can be String/KFString |
| | replaceAfter | KFString replaceAfter(Pattern pattern, Object replacement) | Object can be String/KFString |
| | replaceAfterLast | KFString replaceAfterLast(Pattern pattern, Object replacement) | Object can be String/KFString |
| | replaceBeforeLast | KFString replaceBeforeLast(Pattern pattern, Object replacement) | Object can be String/KFString |
| | lines | KFList&lt;KFString&gt; lines() | |
| | drop | KFString drop(int n) | |
| | dropLast | KFString dropLast(int n) | |
| | filter | KFString filter(bool block(KFString str)) | |
| | filterIndexed | KFString filterIndexed(bool block(int idx, KFString str)) | |
| | filterNot | KFString filterNot(bool block(KFString str)) | |
| | reversed | KFString reversed() | |
| | toList | KFList&lt;KFString&gt; toList() | |
| | map | KFList&lt;T&gt; map&lt;T&gt;(T block(KFString s)) | |
| | mapIndexed | KFList&lt;T&gt; mapIndexed&lt;T&gt;(T block(int idx, KFString s)) | |
| | forEach | forEach(void action(KFString s)) | |
| | forEachIndexed | forEachIndexed(void action(int idx, KFString s)) | |
| | reduce | KFString reduce(KFString oper(KFString acc, KFString s)) | |
| | reduceIndexed | KFString reduceIndexed(KFString oper(int idx, KFString acc, KFString s)) | |
| | toInt | int toInt() | |
| | toDouble | double toDouble() | |
| | toBool | bool toBool() | |
| | base64encode | KFString base64encode() | |
| | base64decode | KFString base64decode() | |
| | toIntList | KFList&lt;int&gt; toIntList() | |
| | lastPathPart | KFString lastPathPart() | |
| | getPathDirectory | KFString getPathDirectory() | |
| | toJsonEncoded | KFString toJsonEncoded() | |
| | toTitleUpperCase | KFString toTitleUpperCase() | |
| | appendPathPart | KFString appendPathPart(Object part) | Object can be String/KFString |
| | extension | KFString extension() | |
| | replaceTag | KFString replaceTag(String tag, KFString block()) | |
| | skipEmptyLine | KFString skipEmptyLine() | |
| | toPair | KFPair&lt;KFString, KFString&gt; toPair() | |
| | save | save(File f) | |
| | asFileWriteText | File asFileWriteText(Object s) | Object can be String/KFString |
| | asFileReadText | KFString asFileReadText() | |
| | asFileMkdirs | asFileMkdirs() | |
| | asFile | File asFile() | |
| KFList&lt;E&gt; | listOf | KFList&lt;E&gt; listOf&lt;E&gt;(Iterable&lt;E&gt; list) | |
| | toFlutterList | List&lt;E&lt; toFlutterList() | |
| | also | KFList&lt;E&gt; also(void block(KFList&lt;E&gt; list)) | |
| | let | R let&lt;R&gt;(R block(KFList&lt;E&gt; list)) | |
| | takeIf | KFList&lt;E&gt; takeIf(bool block(KFList&lt;E&gt; list)) | |
| | takeUnless | KFList&lt;E&gt; takeUnless(bool block(KFList&lt;E&gt; list)) | |
| | find | E find(bool block(E obj)) | |
| | findLast | E findLast(bool block(E obj)) | |
| | indexOfFirst | int indexOfFirst(bool block(E obj)) | |
| | indexOfLast | int indexOfLast(bool block(E obj)) | |
| | drop | KFList&lt;E&gt; drop(int n) | |
| | dropLast | KFList&lt;E&gt; dropLast(int n) | |
| | filter | KFList&lt;E&gt; filter(bool block(E obj)) | |
| | filterIndexed | KFList&lt;E&gt; filterIndexed(bool block(int idx, E obj)) | |
| | filterNot | KFList&lt;E&gt; filterNot(bool block(E obj)) | |
| | slice | KFList&lt;E&gt; slice(int startIdx, int endIdx) | |
| | sortBy | KFList&lt;E&gt; sortBy(int block(E first, E second)) | |
| | sortByDescending | KFList&lt;E&gt; sortByDescending(int block(E first, E second)) | |
| | map | KFList&lt;T&gt; map&lt;T&gt;(T block(E obj)) | overrided |
| | mapIndexed | KFList&lt;T&gt; mapIndexed&lt;T&gt;(T block(int idx, E obj)) | |
| | distinct | KFList&lt;E&gt; distinct() | |
| | distinctBy | KFList&lt;E&gt; distinctBy&lt;K&gt;(K block(E obj)) | |
| | all | bool all(bool block(E obj)) | |
| | any | bool any(bool block(E obj)) | |
| | count | int count(bool block(E obj)) | |
| | forEachIndexed | forEachIndexed(void action(int index, E element)) | |
| | none | bool none(bool block(E obj)) | |
| | reduceIndexed | E reduceIndexed(E oper(int idx, E acc, E s)) | |
| | minus | minus(Object obj) | Object can be List/KFList |
| | joinToString | KFString joinToString([String sep = ","]) | |
| | toStringList | KFList&lt;String&gt; toStringList() | |
| | toMap | KFMap&lt;K, V&gt; toMap&lt;K, V&gt;() | |
| | mapTo | C mapTo&lt;R, C extends List&lt;R&gt;&gt;(C dest, R block(E obj)) | |
| | mapIndexedTo | C mapIndexedTo&lt;R, C extends List&lt;R&gt;&gt;(C dest, R block(int idx, E obj)) | |
| | filterTo | C filterTo&lt;C extends List&lt;E&gt;&gt;(C dest, bool block(E obj)) | |
| | filterIndexedTo | C filterIndexedTo&lt;C extends List&lt;E&gt;&gt;(C dest, bool block(int idx, E obj)) | |
| | filterNotTo | C filterNotTo&lt;C extends List&lt;E&gt;&gt;(C dest, bool block(E obj)) | |
| KFSet&lt;E&gt; | setOf | KFSet&lt;E&gt; setOf&lt;E&gt;(Iterable&lt;E&gt; set) | |
| | also | KFSet&lt;E&gt; also(void block(KFSet&lt;E&gt; list)) | |
| | let | R let&lt;R&gt;(R block(KFSet&lt;E&gt; list)) | |
| | takeIf | KFSet&lt;E&gt; takeIf(bool block(KFSet&lt;E&gt; list)) | |
| | takeUnless | KFSet&lt;E&gt; takeUnless(bool block(KFSet&lt;E&gt; list)) | |
| | find | E find(bool block(E obj)) | |
| | findLast | E findLast(bool block(E obj)) | |
| | indexOfFirst | int indexOfFirst(bool block(E obj)) | |
| | indexOfLast | int indexOfLast(bool block(E obj)) | |
| | drop | KFSet&lt;E&gt; drop(int n) | |
| | dropLast | KFSet&lt;E&gt; dropLast(int n) | |
| | filter | KFSet&lt;E&gt; filter(bool block(E obj)) | |
| | filterIndexed | KFSet&lt;E&gt; filterIndexed(bool block(int idx, E obj)) | |
| | filterNot | KFSet&lt;E&gt; filterNot(bool block(E obj)) | |
| | slice | KFSet&lt;E&gt; slice(int startIdx, int endIdx) | |
| | sortBy | KFSet&lt;E&gt; sortBy(int block(E first, E second)) | |
| | sortByDescending | KFSet&lt;E&gt; sortByDescending(int block(E first, E second)) | |
| | map | KFSet&lt;T&gt; map&lt;T&gt;(T block(E obj)) | overrided |
| | mapIndexed | KFSet&lt;T&gt; mapIndexed&lt;T&gt;(T block(int idx, E obj)) | |
| | distinct | KFSet&lt;E&gt; distinct() | |
| | distinctBy | KFSet&lt;E&gt; distinctBy&lt;K&gt;(K block(E obj)) | |
| | all | bool all(bool block(E obj)) | |
| | any | bool any(bool block(E obj)) | |
| | count | int count(bool block(E obj)) | |
| | forEachIndexed | forEachIndexed(void action(int index, E element)) | |
| | none | bool none(bool block(E obj)) | |
| | reduceIndexed | E reduceIndexed(E oper(int idx, E acc, E s)) | |
| | minus | minus(Object obj) | |
| | joinToString | KFString joinToString([String sep = ","]) | |
| | toStringList | KFSet&lt;String&gt; toStringList() | |
| | toMap | KFMap&lt;K, V&gt; toMap&lt;K, V&gt;() | |
| | mapTo | C mapTo&lt;R, C extends Set&lt;R&gt;&gt;(C dest, R block(E obj)) | |
| | mapIndexedTo | C mapIndexedTo&lt;R, C extends Set&lt;R&gt;&gt;(C dest, R block(int idx, E obj)) | |
| | filterTo | C filterTo&lt;C extends Set&lt;E&gt;&gt;(C dest, bool block(E obj)) | |
| | filterIndexedTo | C filterIndexedTo&lt;C extends Set&lt;E&gt;&gt;(C dest, bool block(int idx, E obj)) | |
| | filterNotTo | C filterNotTo&lt;C extends Set&lt;E&gt;&gt;(C dest, bool block(E obj)) | |
| KFMap&lt;K, V&gt; | mapOf | KFMap&lt;K, V&gt; mapOf&lt;K, V6gt;(Map&lt;K, V&gt; map) | |
| | also | KFMap&lt;K, V&gt; also(void block(KFMap&lt;K, V&gt; map)) | |
| | let | R let&lt;R&gt;(R block(KFMap&lt;K, V&gt; list)) | |
| | takeIf | KFMap&lt;K, V&gt; takeIf(bool block(KFMap&lt;K, V&gt; list)) | |
| | takeUnless | KFMap&lt;K, V&gt; takeUnless(bool block(KFMap&lt;K, V&gt; list)) | |
| | toList | KFList&lt;KFPair&lt;K, V&gt;&gt; toList() | |
| | mapToList | KFList&lt;R&gt; mapToList&lt;R&gt;(R block(MapEntry&lt;K, V&gt; e))| |
| | forEachEntry | forEachEntry(void block(MapEntry&lt;K, V&gt; e)) | |
| | all | bool all(bool block(MapEntry&lt;K, V&gt; e)) | |
| | any | bool any(bool block(MapEntry&lt;K, V&gt; e)) | |
| | count | int count(bool block(MapEntry&lt;K, V&gt; e)) | |
| | none | bool none(bool block(MapEntry&lt;K, V&gt; e)) | |
| | filterKeys | KFMap&lt;K, V&gt; filterKeys(bool block(K k)) | |
| | filterValues | KFMap&lt;K, V&gt; filterValues(bool block(V v)) | |
| | filter | KFMap&lt;K, V&gt; filter(bool block(MapEntry&lt;K, V&gt; e)) | |
| | filterNot | KFMap&lt;K, V&gt; filterNot(bool block(MapEntry&lt;K, V&gt; e)) | |
| | add | add(Object obj) | Object can be Map/KFMap |
| | minus | minus(Object obj) | Object can be Map/KFMap |
| | filterTo | KFMap&lt;K, V&gt; filterTo&lt;M extends Map&lt;K, V&gt;&gt;(M dest, bool block(MapEntry&lt;K, V&gt; e)) | |
| | filterNotTo | KFMap&lt;K, V&gt; filterNotTo&lt;M extends Map&lt;K, V&gt;&gt;(M dest, bool block(MapEntry&lt;K, V&gt; e)) | |
| | filterKeysTo | KFMap&lt;K, V&gt; filterKeysTo&lt;M extends Map&lt;K, V&gt;&gt;(M dest, bool block(K k)) | |
| | filterValuesTo | KFMap&lt;K, V&gt; filterValuesTo&lt;M extends Map&lt;K, V&gt;&gt;(M dest, bool block(V v)) | |
| | mapTo | KFMap&lt;K2, V2&gt; mapTo&lt;K2, V2, C extends Map&lt;K2, V2&gt;&gt;(C dest, MapEntry&lt;K2, V2&gt; block(MapEntry&lt;K, V&gt; e)) | |
| | mapToListTo | KFList&lt;R&gt; mapToListTo&lt;R, C extends List&lt;R&gt;&gt;(C dest, R block(MapEntry&lt;K, V&gt; e)) | |
| | mapKeysTo | KFMap&lt;K2, V2&gt; mapKeysTo&lt;K2, V2, C extends Map&lt;K2, V2&gt;&gt;(C dest, MapEntry&lt;K2, V2&gt; block(K k)) | |
| | mapKeysToListTo | KFList&lt;R&gt; mapKeysToListTo&lt;R, C extends List&lt;R&gt;&gt;(C dest, R block(K k)) | |
| | mapValuesTo | KFMap&lt;K2, V2&gt; mapValuesTo&lt;K2, V2, C extends Map&lt;K2, V2&gt;&gt;(C dest, MapEntry&lt;K2, V2&gt; block(V v)) | |
| | mapValuesToListTo | KFList&lt;R&gt; mapValuesToListTo&lt;R, C extends List&lt;R&gt;&gt;(C dest, R block(V v)) | |
| _REGEXP | regexMatch | bool regexMatch(String str, String regex) | |
| | isStringReg | bool isStringReg(String str, int type) | |
| | isNumberReg | bool isNumberReg(String str, int type) | |
| | isEmail | bool isEmail(String str) | |
| | isPhoneNumber | bool isPhoneNumber(String str) | |
| | isCellPhoneNumber | bool isCellPhoneNumber(String str) | |
| | isChinesePhoneNumber | bool isChinesePhoneNumber(String str) | |
| | isIdCardNumber | bool isIdCardNumber(String str) | |
| | isShortIdCardNumber | bool isShortIdCardNumber(String str) | |
| | isUrl | bool isUrl(String str) | |
| | isDomain | bool isDomain(String str) | |
| | isValidAccount | bool isValidAccount(String str) | |
| | isValidPassword | bool isValidPassword(String str) | |
| | isStrongPassword | bool isStrongPassword(String str) | |
| | isDate | bool isDate(String str) | |
| | isValidXml | bool isValidXml(String str) | |
| | isBlankLine | bool isBlankLine(String str) | |
| | isValidHtml | bool isValidHtml(String str) | |
| | isValidQQNumber | bool isValidQQNumber(String str) | |
| | isValidPostCode | bool isValidPostCode(String str) | |
| | isValidIPAddress | bool isValidIPAddress(String str) | |
| KMixin&lt;T&gt; | also | T also(void block(T obj)) | |
| | let | R let&lt;R&gt;(R block(T obj)) | |
| | takeIf | T takeIf(bool block(T obj)) | |
| | takeUnless | T takeUnless(bool block(T obj)) | |
| | | | |

## example

You may visit ```example``` project for more about ```KTFlutter```