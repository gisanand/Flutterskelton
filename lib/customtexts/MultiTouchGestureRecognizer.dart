
import 'package:flutter/gestures.dart';

typedef MultiTouchGestureRecognizerCallback =void Function(bool correctNumberOfTouches);
class MultiTouchGestureRecognizer extends MultiTapGestureRecognizer {
  MultiTouchGestureRecognizerCallback? onMultiTap;
  var numberOfTouches = 0;
  int minNumberOfTouches = 3;

  MultiTouchGestureRecognizer(MultiTouchGestureRecognizerCallback? onMultiTap) {
    this.onMultiTap=onMultiTap;
    super.onTapDown = (pointer, details) => this.addTouch(pointer, details);
    super.onTapUp = (pointer, details) => this.removeTouch(pointer, details);
    super.onTapCancel = (pointer) => this.cancelTouch(pointer);
    super.onTap = (pointer) => this.captureDefaultTap(pointer);
  }

  void addTouch(int pointer, TapDownDetails details) {
    this.numberOfTouches++;
print("touch count $numberOfTouches");
if(numberOfTouches>2) {
  if (this.numberOfTouches == this.minNumberOfTouches) {
    this.onMultiTap!(true);
  }
  else if (this.numberOfTouches != 0) {
    this.onMultiTap!(false);
  }
}
  }

  void removeTouch(int pointer, TapUpDetails details) {
    if (this.numberOfTouches == this.minNumberOfTouches) {
     // this.onMultiTap(true);
    }
    else if (this.numberOfTouches != 0) {
    //  this.onMultiTap(false);
    }

    this.numberOfTouches = 0;
  }

  void cancelTouch(int pointer) {
    this.numberOfTouches = 0;
  }

  void captureDefaultTap(int pointer) {}

  @override
  set onTapDown(_onTapDown) {}

  @override
  set onTapUp(_onTapUp) {}

  @override
  set onTapCancel(_onTapCancel) {}

  @override
  set onTap(_onTap){}




}