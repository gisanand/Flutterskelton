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

  bool visibile = true;

  final BoxFit customfit;

  var marginvalue;

  final callback onItemtaped;

  String icontint;

  String url = "";

  var align;

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

        this.url = ""});



  Widget getImage() {

    Widget custwidget = null;

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

        /*placeholder:(context, url)=> Image.asset(

         'assets/$subfolder/$imageName',

         width: width,

         height: height,

         fit: customfit,

       ),*/

        progressIndicatorBuilder: (context, url, downloadProgress) =>

            CircularProgressIndicator(value: downloadProgress.progress),

        errorWidget: (context, url, error) => Image.asset(

          'assets/images/placeholder.webp',

          width: width,

          height: height,

          fit: customfit,

        ),

      );





    }

    if (CommonUtils.isHavingvalue(icontint)) {

      return ColorFiltered(

          child: custwidget,

          colorFilter: ColorFilter.mode(

              CommonUtils.getColorFromHex(icontint), BlendMode.srcIn));

    } else {

      return custwidget;

    }

  }



  Widget getSVGImage() {

    Widget custwidget = SvgPicture.asset('assets/$subfolder/$imageName',

        width: width, height: height, fit: customfit);

    if (CommonUtils.isHavingvalue(icontint)) {

      return ColorFiltered(

          child: custwidget,

          colorFilter: ColorFilter.mode(

              CommonUtils.getColorFromHex(icontint), BlendMode.srcIn));

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

    throw UnimplementedError();

  }

}