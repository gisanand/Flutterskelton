import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show File, Platform;

import 'package:rxdart/rxdart.dart';
import 'package:flutter_skeletonapp/constants/StringConstants.dart';

import 'fcm_preferance.dart';
int notifcationid=1;
class NotificationPlugin {
  BuildContext? context;
  Function(Map<String, dynamic>)? notificationclickevent;

  //
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  final BehaviorSubject<ReceivedNotification> didReceivedLocalNotificationSubject =BehaviorSubject<ReceivedNotification>();
  var initializationSettings;


  NotificationPlugin.notifcationplugin() {
    init();
  }
  init() async {
    print("Notification init called");
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      _requestIOSPermission();
    }
    initializePlatformSpecifics();

  }
  initializePlatformSpecifics() {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('app_notf_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        ReceivedNotification receivedNotification = ReceivedNotification(
            id: id, title: title, body: body, payload: payload);
        didReceivedLocalNotificationSubject.add(receivedNotification);
      },
    );
    initializationSettings = InitializationSettings(android:initializationSettingsAndroid,iOS: initializationSettingsIOS);
     flutterLocalNotificationsPlugin!.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }
  _requestIOSPermission() {
    flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(
      alert: false,
      badge: true,
      sound: true,
    );
  }
  setListenerForLowerVersions(Function onNotificationInLowerVersions) {
    didReceivedLocalNotificationSubject.listen((receivedNotification) {
      print("NOtification on recived called");
      print("NOtification on recived called");
      onNotificationInLowerVersions(receivedNotification);
    });
  }

  Future selectNotification(var payload) async {
    print('notification payload: $payload');
    var data=jsonDecode(payload);
    notificationdata=data;
    notificationclickevent!(payload);
  }
  Future<void> showNotification(String title,String body,String payload) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      StringConstants.NOTIFICATION_CHANELID,
      StringConstants.NOTIFICATION_CHANELNAME,
      StringConstants.NOTIFICATION_CHANELDESCRIPTION,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(android:androidChannelSpecifics, iOS:iosChannelSpecifics);
    await flutterLocalNotificationsPlugin!.show(
      notifcationid++,
      '$title',
      '$body', //null
      platformChannelSpecifics,
      payload: payload,
    );
  }
 /* _downloadAndSaveFile(String url, String fileName) async {
  *//*  var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(url);
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;*//*




  }*/

  Future<void> scheduleNotification(DateTime scheduletime,Map<String,dynamic> payload,int indemateseconds) async {
    try{


    var scheduleNotificationDateTime = scheduletime.subtract(Duration(seconds: indemateseconds));
    var androidChannelSpecifics = AndroidNotificationDetails(
      StringConstants.NOTIFICATION_CHANELID,
      StringConstants.NOTIFICATION_CHANELNAME,
      StringConstants.NOTIFICATION_CHANELDESCRIPTION,
      //icon: 'app_notf_icon',
      // sound: RawResourceAndroidNotificationSound('my_sound'),
      largeIcon: DrawableResourceAndroidBitmap('app_notf_icon'),
      enableLights: true,
      color: Colors.transparent,
      ledColor: Colors.transparent,
      ledOnMs: 10000,
      ledOffMs: 500,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails(
      sound: 'my_sound.aiff',
    );
    var platformChannelSpecifics = NotificationDetails(android:
    androidChannelSpecifics,
      iOS:iosChannelSpecifics,
    );
    print("Notitficationdetails $platformChannelSpecifics");
    await flutterLocalNotificationsPlugin!.schedule(
      0,
      '${payload["aps"]["alert"]["title"]}',
      '${payload["aps"]["alert"]["body"]}',
      scheduleNotificationDateTime,
      platformChannelSpecifics,
      payload: jsonEncode(payload),

    );
    }catch(e)
    {
      print("Error $e");
    }
  }
  Future<int> getPendingNotificationCount() async {
    List<PendingNotificationRequest> p =
    await flutterLocalNotificationsPlugin!.pendingNotificationRequests();
    return p.length;
  }
  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin!.cancel(0);
  }
  Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin!.cancelAll();
  }


}

NotificationPlugin notificationPlugin = NotificationPlugin.notifcationplugin();
class ReceivedNotification {
  final int? id;
  final String? title;
  final String? body;
  final String? payload;
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}