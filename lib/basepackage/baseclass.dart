import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';

import '../main.dart';
import 'user_preferences.dart';

typedef callback = void Function();
typedef Successcallback = void Function(Object json, int requestcode);
typedef Errorresponsecallback = void Function(String msg, int requestcode);
typedef jsontomodelconvertion = Object Function(String);

mixin baseclass {

  //var apiutils=Apiutils();

  static const platform = const MethodChannel(
      'id.uptopfiflutter.native_communication.channel');

  String getStringName(String stringname) {
    String stringvalue = "";


    try {
      //  Map<String, dynamic> languestr = jsonDecode(AppStrings.languagejson);
      stringvalue = languestr[stringname];
    } on Exception catch (e) {
      print('never reached $e');
      return stringvalue;
    }
    return stringvalue;
  }

  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  /* Future<void> savesharedData(String keyname,Object keyvalue) async {
    String batteryLevel;
    try {
      bool result = await platform.invokeMethod('saveSharedData',{"keyname":"token","keyvalue":keyvalue});
      batteryLevel = '$result';
      print(" BatteryLEvel Response $batteryLevel");
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }


  }

  Future<Object> getsharedData(String keyname,Object valuetype) async {
    String batteryLevel;
    try {
      Object result = await platform.invokeMethod('getSheredData',{"keyname":"token","keyvalue":valuetype});
      batteryLevel = '$result';
      print(" BatteryLEvel Response $batteryLevel");
      return result;
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";

    }


  }*/


  bool isHavingvalue(String str) {
    if (str == null) {
      return false;
    } else {
      if (str.isNotEmpty) {
        if (str == "null") {
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    }
  }

  void savedata(String keyname, dynamic valuetype) {
   UserPreferences().savedata(keyname,valuetype);
  }

  dynamic loaddata(String keyname, int valuetype) {
    return UserPreferences().loaddata(keyname,valuetype);
  }
}

