import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeletonapp/utils/StatefulWrapper.dart';
typedef listanimationcotroller = IndexedWidgetBuilder Function(AnimationController controller);

class AppListview extends StatefulWidget {
  int count=0;
  listanimationcotroller? listchildfun;
  Axis scrolldirection;

  AppListview({this.count=0, this.listchildfun, this.scrolldirection=Axis.vertical});

  @override
  _AppListviewState createState() => _AppListviewState();
}

class _AppListviewState extends State<AppListview> with TickerProviderStateMixin{
  Animation<dynamic>? mainScreenAnimation;
  AnimationController? animationController;
  AnimationController? tileanimationController;

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tileanimationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    mainScreenAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController!,
            curve: Interval((1 / widget.count) * 3, 1.0,
                curve: Curves.fastOutSlowIn)));

    animationController!.addStatusListener((status) {
      print("  Animation Controller status $status");
    });
    tileanimationController!.addStatusListener((status) {
      print("  tileanimationController Controller status $status");
      if(status==AnimationStatus.completed)
      {
        setState(() {

        });
      }
    });
    super.initState();
    animationController?.forward();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController!.dispose();
    tileanimationController!.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AppListview oldWidget) {
    super.didUpdateWidget(oldWidget);
    /*animationController!.dispose();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    mainScreenAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController!,
            curve: Interval((1 / widget.count) * 3, 1.0,
                curve: Curves.fastOutSlowIn)));

    animationController!.addStatusListener((status) {
      print("  Animation Controller status $status");
    });*/

  }

  @override
  Widget build(BuildContext context) {
    return  AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext? context, Widget? child) {
        return FadeTransition(
          opacity: mainScreenAnimation as Animation<double>,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - mainScreenAnimation!.value), 0.0),
            child: Container(
              child:  StatefulWrapper(
                  onInit: (){
                    print("widget completed in stateless widget");
                    if(animationController!=null)
                    {
                      animationController?.forward();
                      print("animation controller Not nulll ${animationController!.status}");
                      if(animationController!.isCompleted || animationController!.status != AnimationStatus.forward){
                        animationController?.dispose();
                        print("animation1 controller dispose is :  ${animationController!.status}");

                      }


                    }else{
                      if(animationController!.isCompleted || animationController!.status != AnimationStatus.forward){
                        animationController!.dispose();
                        print("animation controller dispose is :  ${animationController!.status}");

                      }
                      print("animation controller nulll");
                    }
                  },
                  child: ListView.builder(
                    scrollDirection: widget.scrolldirection,
                      physics: tileanimationController!.status != AnimationStatus.forward ? ScrollPhysics() : NeverScrollableScrollPhysics(),
                      itemCount: widget.count,
                      itemBuilder: widget.listchildfun!(tileanimationController!))


              ),
            ),
          ),
        );
      },
    );

    //return this.listchild!!;
  }
}