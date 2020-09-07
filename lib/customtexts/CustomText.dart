import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appskeleton/basepackage/baseclass.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color textcolor;
  final double textsize;
  final int familytype;
  final TextAlign textalign;
  final callback onItemtaped;
  var marginvalue;
  var linecount;
  var decorationval;


  CustomText(
      {this.text,
      this.textcolor,
      this.textsize,
      this.familytype,
      this.textalign,
      this.linecount,
      this.onItemtaped,this.marginvalue,this.decorationval});

  @override
  Widget build(BuildContext context) {



    TextStyle tstyle =
        TextStyle(fontFamily: 'Bold', fontSize: textsize, color: textcolor,decoration: decorationval);
    if (familytype == 1) {
      tstyle = TextStyle(
          fontFamily: 'Reguler', fontSize: textsize, color: textcolor,decoration: decorationval);
    } else if (familytype == 2) {
      tstyle =
          TextStyle(fontFamily: 'Medium', fontSize: textsize, color: textcolor,decoration: decorationval);
    } else if (familytype == 3) {
      tstyle =
          TextStyle(fontFamily: 'Bold', fontSize: textsize, color: textcolor,decoration: decorationval);
    } else if (familytype == 4) {
      tstyle =
          TextStyle(fontFamily: 'Italic', fontSize: textsize, color: textcolor,decoration: decorationval);
    }else if (familytype == 5) {
      tstyle =
          TextStyle(fontFamily: 'Light', fontSize: textsize, color: textcolor,decoration: decorationval);
    }
    // TODO: implement build
    return Container(
      margin: marginvalue,
      child: new GestureDetector(
          onTap: onItemtaped,
          child: new Text("$text", textAlign: textalign, style: tstyle,maxLines: linecount,)),
    );

    throw UnimplementedError();
  }
}
