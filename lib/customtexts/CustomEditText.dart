import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeletonapp/basepackage/baseclass.dart';
import 'package:flutter_skeletonapp/customtexts/colorstring.dart';
import 'package:flutter_skeletonapp/utils/CommonUtils.dart';

class CustomEditText extends StatelessWidget {
  final String? text;
  final Color? textcolor;
  final double? textsize;
  final int? familytype;
  final TextAlign textalign;
  final String hint;
  Color? hinttextcolor = CommonUtils.getColorFromHex(Colorstring.greytextcolor);
  final double? hinttextsize;
  final String? righticonname;
  TextEditingController? textcontroller;
  callbackvalidator? validatemethod;
  var onchangetext;
  var marginvalue;
  var paddingvalues;
  bool obscureText = false;
  var sufixwidget;
  var sufixiconwidget;
  var prefixwidget;
  var prefixiconwidget;
  var texttype;
  int? linecount = 1;
  var wordlength;
  var height;
  var fillcolor;
  bool showfilled;
  bool enableeditmode = true;
  double borderwidth = 0.0;
  Color bordercolor;
  Color? bgcolor;
  double borderradius = 0.0;
  var focusNode;
  var inputaction;

  var submitfuction;

  callbackvalidator? checkmethod;



  CustomEditText(
      {
        this.text,
      this.height,
      this.textcolor,
      this.textsize,
      this.familytype,
      this.textalign = TextAlign.left,
      this.hint = "",
      this.hinttextsize,
      this.hinttextcolor,
      this.textcontroller,
      this.marginvalue,
      this.paddingvalues,
      this.obscureText = false,
      this.righticonname,
      this.sufixwidget,
      this.sufixiconwidget,
      this.texttype,
      this.linecount = 1,
      this.wordlength,
      this.onchangetext,
      this.focusNode,
      this.inputaction,
      this.submitfuction,
      this.borderwidth = 0,
      this.bordercolor = Colors.transparent,
      this.borderradius = 0,
      this.prefixwidget,
      this.prefixiconwidget,
      this.bgcolor = Colors.white,
      this.enableeditmode = true,
        this.showfilled = false,
        this.fillcolor,
      this.validatemethod
        ,this.checkmethod});
  @override
  Widget build(BuildContext context) {
    TextStyle tstyle =
        TextStyle(fontFamily: 'Reguler', fontSize: textsize, color: textcolor);
    if (familytype == 1) {
      tstyle = TextStyle(
          fontFamily: 'Reguler', fontSize: textsize, color: textcolor);
    } else if (familytype == 2) {
      tstyle =
          TextStyle(fontFamily: 'Medium', fontSize: textsize, color: textcolor);
    } else if (familytype == 3) {
      tstyle =
          TextStyle(fontFamily: 'Bold', fontSize: textsize, color: textcolor);
    } else if (familytype == 4) {
      tstyle =
          TextStyle(fontFamily: 'Italic', fontSize: textsize, color: textcolor);
    } else if (familytype == 5) {
      tstyle =
          TextStyle(fontFamily: 'Light', fontSize: textsize, color: textcolor);
    }
    // TODO: implement build
    return Container(
        height: this.height,
        padding: paddingvalues,
        margin: marginvalue,
        child: TextFormField(
            initialValue: this.text,
            onFieldSubmitted: submitfuction,
            focusNode: this.focusNode,
            textInputAction: this.inputaction,
            enabled: enableeditmode,
            decoration: InputDecoration(
              filled: showfilled,
              fillColor: fillcolor,
              contentPadding: EdgeInsets.all(10.0),
              border: InputBorder.none,
              hintText: '$hint',
              hintStyle:
                  TextStyle(color: hinttextcolor, fontSize: hinttextsize),
              suffix: sufixwidget,
              suffixIcon: sufixiconwidget,
              prefix: prefixwidget,
              prefixIcon: prefixiconwidget,
              prefixIconConstraints: BoxConstraints(
                minHeight: 30,
                minWidth: 30,
              ),
              suffixIconConstraints:
                  BoxConstraints(minHeight: 30, minWidth: 30),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(this.borderradius - this.borderwidth)),
                  borderSide: BorderSide(color: Colors.red)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(this.borderradius - this.borderwidth)),
                  borderSide: BorderSide(color: Colors.red)),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(this.borderradius)),
                borderSide:
                    BorderSide(color: bordercolor, width: this.borderwidth),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(this.borderradius - this.borderwidth)),
                  borderSide: BorderSide(color: bordercolor)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(this.borderradius - this.borderwidth)),
                  borderSide: BorderSide(color: bordercolor)),
            ),
            keyboardType: texttype,
            maxLines: linecount,
            maxLength: wordlength,
            onChanged: (value) {
              onchangetext(value.trim());
            },
            obscureText: obscureText,
            controller: textcontroller,
            textAlign: textalign,
            validator: checkfun,
            style: tstyle));

    //throw UnimplementedError();
  }

  String? checkfun(value) {
    // ignore: top_level_function_literal_block
    if (validatemethod != null) {
      return validatemethod!(value.toString().trim());
    } else {
      return null;
    }
  }



  void sendmessage(String messsage) {}
}
