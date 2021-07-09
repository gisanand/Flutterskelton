import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_skeletonapp/customtexts/Toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_skeletonapp/basepackage/NotificationPlugin.dart';
import 'package:flutter_skeletonapp/basepackage/baseclass.dart';
import 'package:flutter_skeletonapp/customtexts/CustomText.dart';
import 'package:flutter_skeletonapp/customtexts/MyAssetImage.dart';
import 'package:flutter_skeletonapp/customtexts/Roundbuttontext.dart';
import 'package:flutter_skeletonapp/customtexts/colorstring.dart';
import 'package:flutter_skeletonapp/customtexts/dimension.dart';
import 'package:intl/intl.dart';

import '../basepackage/user_preferences.dart';
import '../constants/StringConstants.dart';

final GlobalKey<State>? _progressloader = new GlobalKey<State>();

class CommonUtils {

  static String assetsPath = 'assets/images/';

  static String assetsImage(String fileName) {
    switch (fileName) {
      case 'Filter':
        return '${assetsPath}ic_filter_default.png';
    }

    return '';
  }

  static Color? getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  static bool isHavingvalue(String str) {
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



  static showAlertDialog(BuildContext context, String title, String msg) {
    AlertDialog alert;
    // set up the buttons

    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    alert = AlertDialog(
      title: Text("$title"),
      content: Text("$msg"),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static sessionexpiered(BuildContext context, String title, String msg) {
    AlertDialog alert;
    // set up the buttons

    Widget continueButton = FlatButton(
      child: Text("Go to login"),
      onPressed: () {
        UserPreferences().savedata(StringConstants.PREF_TOKEN, "");
        UserPreferences().savedata(StringConstants.PREF_USERID, "");

        /* Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => LoginScreen()
            ),
            ModalRoute.withName("/Login")
        );*/
      },
    );

    // set up the AlertDialog
    alert = AlertDialog(
      title: Text("$title"),
      content: Text("Login Expired"),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope( onWillPop: () async => false, child: alert);
      },
    );
  }

  static showAppAlertDialog(BuildContext context, String title, String msg) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {},
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("$title"),
      content: Text("$msg"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showCustomAppdialog(
      BuildContext context,
      String title,
      String msg,
      String passtivename,
      String negativename,
      callback passtivecallback,
      callback neagtivecallback) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("$negativename"),
      onPressed: neagtivecallback == null
          ? () {
              Navigator.pop(context);
            }
          : neagtivecallback,
    );
    Widget continueButton = FlatButton(
      child: Text("$passtivename"),
      onPressed: passtivecallback,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("$title"),
      content: Text("$msg"),
      actions: [
        continueButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showCustomWidgetdialog(BuildContext context, Widget dialogui) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return dialogui;
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  static bool isValidateEmail(String emailid) {
    // String emailPattern = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+";
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailid);

    return emailValid;
  }

  static void showToastMessage(BuildContext context, String msg) {
    Toast.show("$msg", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  static Future<void> showProgressloading(BuildContext context) async {
    if (_progressloader!.currentContext != null) {
      return;
    }
    hideprogressloading();
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: _progressloader,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Wait....",
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ]));
        });
  }

  static void hideprogressloading() {
    if (_progressloader!.currentContext != null) {
      Navigator.of(_progressloader!.currentContext!, rootNavigator: true).pop();
    }
  }

