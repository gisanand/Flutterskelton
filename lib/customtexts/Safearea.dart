import 'package:flutter/cupertino.dart';

class Customsafearea extends StatelessWidget {
  var widget;
  Customsafearea({this.widget});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        left: true,
        right: true,
        child: widget


    );
  }
}
