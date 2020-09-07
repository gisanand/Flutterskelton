import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySvgImage extends StatelessWidget {
  final String imageName;
  String subfolder;
  double width;
  double height;
  final BoxFit customfit;
  var marginvalue;

  MySvgImage({this.imageName, this.subfolder = "images",this.width,this.height,this.customfit,this.marginvalue});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container( margin: marginvalue,child:Image.asset('assets/$subfolder/$imageName',width: width,height: height,fit: customfit,));
    throw UnimplementedError();
  }
}
