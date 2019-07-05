// run
import 'package:ktflutter/route_extension.dart';

T krun<T>(T block()) => block();

// repeat
krepeat(int times, void action(int)) {
    for (int i = 0; i < times; i++) {
        action(i);
    }
}

T kalso<T>(T t, void block(T obj)) {
    block(t);
    return t;
}

R klet<T, R>(T t, R block(T obj)) => block(t);

abstract class KMixin<T> {
    T also(void block(T obj)) {
        block(this as T);
        return this as T;
    }
    R let<R>(R block(T obj)) => block(this as T);
    T takeIf(bool block(T obj)) => block(this as T) ? this as T : null;
    T takeUnless(bool block(T obj)) => !block(this as T) ? this as T : null;
}

platform(void block(String s)) async => block(await posix.invokeMethod<String>("platform", {}));
appVersionCode(void block(String s)) async => block(await posix.invokeMethod<String>("app_version_code", {}));
appVersionName(void block(String s)) async => block(await posix.invokeMethod<String>("app_version_name", {}));
deviceVersion(void block(String s)) async => block(await posix.invokeMethod<String>("device_version", {}));
deviceModel(void block(String s)) async => block(await posix.invokeMethod<String>("device_model", {}));
deviceId(void block(String s)) async => block(await posix.invokeMethod<String>("device_id", {}));
// ios only
appBundle(void block(String s)) {
    platform((p) async {
        block(p == "iOS" ? (await posix.invokeMethod<String>("app_bundle", {})) : "");
    });
}
// android only
appPackage(void block(String s)) {
    platform((p) async {
        block(p == "Android" ? (await posix.invokeMethod<String>("app_package", {})) : "");
    });
}