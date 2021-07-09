import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_skeletonapp/NetworkRequests/AppResponse.dart';
import 'package:flutter_skeletonapp/NetworkRequests/Responsestreamcontroller.dart';
import 'package:flutter_skeletonapp/customtexts/Toast.dart';

import '../main.dart';
import 'user_preferences.dart';
import 'package:flutter_skeletonapp/constants/StringConstants.dart';
import 'package:flutter_skeletonapp/constants/UrlConstants.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef callback = void Function();
typedef callbacklistiner = void Function(dynamic values, int requestcode);
typedef clickfuncution = void Function(String values);
typedef callbackvalidator = Function(String values);
typedef Successcallback = void Function(Object json, int requestcode);
typedef Errorresponsecallback = void Function(String msg, int requestcode);
typedef jsontomodelconvertion = Object Function(String);
typedef retrunstringfunction = String Function(String);
typedef refershfunction = void Function(dynamic);
typedef filesendprogress =  Function(int count, int total);
typedef ApiResponseEmitter = Widget Function(ApiResponse apiResponse);
typedef StremBuilderEmitter = Widget Function(BuildContext context,dynamic data,Responsestreamcontroller currentcontroller);


mixin baseclass {
  //var apiutils=Apiutils();

  static const platform =
      const MethodChannel('id.uptopfiflutter.native_communication.channel');

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

  Color? getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

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
    UserPreferences().savedata(keyname, valuetype);
  }

  dynamic loaddata(String keyname, int valuetype) {
    return UserPreferences().loaddata(keyname, valuetype);
  }

  void showToast(BuildContext context, String msg) {
    Toast.show("$msg", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  void custompositionToast(
      {BuildContext? context, String? msg, int toastposition = 0}) {
    Toast.show("$msg", context!,
        duration: Toast.LENGTH_LONG, gravity: toastposition);
  }

  void appLog(String logmsg) {
    print(logmsg);
  }

  int convertToInt(String convertionvalue) {
    try {
      if (isHavingvalue(convertionvalue)) {
        return int.parse("$convertionvalue");
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  double convertToDouble(String convertionvalue) {
    try {
      if (isHavingvalue(convertionvalue)) {
        return double.parse("$convertionvalue");
      } else {
        return 0.0;
      }
    } catch (e) {
      print(e);
      return 0.0;
    }
  }

  void pushNewScreen(BuildContext context, WidgetBuilder widgetBuilder) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: widgetBuilder),
    );
    /* Navigator.pushReplacement(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) {
            return OnBoardScreen();
          },
          transitionDuration: Duration(milliseconds: 3000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation =
                CurvedAnimation(curve: Curves.decelerate, parent: animation);
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          }));*/
  }

  void NavigateNewScreen(BuildContext context, WidgetBuilder widgetBuilder) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: widgetBuilder),
    );
  }

  bool isTablet() {
    return Device.get().isTablet;
  }
  bool isOrientationcheck(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }


  double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }


  double setWidgetWidth(double value) {
    return ScreenUtil().setWidth(value);
  }

  double setWidgetHeight(double value) {
    return ScreenUtil().setHeight(value);
  }

}