import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_skeletonapp/customtexts/CustomText.dart';
import 'package:flutter_skeletonapp/customtexts/MyAssetImage.dart';
import 'package:flutter_skeletonapp/customtexts/colorstring.dart';
import 'package:flutter_skeletonapp/customtexts/dimension.dart';
import 'package:flutter_skeletonapp/utils/CommonUtils.dart';

void main() => runApp(AnimatedContainerApp());

class AnimatedContainerApp extends StatefulWidget {
  @override
  _AnimatedContainerAppState createState() => _AnimatedContainerAppState();
}

class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
  // Define the various properties with default values. Update these properties
  // when the user taps a FloatingActionButton.
  double _height = 100;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.only(topLeft: Radius.circular(80.0),topRight: Radius.circular(80.0),);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('AnimatedContainer Demo'),
        ),
        body: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(

alignment: Alignment.bottomCenter,
child:Column(children: [ Expanded(
  child: Align(

    alignment: Alignment.topCenter,
    child: MyAssetImage(imageName: "placeholder.webp",width: 70,height: 70,),
  ),
)
  ,Expanded(
  child: Align(
    alignment: Alignment.bottomCenter,
    child: CustomText(text: "Test Text\nTest Text",familytype: 1,textcolor: CommonUtils.getColorFromHex(Colorstring.white),textsize: Dimension.textSmall,),
  ),
),],),
            // Use the properties stored in the State class.
            width: 80,
            height: _height,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: _borderRadius,
            ),
            // Define how long the animation should take.
            duration: Duration(seconds: 5),
            // Provide an optional curve to make the animation feel smoother.
            curve: Curves.fastOutSlowIn,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow),
          // When the user taps the button
          onPressed: () {
            // Use setState to rebuild the widget with new values.
            setState(() {
              // Create a random number generator.
              final random = Random();

              // Generate a random width and height.
             // _width = random.nextInt(300).toDouble();
             // _width =200;
              //_height = random.nextInt(300).toDouble();
              _height=_height+250;
              // Generate a random color.
              _color = Color.fromRGBO(
                random.nextInt(256),
                random.nextInt(256),
                random.nextInt(256),
                1,
              );

              // Generate a random border radius.
             // _borderRadius =BorderRadius.circular(random.nextInt(100).toDouble());
              _borderRadius =BorderRadius.only(topLeft: Radius.circular(80.0),topRight: Radius.circular(80.0),);
            });
          },
        ),
      ),
    );
  }
}