import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:flutter_appskeleton/basepackage/baseclass.dart';

import 'package:flutter_appskeleton/customtexts/colorstring.dart';

import 'package:flutter_appskeleton/utils/CommonUtils.dart';

class Roundbg extends StatelessWidget {

  Widget textchild;

  callback onItemtaped;

  double width, height;

  double roundradius;

  double blurRadius;

  var elivationvalues;

  var marginvalue;



  String startcolor, endcolor,Boxlinecolor="${colorstring.grayline}";



  Roundbg(

      {this.textchild,

        this.onItemtaped,

        this.width,

        this.height,

        this.roundradius = 20.0,

        this.blurRadius=0.0,

        this.elivationvalues=0.0,

        this.marginvalue,this.startcolor=colorstring.white, this.endcolor=colorstring.white,this.Boxlinecolor="${colorstring.grayline}"});



  @override

  Widget build(BuildContext context) {

    // TODO: implement build

/*return new GestureDetector(

    onTap: onItemtaped,child: Card(



  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(this.roundradius),side: BorderSide(color: CommonUtils.getColorFromHex('$Boxlinecolor') )),

  elevation: elivationvalues,

  child: Container(



    decoration: BoxDecoration(



        gradient: LinearGradient(colors: [

          CommonUtils.getColorFromHex('$startcolor'),

          CommonUtils.getColorFromHex('$endcolor'),],

          begin: Alignment.centerLeft,

          end: Alignment.centerRight,

        ),

        borderRadius: BorderRadius.circular(this.roundradius)



    ),

    child: Container(

      constraints: BoxConstraints( minHeight: 50.0),

      alignment: Alignment.center,

      child:textchild,

    ),

  ),

));*/

    return GestureDetector(

      onTap: onItemtaped,



      child:Card(

          elevation: this.elivationvalues,

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(this.roundradius),side: BorderSide(color: CommonUtils.getColorFromHex('$Boxlinecolor') )),

          child:Container(

            margin: marginvalue,

            width: width,

            height: height,

            decoration: BoxDecoration(



              gradient: LinearGradient(

                colors: [

                  CommonUtils.getColorFromHex('$startcolor'),

                  CommonUtils.getColorFromHex('$endcolor'),

                ],

                begin: Alignment.topLeft,

                end: Alignment.bottomRight,

              ),

              borderRadius: BorderRadius.circular(this.roundradius),



            ),

            child: Center(

              child: textchild,

            ),

          )),

    );

    throw UnimplementedError();

  }

}