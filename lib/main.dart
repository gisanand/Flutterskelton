import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_skeletonapp/pages/splashscreen.dart';
import 'package:flutter_skeletonapp/utils/CommonUtils.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'customtexts/AppStrings.dart';
import 'customtexts/colorstring.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  languestr = jsonDecode(AppStrings.languagejson);

  runApp(MyApp());
}

Map<String, dynamic> languestr = Map();
double currentratio = 1.0;
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: CommonUtils.getColorFromHex(Colorstring.transparent),
        statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
// status bar color
    ));

    /*if(Device.get().isPhone) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }else   if(Device.get().isTablet) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
      ]);
    }*/

    return ScreenUtilInit(
      designSize: Size(360, 690),
     // allowFontScaling: false,
      builder: (){
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SeeSay',
            builder: (context, child) {
              return MediaQuery(
                child: child!,
                data: MediaQuery.of(context)
                    .copyWith(textScaleFactor: Device.get().isPhone ? 1.0 : 1.2),
              );
            },
            theme: ThemeData(

              primarySwatch: Colors.blue,

              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            //home: MyHomePage(title: 'Flutter Demo Home Page'),

            home: Splashscreen());
      },
    );
    //home: animationscreen());
  }
}
