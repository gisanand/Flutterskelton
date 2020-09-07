import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_appskeleton/basepackage/baseclass.dart';
import 'package:flutter_appskeleton/constants/StringConstants.dart';
import 'package:flutter_appskeleton/utils/CommonUtils.dart';

class MyAssetImage extends StatelessWidget {
  final String imageName;
  String subfolder;
  double width;
  double height;
  bool   visibile=true;
  final BoxFit customfit;
  var marginvalue;
  final callback onItemtaped;
  String icontint;
  String url="";
  MyAssetImage({this.imageName, this.subfolder = "images",this.width,this.height,this.customfit=BoxFit.fill,this.marginvalue,this.visibile=true,this.onItemtaped,this.icontint,this.url=""});
Widget getImage()
{
  Widget custwidget=null;
  if(!CommonUtils.isHavingvalue(url)) {
    custwidget= Image.asset('assets/$subfolder/$imageName', width: width,
      height: height,
      fit: customfit,
      );
  }else{
    custwidget= Image.network('$url', width: width,
        height: height,
        fit: customfit);
  }
  if(CommonUtils.isHavingvalue(icontint))
    {
      return ColorFiltered( child: custwidget,colorFilter: ColorFilter.mode(CommonUtils.getColorFromHex(icontint), BlendMode.srcIn));
    }else{
    return custwidget;
  }
}

Widget getSVGImage()
{

  Widget custwidget =SvgPicture.asset('assets/$subfolder/$imageName',width: width,height: height,fit: customfit);
  if(CommonUtils.isHavingvalue(icontint))
  {
    return ColorFiltered( child: custwidget,colorFilter: ColorFilter.mode(CommonUtils.getColorFromHex(icontint), BlendMode.srcIn));
  }else{
    return custwidget;
  }
}

  @override
  Widget build(BuildContext context) {
    print(" Image svg ${imageName.contains("ic_")}");
    return Visibility(visible: visibile,child:new GestureDetector(
        onTap: onItemtaped,
        child:Container(margin: marginvalue,child:imageName.contains("ic_")?getSVGImage():
        getImage())));
    throw UnimplementedError();
  }
}
