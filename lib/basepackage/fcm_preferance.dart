
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'NotificationPlugin.dart';
 String apptoken="";
//FirebaseMessaging? firebaseMessaging;
Map<String, dynamic> notificationdata = Map();
class Fcmpreferance {
  BuildContext? context;
   FirebaseMessaging?  _fcm = FirebaseMessaging.instance;
  static final Fcmpreferance? _instance = Fcmpreferance._ctor();
  factory Fcmpreferance() {
    return _instance!;
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage? message)  async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.

    print('Handling a background message ${message!.messageId}');

    Firebase.initializeApp().then((FirebaseApp value) {


      configuremessagechannel();
      _register();
      getMessageLitiner();


    });
  }

  void _register() async {
    /*firebaseMessaging!.getToken().then((token)  {
      apptoken="$token";
      print(token);

    });*/
    print("enter in _register method token called ");
try{
  FirebaseMessaging.instance.getAPNSToken().then((token) {
    apptoken="$token";
    print("App FCM TOKEN $token");
  }).catchError((e) {
    print("Exception occured token $e ");
  });
  _fcm!.getToken().then((token) {
    apptoken="$token";
    print("App FCM TOKEN $token");
  }).catchError((e) {
    print("Exception occured token $e ");
  });
}catch(e){
  print("Exception occured $e");
}

  }
    Fcmpreferance._ctor();

  init(BuildContext context) async {
    this.context=context;

    _fcm!.getToken().then((value) => print(value));
    Firebase.initializeApp().then((FirebaseApp value) {


      configuremessagechannel();
      _register();
      getMessageLitiner();


    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Set the background messaging handler early on, as a named top-level function

    //firebaseMessaging = FirebaseMessaging();
    /*_register();
    getMessage();*/

    notificationPlugin.notificationclickevent=notificationclickevent;
    notificationPlugin.init();

  }
void getMessageLitiner(){



    FirebaseMessaging.instance
    .getInitialMessage()
    .then((RemoteMessage? message) {
  if (message != null) {
    notificationclickevent(message.data);
  }
});

FirebaseMessaging.onMessage.listen((RemoteMessage message) {

  print('Notification on message ${message.data.toString()}');
  //print('Notification on message content ${message["aps"]["alert"]["title"]} body ${message["aps"]["alert"]["body"]}');
  notificationdata=message.data;


  //notificationPlugin.showNotification(message["aps"]["alert"]["title"],message["aps"]["alert"]["body"],message.toString());

});

FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  print('A new onMessageOpenedApp event was published!');
  print('Notification on launch ${message.data.toString()}');
  notificationdata=message.data;
});
}

  /*void getMessage(){
    firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('Notification on message $message');
          print('Notification on message content ${message["aps"]["alert"]["title"]} body ${message["aps"]["alert"]["body"]}');
          notificationdata=message;
          *//*notificationPlugin.setOnNotificationClick((){
print("Notification clicked");
          });*//*

          notificationPlugin.showNotification(message["aps"]["alert"]["title"],message["aps"]["alert"]["body"],message.toString());
        },
        onResume: (Map<String, dynamic> message) async {
      print('Notification on resume $message');
      notificationdata=message;
     // navigateNotificationScreen(message);

    }, onLaunch: (Map<String, dynamic> message) async {
      print('Notification on launch $message');
      notificationdata=message;
      //setState(() => _message = message["notification"]["title"]);
    });
  }*/
void notificationclickevent(Map<String, dynamic> message)
{
  print('Notificationclickevent worked');


}

  void configuremessagechannel() async {


    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

  }

}