package com.apps.flutter_skeletonapp;

import com.google.firebase.messaging.FirebaseMessaging;

import io.flutter.app.FlutterApplication;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingService;

public class myApplication extends FlutterApplication implements PluginRegistrantCallback {
    @Override
    public void onCreate() {
        super.onCreate();
        
      //  FlutterFirebaseMessagingService.setPluginRegistrant(this);
    }

    @Override
    public void registerWith(PluginRegistry registry) {
        GeneratedPluginRegistrant.registerWith((FlutterEngine) registry);
        FirebaseCloudMessagingPluginRegistrant.registerWith(registry);
    }
}
