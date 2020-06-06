package com.example.flutter_shop

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant




class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
//        registerSelfPlugin()
    }

//    //百度语音监听
//    private fun registerSelfPlugin() {
//
//        AsrPlugin.registerWith(registrarFor("ord.devio.flutter.plugin.asr.AsrPlugin"))
//    }
}
