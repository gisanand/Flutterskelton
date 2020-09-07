import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appskeleton/basepackage/baseclass.dart';
import 'package:flutter_appskeleton/utils/CommonUtils.dart';

class Roundtext extends StatelessWidget {
  Widget textchild;
  callback onItemtabed;
  double width, height;
  double roundradius;
  double blurRadius;
  var marginvalue;
  String startcolor, endcolor,BoxShadowcolor="";

  Roundtext(
      {this.textchild,
      this.onItemtabed,
      this.width,
      this.height,
      this.roundradius = 20,
      this.blurRadius,
      this.marginvalue,this.startcolor, this.endcolor,this.BoxShadowcolor});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GestureDetector(
      onTap: onItemtabed,
      child: Container(
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
          boxShadow: [
            BoxShadow(
              color: CommonUtils.isHavingvalue(BoxShadowcolor)?CommonUtils.getColorFromHex('$BoxShadowcolor'):Colors.black12,
              offset: Offset(5, 5),
              blurRadius: blurRadius,
            ) , BoxShadow(
              color: CommonUtils.isHavingvalue(BoxShadowcolor)?CommonUtils.getColorFromHex('$BoxShadowcolor'):Colors.black12,
              offset: Offset(5, 5),
              blurRadius: blurRadius,
            )
          ],
        ),
        child: Center(
          child: textchild,
        ),
      ),
    );
    throw UnimplementedError();
  }
}
