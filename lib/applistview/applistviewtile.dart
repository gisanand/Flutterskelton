import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeletonapp/utils/StatefulWrapper.dart';

class applistviewtile extends StatelessWidget {
  int position=0;
  int count=0;
  Widget? listchildtile;
  Animation<dynamic>? mainScreenAnimation;
  AnimationController? animationController;

  applistviewtile.initlistviewtile(int totalcount,int position,Widget itemchild,AnimationController? controller) {

    this.count=totalcount;
    this.position=position;
    listchildtile =itemchild;
    animationController = controller;
    animationController!.forward();
    mainScreenAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController!,
            curve: Interval((1 / count) * position, 1.0,
                curve: Curves.fastOutSlowIn)));


  }
  void distroylistivewtile(){
    if(!animationController!.isDismissed) {
      animationController!.dispose();

    }
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext? context, Widget? child) {
        return FadeTransition(
          opacity: mainScreenAnimation as Animation<double>,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - mainScreenAnimation!.value), 0.0, 0.0),
            child:  StatefulWrapper(
                onInit: (){
                  print("widget completed in stateless widget");
                  if(animationController!=null)
                  {

                    print("animation applistviewtile controller Not nulll ${animationController!.status}");

                  }else{
                    print("animation applistviewtile controller nulll");
                  }
                },
                child: listchildtile!
            ),
          ),
        );
      },

    );

  }
}