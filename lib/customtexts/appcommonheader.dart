import 'package:flutter/cupertino.dart';
import 'package:flutter_skeletonapp/customtexts/colorstring.dart';
import 'package:flutter_skeletonapp/utils/CommonUtils.dart';


class Appheader extends StatelessWidget with PreferredSizeWidget
{
  double? width;
  double? height;
  String? gradientstatrcolor;
  String? gradientendcolor;
  Widget? headerchild;


  Appheader({this.width=0, this.height=100.0, this.gradientstatrcolor,
      this.gradientendcolor, this.headerchild}): preferredSize = Size.fromHeight(height!);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width==0?MediaQuery.of(context).size.width:width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
           CommonUtils.getColorFromHex('${CommonUtils.isHavingvalue(gradientstatrcolor!)?gradientstatrcolor:Colorstring.appgradientstartcolor}')!,
            CommonUtils.getColorFromHex('${CommonUtils.isHavingvalue(gradientendcolor!)?gradientendcolor:Colorstring.appgradientendcolor}')!,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0)),
      ),
      child: headerchild
    );



  }


  @override
  final Size preferredSize;
}