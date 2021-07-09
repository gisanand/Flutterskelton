import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../basepackage/baseclass.dart';
import 'CustomText.dart';
import 'dimension.dart';

class NoDatatextfound extends StatelessWidget with baseclass {
  String text="";

  NoDatatextfound({this.text=""});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Container(alignment: Alignment.center,child: CustomText(align: Alignment.center,textalign: TextAlign.center,text: text ,familytype: 1,textcolor: Colors.black,textsize: Dimension.text_medium,),);
  }

}