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

  callbackvalidator validatemethod;

  var onchangetext;

  var marginvalue;

  var paddingvalues;

  bool obscureText = false;

  var sufixwidget;

  var sufixiconwidget;

  var prefixwidget;

  var prefixiconwidget;

  var texttype;

  var linecount;

  var wordlength;

  bool enableeditmode = true;

  double borderwidth = 0.0;

  Color bordercolor;

  double borderradius = 0.0;



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

        this.obscureText = false,

        this.righticonname,

        this.sufixwidget,

        this.sufixiconwidget,

        this.texttype,

        this.linecount,

        this.wordlength,

        this.onchangetext,

        this.borderwidth,

        this.bordercolor,

        this.borderradius,

        this.prefixwidget,

        this.prefixiconwidget,

        this.enableeditmode = true,

        this.validatemethod});



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



            enabled: enableeditmode,

            decoration: InputDecoration(

              border: InputBorder.none,

              hintText: '$hint',

              suffix: sufixwidget,

              suffixIcon: sufixiconwidget,

              prefix: prefixwidget,

              prefixIcon: prefixiconwidget,

              prefixIconConstraints: BoxConstraints(minHeight: 30,minWidth: 30),

              suffixIconConstraints: BoxConstraints(minHeight: 30,minWidth: 30),

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

            onChanged: onchangetext,

            obscureText: obscureText,

            controller: textcontroller,

            textAlign: textalign,

            validator: validatemethod,

            style: tstyle));



    throw UnimplementedError();

  }

}