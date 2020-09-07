import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appskeleton/basepackage/baseclass.dart';
import 'package:flutter_appskeleton/utils/CommonUtils.dart';

class Squerbox extends StatelessWidget {
  Widget textchild;
  callback onItemtabed;
  double width, height;
  double roundradius;
  double blurRadius;
  var marginvalue;
  String startcolor, endcolor,BoxShadowcolor="";

  Squerbox(
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
        decoration:  new BoxDecoration(
        shape: BoxShape.rectangle,
        border: new Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
        child: textchild,
      ),
    );
    throw UnimplementedError();
  }
}
