import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_skeletonapp/applistview/AppListview.dart';
import 'package:flutter_skeletonapp/applistview/applistviewtile.dart';
import 'package:flutter_skeletonapp/basepackage/baseclass.dart';
import 'package:flutter_skeletonapp/basepackage/basestate.dart';
import 'package:flutter_skeletonapp/basepackage/fcm_preferance.dart';
import 'package:flutter_skeletonapp/basepackage/user_preferences.dart';
import 'package:flutter_skeletonapp/constants/StringConstants.dart';
import 'package:flutter_skeletonapp/customtexts/CustomText.dart';
import 'package:flutter_skeletonapp/customtexts/colorstring.dart';
import 'package:flutter_skeletonapp/customtexts/dimension.dart';
import 'package:flutter_skeletonapp/utils/CommonUtils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_core/firebase_core.dart';

class Splashscreen extends BasePage
{
  SplashState createState() => SplashState();


}
class SplashState extends State<Splashscreen> with baseclass , TickerProviderStateMixin {
String? updatvalues;
  @override
  Widget build(BuildContext context) {

    print( "Deviceratio ${MediaQuery.of(context).devicePixelRatio}");
    // TODO: implement build
    //var shortestSide = MediaQuery.of(context).size.shortestSide;
    //var useMobileLayout = shortestSide < 600;



    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
   /* ScreenUtil.init(context,
        width: screenwidth, height: screenheight, allowFontScaling: true);*/

    return Scaffold(

      body: Container(
        color: Colors.white,
      child: AppListview(
        count:10, listchildfun:(AnimationController tilecontroller){
          return (context,index){
            return  applistviewtile.initlistviewtile(10, index, Container(
              width: 50,height: 100,
              child:Card(
                child: Container(
                  margin: EdgeInsets.all(15),
                  width: 50,height: 100,
                  color: Colors.green,
                ),
              ),
            ), tilecontroller);
          };
      },scrolldirection: Axis.vertical,
      )
      ),
    );
  }

  @override
  void initState() {


    // ignore: unnecessary_statements
    //  Firebase.initializeApp().then((value) {
    // intisharedvalues().then((values){
    //   /*setState(() {
    //     updatvalues=loaddata("test", 1);
    //   });
    //   savedata("test", "updatvalues");*/
    //   startTime();
    // });
    //  });
  }
startTime() async {
  var duration = new Duration(seconds: 3);
  return new Timer(duration, route);
}
route() {
    if(isHavingvalue("${loaddata(StringConstants.PREF_TOKEN, 1)}")) {
      /*Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => dashboardscreen()
      )
      );*/
      navigateScreen();
    }else{

    }
}

void navigateScreen()
{
}
   intisharedvalues()async
  {
    WidgetsFlutterBinding.ensureInitialized();
    await Fcmpreferance().init(context);
    await UserPreferences().init();
  }
void navigateNotificationScreen(Map<String, dynamic> message)
{
  //Navigator.pushNamed(context, routeName);
  /*Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => MainScreen(fromnotificationscreen:"1")),
  );
*/
}
}