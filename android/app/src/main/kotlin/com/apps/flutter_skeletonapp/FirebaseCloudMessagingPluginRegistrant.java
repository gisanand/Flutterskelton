package com.apps.flutter_skeletonapp;

import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin;

import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin;

public class FirebaseCloudMessagingPluginRegistrant {
    public static void registerWith(PluginRegistry registry) {

        if (alreadyRegisteredWith(registry)) {
            return;
        }

        FlutterFirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin"));
        FlutterLocalNotificationsPlugin.registerWith(registry.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"));


    }




    private static boolean alreadyRegisteredWith(PluginRegistry registry) {
        final String key = FirebaseCloudMessagingPluginRegistrant.class.getCanonicalName();
        if (registry.hasPlugin(key)) {
            return true;
        }
        registry.registrarFor(key);
        return false;
    }

}
