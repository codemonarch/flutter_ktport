package com.example.ktflutter_example

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import com.rarnu.ktflutter.nativeRouting

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    nativeRouting {
      route("hello") { _, params ->
        "hello ${params["name"]}"
      }
    }
  }
}
