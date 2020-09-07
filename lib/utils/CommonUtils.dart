import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:flutter_appskeleton/NetworkRequests/customProgressDialog.dart';

class CommonUtils{
  static customProgressDialog pr;
  static String assetsPath = 'assets/images/';

  static String assetsImage(String fileName) {
    switch (fileName) {
      case 'Filter':
        return '${assetsPath}ic_filter_default.png';
    }

    return '';
  }


  static Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  static bool isHavingvalue(String str)
  {
    if(str==null)
      {
        return false;
      }else{
      if(str.isNotEmpty)
        {
          if(str=="null")
            {
              return false;
            }else{
            return true;
          }
        }else{
        return false;
      }
    }

  }

 static void showprogressbar(BuildContext context) {
    pr = new customProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);

    pr.show();
  }

 static  void hideprogressbar() {
    if (pr != null) {
      pr.dismiss();
    }
  }
  static showAlertDialog(BuildContext context,String title,String msg)
  {
    AlertDialog alert;
    // set up the buttons

    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed:  () {
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

  static showAppAlertDialog(BuildContext context,String title,String msg)
  {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {},
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {},
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

  static bool isValidateEmail(String emailid)
  {
  String emailPattern = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+";
  bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailid);

  return emailValid;

  }

static  void showToastMessage(BuildContext context,String msg)
  {
    Toast.show("$msg", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }
}
