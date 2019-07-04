package com.rarnu.ktflutter

import android.content.Context
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

fun nativeRouting(block: KtflutterPlugin.() -> Unit) {
    block(KtflutterPlugin)
}

object KtflutterPlugin {
    private const val channelName = "com.rarnu.flutter/routing"
    private val channelList = mutableMapOf<String, (Context, Map<String, Any?>) -> Any?>()

    @JvmStatic
    fun registerWith(registrar: PluginRegistry.Registrar) {
        MethodChannel(registrar.messenger(), channelName).setMethodCallHandler { call, result ->
            val m = channelList[call.method]
            if (m != null) {
                val ret = m(registrar.context(), call.arguments as Map<String, Any?>)
                result.success(if (ret is Unit) null else ret)
            } else {
                result.success(null)
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
