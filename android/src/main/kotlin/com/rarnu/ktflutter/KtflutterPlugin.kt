@file:Suppress("DEPRECATION")

package com.rarnu.ktflutter

import android.content.Context
import android.os.Build
import android.os.Environment
import android.provider.Settings
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import java.io.File

fun nativeRouting(block: KtflutterPlugin.() -> Unit) {
    block(KtflutterPlugin)
}

/*
deviceDocumentPath(void block(String path)) async => block(await posix.invokeMethod<String>("device_document_path", {}));
deviceFilePath(void block(String path)) async => block(await posix.invokeMethod<String>("device_file_path", {}));
deviceCachePath(void block(String path)) async => block(await posix.invokeMethod<String>("device_cache_path", {}));

// android only
deviceExternalPath(void block(String path)) => platform((p) async {
    block(p == "Android" ? (await posix.invokeMethod<String>("device_external_path", {})) : "");
});

 */

object KtflutterPlugin {
    private const val channelName = "com.rarnu.flutter/routing"
    private val channelList = mutableMapOf<String, (Context, Map<String, Any?>) -> Any?>()

    @JvmStatic
    fun registerWith(registrar: PluginRegistry.Registrar) {
        MethodChannel(registrar.messenger(), channelName).setMethodCallHandler { call, result ->
            when(call.method) {
                "platform" -> result.success("Android")
                "app_version_code" -> result.success(with(registrar.context()) { packageManager.getPackageInfo(packageName, 0).versionCode.toString() })
                "app_version_name" -> result.success(with(registrar.context()) { packageManager.getPackageInfo(packageName, 0).versionName })
                "app_package" -> result.success(registrar.context().packageName)
                "device_version" -> result.success(Build.VERSION.SDK_INT.toString())
                "device_model" -> result.success(Build.MODEL)
                "device_id" -> result.success(Settings.Secure.getString(registrar.context().contentResolver, Settings.Secure.ANDROID_ID))
                // paths
                "device_document_path" -> result.success(registrar.context().filesDir.absolutePath.substringBeforeLast("/"))
                "device_file_path"-> result.success(registrar.context().filesDir.absolutePath.also { with(File(it)) { if (!exists()) mkdirs() } })
                "device_cache_path" -> result.success(registrar.context().cacheDir.absolutePath.also { with(File(it)) { if (!exists()) mkdirs() } })
                // android only paths
                "device_external_path" -> result.success(Environment.getExternalStorageDirectory().absolutePath)
                "device_external_document_path" -> result.success(registrar.context().getExternalFilesDir("")?.absolutePath?.substringBeforeLast("/"))
                "device_external_file_path" -> result.success(registrar.context().getExternalFilesDir("")?.absolutePath.also { with(File(it)) { if (!exists()) mkdirs() } })
                "device_external_cache_path" -> result.success(registrar.context().externalCacheDir?.absolutePath.also { with(File(it)) { if (!exists()) mkdirs() } })
                "device_obb_path" -> result.success(registrar.context().obbDir?.absolutePath.also { with(File(it)) { if (!exists()) mkdirs() } })

                else -> {
                    val m = channelList[call.method]
                    if (m != null) {
                        val ret = m(registrar.context(), call.arguments as Map<String, Any?>)
                        result.success(if (ret is Unit) null else ret)
                    } else {
                        result.success(null)
                    }
                }
            }
        }
    }

	fun route(name: String, block:(ctx: Context, params: Map<String, Any?>) -> Any?) {
        channelList[name] = block
    }
    fun routeList(name: String, block:(ctx: Context, params: Map<String, Any?>) -> List<Any?>?) {
        channelList[name] = block
    }
    fun routeMap(name: String, block:(ctx: Context, params: Map<String, Any?>) -> Map<Any, Any?>?) {
        channelList[name] = block
    }
    fun routeObj(name: String, block:(ctx: Context, params: Map<String, Any?>) -> Map<String, Any?>?) {
        channelList[name] = block
    }
    fun routeObjList(name: String, block:(ctx: Context, params: Map<String, Any?>) -> List<Map<String, Any?>>?) {
        channelList[name] = block
    }

    fun routeObjMap(name: String, block:(ctx: Context, params: Map<String, Any?>) -> Map<Any, Map<String, Any?>>?) {
        channelList[name] = block
    }
  
}
