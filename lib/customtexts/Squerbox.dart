import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeletonapp/basepackage/baseclass.dart';
import 'package:flutter_skeletonapp/customtexts/colorstring.dart';
import 'package:flutter_skeletonapp/utils/CommonUtils.dart';

class Squerbox extends StatelessWidget {
  Widget? textchild;
  callback? onItemtabed;
  double? width, height;
  double? roundradius;
  double? blurRadius;
  var marginvalue;
  String? startcolor, endcolor,boxShadowcolor="${Colorstring.black}";

  Squerbox(
      {this.textchild,
      this.onItemtabed,
      this.width,
      this.height,
      this.roundradius = 20,
      this.blurRadius,
      this.marginvalue,this.startcolor, this.endcolor,this.boxShadowcolor="${Colorstring.black}"});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GestureDetector(
      onTap: onItemtabed,
      child: Container(

        margin: marginvalue,
        width: width,
        height: height,
        decoration:  new BoxDecoration(
          gradient: LinearGradient(
            colors: [
              CommonUtils.getColorFromHex('$startcolor')!,
              CommonUtils.getColorFromHex('$endcolor')!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        shape: BoxShape.rectangle,
        border: new Border.all(
          color: CommonUtils.getColorFromHex(boxShadowcolor!)!,
          width: 1.0,
        ),
      ),
        child: textchild,
      ),
    );
    //throw UnimplementedError();
  }
}
