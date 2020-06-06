package com.example.flutter_shop;

import com.example.plugin.baiduvoice.AsrPlugin;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;

public class EmbeddingV1Activity extends FlutterActivity{
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        AsrPlugin.registerWith(registrarFor("com.example.plugin.baiduvoice.AsrPlugin"));
    }

}
