import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomEditText extends StatelessWidget {
  final String text;
  final Color textcolor;
  final double textsize;
  final int familytype;
  final TextAlign textalign;
  final String hint;
  final String righticonname;
  TextEditingController textcontroller;
  var onchangetext;
  var marginvalue;
  var paddingvalues;
  bool obscureText = false;
  var sufixwidget;
  var prefixwidget;
  var texttype;
  var linecount;
  var wordlength;

  CustomEditText(
      {this.text,
      this.textcolor,
      this.textsize,
      this.familytype,
      this.textalign,
      this.hint = "",
      this.textcontroller,
      this.marginvalue,
      this.paddingvalues,
      this.obscureText,
      this.righticonname,
      this.sufixwidget,
      this.texttype,
      this.linecount,
      this.wordlength,
      this.onchangetext});

  @override
  Widget build(BuildContext context) {
    TextStyle tstyle =
        TextStyle(fontFamily: 'Bold', fontSize: textsize, color: textcolor);
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
        padding: paddingvalues,
        margin: marginvalue,
        child: TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '$hint',
                suffix: sufixwidget),
            keyboardType: texttype,
            maxLines: linecount,
            maxLength: wordlength,
            onChanged: onchangetext,
            obscureText: obscureText,
            controller: textcontroller,
            textAlign: textalign,
            style: tstyle));

    throw UnimplementedError();
  }
}
