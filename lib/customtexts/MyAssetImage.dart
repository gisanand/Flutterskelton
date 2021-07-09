import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_skeletonapp/basepackage/baseclass.dart';
import 'package:flutter_skeletonapp/utils/CommonUtils.dart';

class MyAssetImage extends StatelessWidget {
  final String imageName;
  String subfolder;
  double? width;
  double? height;
  bool visibile = true;
  final BoxFit customfit;
  var marginvalue;
  final callback? onItemtaped;
  String? icontint;
  String url = "";
  String placeholderimage = "";
var align;
  FilterQuality filterqualitiy=FilterQuality.low;
  MyAssetImage(
      {this.imageName = "null",
      this.subfolder = "images",
      this.width,
      this.height,
      this.customfit = BoxFit.fill,
      this.marginvalue,
      this.visibile = true,
      this.onItemtaped,
      this.icontint,
      this.align,
      this.filterqualitiy=FilterQuality.high,
        this.placeholderimage="",
      this.url = ""});

  Widget getImage() {
    Widget? custwidget = null;
    if (!CommonUtils.isHavingvalue(url)) {
      custwidget = Image.asset(
        'assets/$subfolder/$imageName',
        width: width,
        height: height,
        fit: customfit,
      );
    } else {
     /* custwidget= Image.network(
        '$url',
        width: width,
        height: height,
        fit: customfit,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
              child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes
                : null,
          ));
        },
      );*/

     custwidget=CachedNetworkImage(
       height: this.height,
       width: this.width,
       imageUrl: '$url',
       fit: customfit,
       filterQuality: this.filterqualitiy,
       /*placeholder:(context, url)=> Image.asset(
         'assets/$subfolder/$imageName',
         width: width,
         height: height,
         fit: customfit,
       ),*/
       progressIndicatorBuilder: (context, url, downloadProgress) =>
           Center(child:
           SizedBox( width: 30, height: 30, child: CircularProgressIndicator())) ,          // CircularProgressIndicator(value: downloadProgress.progress),
       errorWidget: (context, url, error) => Image.asset(
       CommonUtils.isHavingvalue(placeholderimage)? "assets/images/$placeholderimage": 'assets/images/no_image.webp',
         width: width,
         height: height,
         fit: customfit,
       ),
     );


    }
    if (CommonUtils.isHavingvalue(icontint!)) {
      return ColorFiltered(
          child: custwidget,
          colorFilter: ColorFilter.mode(
              CommonUtils.getColorFromHex(icontint!)!, BlendMode.srcIn));
    } else {
      return custwidget;
    }
  }

  Widget getSVGImage() {
    Widget custwidget = SvgPicture.asset('assets/$subfolder/$imageName',
        width: width, height: height, fit: customfit);
    if (CommonUtils.isHavingvalue(icontint!)) {
      return ColorFiltered(
          child: custwidget,
          colorFilter: ColorFilter.mode(
              CommonUtils.getColorFromHex(icontint!)!, BlendMode.srcIn));
    } else {
      return custwidget;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(" Image svg ${imageName.contains("ic_")}");
    return Visibility(
        visible: visibile,

        child: new GestureDetector(
            onTap: onItemtaped,
            child: Container(
              alignment: align,
                margin: marginvalue,
                child:
                    imageName.contains("ic_") ? getSVGImage() : getImage())));
    //throw UnimplementedError();
  }
}
