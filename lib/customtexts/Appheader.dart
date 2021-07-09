import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_skeletonapp/basepackage/basestate.dart';
import 'package:flutter_skeletonapp/customtexts/MyAssetImage.dart';
import 'package:flutter_skeletonapp/customtexts/dimension.dart';

class AppHeader extends StatelessWidget with PreferredSizeWidget {
  double? width;
  double? height;
  double? iconheight;
  Widget? rightChild;
  Widget? leftChild;
  Color? bgColor;
  String? applogoicon;
var iconalign;
  AppHeader(
      {this.width = 0,
      this.height = 100.0,
      this.rightChild,
      this.leftChild,
      this.bgColor,
      this.iconalign=Alignment.bottomCenter,
      this.applogoicon = "ic_redwithlogo.svg",
      this.iconheight})
      : preferredSize = Size.fromHeight(height!);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
        decoration: BoxDecoration(color: bgColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leftChild!,
            Container(
              child: MyAssetImage(
                height: iconheight! * 0.50,
                width: width! * 0.70,
                imageName: applogoicon!,
                customfit: BoxFit.fill,
                marginvalue: EdgeInsets.all(Dimension.margin_extra_very_small),
                align: iconalign,
              ),
            ),
            rightChild!
          ],
        ));
  }

  @override
  final Size preferredSize;
}
