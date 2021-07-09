import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeletonapp/basepackage/baseclass.dart';
import 'package:flutter_skeletonapp/customtexts/colorstring.dart';
import 'package:flutter_skeletonapp/utils/CommonUtils.dart';

class RoundButton extends StatelessWidget {
  Widget? textchild;
  callback? onItemtabed;
  double? width, height;
  double? roundradius;
  double? blurRadius;
  var marginvalue;
  String? startcolor, endcolor,boxShadowcolor="${Colorstring.grayline}";

  RoundButton(
      {this.textchild,
      this.onItemtabed,
      this.width,
      this.height,
      this.roundradius = 20,
      this.blurRadius,
      this.marginvalue,this.startcolor, this.endcolor,this.boxShadowcolor="${Colorstring.grayline}"});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
return Container(
  width: this.width,
  height: this.height,
  child: RaisedButton(
    onPressed: onItemtabed,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(this.roundradius!),side: BorderSide(color: CommonUtils.getColorFromHex('$boxShadowcolor')! )),
    padding: EdgeInsets.all(0.0),
    child: Ink(

      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            CommonUtils.getColorFromHex('$startcolor')!,
            CommonUtils.getColorFromHex('$endcolor')!,],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(this.roundradius!)

      ),
      child: Container(
        constraints: BoxConstraints( minHeight: 50.0),
        alignment: Alignment.center,
        child:textchild,
      ),
    ),
  ),
);
    /*return GestureDetector(
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
    );*/
    //throw UnimplementedError();
  }
}