  static String getCurentdateasString(String format) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat(format).format(now);
    return formattedDate;
  }

  static String dateToString(DateTime now, String format) {
    String formattedDate = DateFormat(format).format(now);
    return formattedDate;
  }

  static String convertStringtoDate(
      String inputdatestring, String inputformat, String outputformat) {
    String convertedate = "";
    try {
      if (isHavingvalue(inputdatestring)) {
        DateTime tempDate = new DateFormat(inputformat).parse(inputdatestring);
        convertedate = DateFormat(outputformat).format(tempDate);
      }
    } catch (e) {
      print(e);
    }

    return convertedate;
  }

  static DateTime stringtoDate(String inputdatestring, String inputformat) {
    DateTime? convertedate;
    try {
      if (isHavingvalue(inputdatestring)) {
        convertedate = new DateFormat(inputformat).parse(inputdatestring);
        //convertedate = DateFormat(outputformat).format(tempDate);
      }
    } catch (e) {
      print(e);
    }

    return convertedate!;
  }

  static void addSchedulenotification(DateTime timeval, String title,
      String body, int status, int indemateseconds) {
    String jsobj = '{'
        '"status": "$status", "google.c.sender.id": "407514579351", "google.c.a.e": "1", "id": "1", "aps":'
        '{"alert": {"title": "$title", "body": "$body"}}'
        '}';
    var jsitem = jsonDecode(jsobj);
    notificationPlugin.scheduleNotification(timeval, jsitem, indemateseconds);
  }

  Future checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print("Connected to Mobile Network");
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("Connected to WiFi");
      return true;
    } else {
      print("Unable to connect. Please Check Internet Connection");
      return false;
    }
  }

  //
  // showAPPAlertDialogBox(BuildContext context, Widget iconWidget,
  //     Widget textWidget, String btnName, callback btnEvent) {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Container(
  //             margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
  //             child: Stack(children: [
  //               Positioned(
  //                 top: 0.0,
  //                 right: 0.0,
  //                 child: IconButton(
  //                   icon: Icon(Icons.clear),
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                 ),
  //               ),
  //               Container(
  //                 margin: EdgeInsets.only(top: 50.0),
  //                 child: Column(
  //                   children: [
  //                     iconWidget,
  //                     textWidget,
  //                     RoundButton(
  //                       onItemtabed: btnEvent,
  //                       height: 50,
  //                       width: MediaQuery.of(context).size.width * 0.75,
  //                       roundradius: 10,
  //                       blurRadius: 20,
  //                       boxShadowcolor: Colorstring.roundlinecolor,
  //                       startcolor: Colorstring.appcolorsecond,
  //                       endcolor: Colorstring.appcolorsecond,
  //                       textchild: CustomText(
  //                         text: "$btnName",
  //                         align: Alignment.center,
  //                         textalign: TextAlign.center,
  //                         softwrap: true,
  //                         textsize: Dimension.text_large,
  //                         textcolor: Colors.white,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ]),
  //           ),
  //         );
  //       });
  // }
  double dialogboxwidth(BuildContext context){

    double widtper=0.80;

    if(MediaQuery.of(context).orientation == Orientation.portrait)
    {
     widtper=Device.get().isTablet?0.40:0.80;
    }else{
      widtper=Device.get().isTablet?0.30:0.40;
    }

  return  MediaQuery.of(context).size.width * widtper;
  }

 void  showAPPAlertDialogBox(BuildContext context, Widget iconWidget,
      Widget textWidget, String btnName, callback btnEvent) {
    Dialog fancyDialog = Dialog(

      backgroundColor: Colors.transparent,
        child: Wrap(
      children: [
        Container(
          width: dialogboxwidth(context),
          decoration: BoxDecoration(
color: Colors.white,
              borderRadius: BorderRadius.circular(25.0)
          ),
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: Column(
                  children: [
                    iconWidget,
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Center(
                        child: Container(
                            alignment: Alignment.center,

                            child: textWidget),
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0 ,bottom:  20.0),
                      child: RoundButton(
                        onItemtabed: btnEvent,
                        height: 50,
                        width: 200,
                        roundradius: 10,
                        blurRadius: 20,
                        boxShadowcolor: Colorstring.roundlinecolor,
                        startcolor: Colorstring.appcolorsecond,
                        endcolor: Colorstring.appcolorsecond,
                        textchild: CustomText(
                          text: "$btnName",
                          align: Alignment.center,
                          textalign: TextAlign.center,
                          softwrap: true,
                          textsize: Dimension.text_large,
                          textcolor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
     showDialog(
         context: context, builder: (BuildContext context) => fancyDialog);
  }


  static Future<String> getFilepath(String folderName) async {
    var filepath;
    print("File Createed: Folder name getFilepath $folderName");
    getApplicationDocumentsDirectory().then((exvalue) {
      print("File Createed: Folder external dir ${exvalue.path}");
      final Directory _appDocDirFolder =
          Directory('${exvalue.path}/$folderName/');
      _appDocDirFolder.exists().then((value) {
        if (value) {
          print("File Createed: Folder external dir THER ${value}");
          //if folder already exists return path
          filepath= _appDocDirFolder.path;
        } else {

          //if folder not exists create folder and then return its path
          _appDocDirFolder.create(recursive: true).then((value) {
            print("File Createed: Folder created ${value.path}");
            filepath= value.path;
          });
        }
      });
    });

    return filepath;
  }


  static Future<String> creatseesayfile(String folderName,clickfuncution callbackfun) async {
    String filepath="";
    print("File Createed:creatseesayfile  Folder name getFilepath $folderName");
    getApplicationDocumentsDirectory().then((exvalue) {
      print("File Createed: creatseesayfile Folder external dir ${exvalue.path}");
      final Directory _appDocDirFolder =
      Directory('${exvalue.path}/$folderName/');
      _appDocDirFolder.exists().then((value) {
        if (value) {
          print("File Createed: creatseesayfile Folder external dir THER ${value}");
          //if folder already exists return path
          filepath= _appDocDirFolder.path;
          callbackfun(filepath);
        } else {

          //if folder not exists create folder and then return its path
          _appDocDirFolder.create(recursive: true).then((value) {
            print("File Createed: creatseesayfile Folder created ${value.path}");
            filepath= value.path;
            callbackfun(filepath);
          });
        }

      });
    });

    return filepath;
  }



}