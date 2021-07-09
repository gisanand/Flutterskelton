import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeletonapp/NetworkRequests/Apiutils.dart';
import 'package:flutter_skeletonapp/NetworkRequests/Responsestreamcontroller.dart';
import 'package:flutter_skeletonapp/basepackage/baseclass.dart';
import 'package:flutter_skeletonapp/basepackage/user_preferences.dart';
import 'package:flutter_skeletonapp/constants/StringConstants.dart';

 String currentReceiverid="";
abstract class BasePage extends StatefulWidget {

  BasePage({Key? key}) : super(key: key);
}

/*abstract class BaseState<Page extends BasePage> extends State<Page> with baseclass{


  Apiutils apiutils=Apiutils();
  


}*/


class Resume {
  dynamic data;
  String? source;
}
callbacklistiner? currentScreenListiner;
callbacklistiner? mainpageListiner;


abstract class BaseState<Page extends BasePage> extends State<Page> with WidgetsBindingObserver,baseclass
{
  int currentZoon=2;
  Resume resume = new Resume();
  bool _isPaused = false;
  BuildContext? maintcontext;

 // BaseState(this.maintcontext);

  /// Implement your code here
  void onResume() {

  }

  /// Implement your code here
  void onReady() {


  }

  /// Implement your code here
  void onPause() {

  }

  /// This method is replacement of Navigator.push(), but fires onResume() after route popped
  Future<T> push<T extends BasePage>(BuildContext context, Route<T> route, [String? source]) {
    _isPaused = true;
    onPause();

    return Navigator.of(context).push(route).then((value) {
      _isPaused = false;

      resume.data = value;
      resume.source = source;

      onResume();
      return value!;
    });
  }

  /// This method is replacement of Navigator.pushNamed(), but fires onResume() after route popped
  Future<T> pushNamed<T extends Object>(BuildContext context, String routeName, {Object? arguments}) {
    _isPaused = true;
    onPause();

    return Navigator.of(context).pushNamed<T>(routeName, arguments: arguments).then((value) {
      _isPaused = false;

      resume.data = value;
      resume.source = routeName;

      onResume();
      return value!;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);
    WidgetsBinding.instance!.addPostFrameCallback((_) => onReady());

  }


  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      if (!_isPaused) {
        onPause();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (!_isPaused) {
        onResume();
      }
    }
  }
}
