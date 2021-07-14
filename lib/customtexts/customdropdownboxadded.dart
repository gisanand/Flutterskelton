library dropdown_below;

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_skeletonapp/basepackage/baseclass.dart';
import 'package:flutter_skeletonapp/basepackage/basestate.dart';
import 'package:flutter_skeletonapp/customtexts/CustomText.dart';
import 'package:flutter_skeletonapp/customtexts/colorstring.dart';
import 'package:flutter_skeletonapp/customtexts/dimension.dart';
import 'package:flutter_skeletonapp/utils/CommonUtils.dart';

import 'Toast.dart';


const Duration _kDropdownMenuDuration = Duration(milliseconds: 300);
/// *[_kDropdownMenuDuration] which is dropdown button's drop down duration.

const double _kMenuItemHeight = 48.0;
/// *[_kMenuItemHeight] which is dropdown item's default height

const EdgeInsets _kMenuItemPadding = EdgeInsets.symmetric(horizontal: 16.0);
/// *[_kMenuItemPadding] which is dropdown item's default padding.

const EdgeInsets _kAlignedMenuMargin = EdgeInsets.zero;
/// *[_kAlignedMenuMargin] which is dropdown item's default margin
const EdgeInsetsGeometry _kUnalignedMenuMargin =
EdgeInsetsDirectional.only(start: 16.0, end: 24.0);
/// *[_kAlignedMenuMargin] which is dropdown item's default margin for align rule.


class _DropdownMenuPainter extends CustomPainter {
  _DropdownMenuPainter({
    this.color,
    this.elevation,
    this.selectedIndex,
    this.resize,
  })  : _painter = new BoxDecoration(
      color: color,
      borderRadius: new BorderRadius.circular(5),
      boxShadow: kElevationToShadow[elevation])
      .createBoxPainter(),
        super(repaint: resize);

  final Color? color;
  /// *[color] which is dropdown item's background color
  final int? elevation;
  /// *[elevation] which is dropdown whole item list's elevation
  final int? selectedIndex;
  /// *[selectedIndex] which is selected item's index

  final Animation<double>? resize;
  /// *[resize] which is resized animation value
  final BoxPainter _painter;
  /// *[_painter] which is panting value

  @override
  void paint(Canvas canvas, Size size) {
    final double selectedItemOffset =
        selectedIndex! * _kMenuItemHeight + kMaterialListPadding.top;
    final Tween<double> top = new Tween<double>(
      begin: selectedItemOffset.clamp(0.0, size.height - _kMenuItemHeight),
      end: 0.0,
    );

    final Tween<double> bottom = new Tween<double>(
      begin:
      (top.begin! + _kMenuItemHeight).clamp(_kMenuItemHeight, size.height),
      end: size.height,
    );

    final Rect rect = new Rect.fromLTRB(
        0.0, top.evaluate(resize!), size.width, bottom.evaluate(resize!));

    _painter.paint(
        canvas, rect.topLeft, new ImageConfiguration(size: rect.size));
  }

  @override
  bool shouldRepaint(_DropdownMenuPainter oldPainter) {
    return oldPainter.color != color ||
        oldPainter.elevation != elevation ||
        oldPainter.selectedIndex != selectedIndex ||
        oldPainter.resize != resize;
  }
}


class _DropdownScrollBehavior extends ScrollBehavior {
  const _DropdownScrollBehavior();

  @override
  TargetPlatform getPlatform(BuildContext context) =>
      Theme.of(context).platform;

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) =>
      child;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}

class _DropdownMenu<T> extends StatefulWidget {
  const _DropdownMenu({
    Key? key,
    this.padding = const EdgeInsets.all(0.0),
    this.route,
    this.height,
  }) : super(key: key);

  final _DropdownRoute<T>? route;
  /// flutter's dropdown is same as go to new route.
  /// So *[route] means setting new route

  final double? height;
  final EdgeInsets padding; /// padding.


  @override
  _DropdownMenuState<T> createState() => new _DropdownMenuState<T>();
}

class _DropdownMenuState<T> extends State<_DropdownMenu<T>> {
  late CurvedAnimation _fadeOpacity;
  late CurvedAnimation _resize;

  @override
  void initState() {
    super.initState();
    _fadeOpacity = new CurvedAnimation(
      parent: widget.route!.animation!,
      curve: const Interval(0.0, 0.25),
      reverseCurve: const Interval(0.75, 1.0),
    );
    _resize = new CurvedAnimation(
      parent: widget.route!.animation!,
      curve: const Interval(0.25, 0.5),
      reverseCurve: const Threshold(0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
    MaterialLocalizations.of(context);
    final _DropdownRoute<T> route = widget.route!;
    final double unit = 0.5 / (route.items!.length + 1.5);
    final List<Widget> children = <Widget>[];
    for (int itemIndex = 0; itemIndex < route.items!.length; ++itemIndex) {
      CurvedAnimation opacity;
      if (itemIndex == route.selectedIndex) {
        opacity = new CurvedAnimation(
            parent: route.animation!, curve: const Threshold(0.0));
      } else {
        final double start = (0.5 + (itemIndex + 1) * unit).clamp(0.0, 1.0);
        final double end = (start + 1.5 * unit).clamp(0.0, 1.0);
        opacity = new CurvedAnimation(
            parent: route.animation!, curve: new Interval(start, end));
      }
      children.add(new FadeTransition(
        opacity: opacity,
        child: new InkWell(
          child: new Container(
            color: CommonUtils.getColorFromHex(route.dropdownbgcolor!),
            padding: widget.padding,
            child:CustomText(
              text:  route.items![itemIndex].name,
              familytype: 2,
              textcolor: CommonUtils.getColorFromHex(route.textcolor!),
              textsize: Dimension.text_medium,
            ),
          ),
          onTap: () => Navigator.pop(
            context,
            new _DropdownRouteResult<MenuListItem>(route.items![itemIndex]),
          ),
        ),
      ));
    }
print("widget height ${widget.height}");
    return new FadeTransition(
      opacity: _fadeOpacity,
      child: new CustomPaint(
        painter: new _DropdownMenuPainter(
          color: CommonUtils.getColorFromHex(route.dropdownbgcolor!)!,
          elevation: 2,
          selectedIndex: route.selectedIndex!,
          resize: _resize,
        ),
        child: new Semantics(
          scopesRoute: true,
          namesRoute: true,
          explicitChildNodes: true,
          label: localizations.popupMenuLabel,
          child: new Material(
            type: MaterialType.transparency,
            textStyle: route.style,
            child: new ScrollConfiguration(
              behavior: const _DropdownScrollBehavior(),
              child: new Scrollbar(
                child: Container(
                  height: widget.height,
                  child: new ListView(
                    controller: widget.route!.scrollController,
                    padding: kMaterialListPadding,
                    itemExtent: _kMenuItemHeight,
                    shrinkWrap: true,
                    children: children,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DropdownMenuRouteLayout<T> extends SingleChildLayoutDelegate {
  _DropdownMenuRouteLayout({
    @required this.buttonRect,
    @required this.menuTop,
    @required this.menuHeight,
    @required this.textDirection,
    @required this.itemWidth,
  });

  final double? itemWidth;
  /// dropdown button's each item's width
  final Rect? buttonRect;
  /// dropdown button's whole list rect.
  final double? menuTop;
  final double? menuHeight;
  final TextDirection? textDirection;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final double maxHeight =
    math.max(0.0, constraints.maxHeight - 2 * _kMenuItemHeight);
    return new BoxConstraints(
      minWidth: itemWidth!,
      maxWidth: itemWidth!,
      minHeight: 0.0,
      maxHeight: maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    assert(() {
      final Rect container = Offset.zero & size;
      if (container.intersect(buttonRect!) == buttonRect) {
        assert(menuTop! >= 0.0);
        //assert(menuTop + menuHeight <= size.height);
      }
      return true;
    }());
    assert(textDirection != null);
    double? left;
    switch (textDirection) {
      case TextDirection.rtl:
        left = buttonRect!.right.clamp(0.0, size.width) - childSize.width;
        break;
      case TextDirection.ltr:
        left = buttonRect!.left.clamp(0.0, size.width - childSize.width);
        break;
    }
    return new Offset(left!+15, menuTop!+13);
  }

  @override
  bool shouldRelayout(_DropdownMenuRouteLayout<T> oldDelegate) {
    return buttonRect != oldDelegate.buttonRect ||
        menuTop != oldDelegate.menuTop ||
        menuHeight != oldDelegate.menuHeight ||
        textDirection != oldDelegate.textDirection;
  }
}

class _DropdownRouteResult<T> {
  const _DropdownRouteResult(this.result);

  final MenuListItem result;

  @override
  bool operator ==(dynamic other) {
    if (other is! _DropdownRouteResult<T>) return false;
    final _DropdownRouteResult<T> typedOther = other;
    return result == typedOther.result;
  }

  @override
  int get hashCode => result.hashCode;
}

class _DropdownRoute<T> extends PopupRoute<_DropdownRouteResult<T>> {
  _DropdownRoute({
    this.items,
    this.itemWidth,
    this.padding,
    this.buttonRect,
    this.selectedIndex,
    this.elevation = 8,
    this.theme,
    this.scrollController,
    this.textcolor="${Colorstring.white}",
    this.dropdownbgcolor="${Colorstring.white}",
    @required this.style,
    this.barrierLabel,
  }) : assert(style != null);

  final List<MenuListItem>? items;
  /// item's list
  final EdgeInsetsGeometry? padding;

  final Rect? buttonRect;
  /// buttons rectangle
  final int? selectedIndex;
  /// selected Index
  final int? elevation;
  final ThemeData? theme;
  final TextStyle? style;
String? textcolor;
String? dropdownbgcolor="${Colorstring.white}";
  ScrollController?  scrollController;

  @override
  Duration get transitionDuration => _kDropdownMenuDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color? get barrierColor => Colors.red;

  @override
  final String? barrierLabel;

  final double? itemWidth;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    assert(debugCheckHasDirectionality(context));
    final double screenHeight = MediaQuery.of(context).size.height;
    final double maxMenuHeight = screenHeight - 2.0 * _kMenuItemHeight;
    final double preferredMenuHeight =
        (items!.length * _kMenuItemHeight) + kMaterialListPadding.vertical;
    final double menuHeight = math.min(maxMenuHeight, preferredMenuHeight);

    final double buttonTop = buttonRect!.top + 10;
    final double selectedItemOffset =
        selectedIndex! * _kMenuItemHeight + kMaterialListPadding.top;
    double menuTop = (buttonTop - selectedItemOffset) -
        (_kMenuItemHeight - buttonRect!.height) / 8.0;
    const double topPreferredLimit = _kMenuItemHeight;
    if (menuTop < topPreferredLimit)
      menuTop = math.min(buttonTop, topPreferredLimit);
    double bottom = menuTop + menuHeight ;

    final double bottomPreferredLimit = screenHeight - _kMenuItemHeight ;
    print("menutop = $menuTop , menuheight = $menuHeight , bottom = $bottom , bottomperferredlimit = $bottomPreferredLimit , _kmenuitemheight = $_kMenuItemHeight");



    if (bottom > bottomPreferredLimit) {
      bottom = math.max(buttonTop + _kMenuItemHeight, (bottomPreferredLimit));
     // menuTop = bottom - menuHeight + 200;
      print("the value  second bottom is  : $bottom");

    }

    if (scrollController == null) {
      double scrollOffset = 0.0;
      if (preferredMenuHeight > maxMenuHeight)
        scrollOffset = selectedItemOffset - (buttonTop - menuTop);
      scrollController =
      new ScrollController(initialScrollOffset: scrollOffset);
    }

    final TextDirection textDirection = Directionality.of(context);
    Widget menu = new _DropdownMenu<T>(
      route: this,
      padding: padding!.resolve(textDirection),
      height:  (items!.length<=10)? (items!.length * _kMenuItemHeight):(10 * _kMenuItemHeight),
      //height:   (bottom > bottomPreferredLimit)?null:(screenHeight-buttonTop),
    );

    if (theme != null) menu = new Theme(data: (theme)!, child: menu);

    return new MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: new Builder(
        builder: (BuildContext context) {
          return new CustomSingleChildLayout(
            delegate: new _DropdownMenuRouteLayout<T>(
              itemWidth:itemWidth! +5,
              buttonRect: buttonRect,
              menuTop: menuTop,
              menuHeight: menuHeight,
              textDirection: textDirection,
            ),
            child: menu,
          );
        },
      ),
    );
  }

  void _dismiss() {
    navigator?.removeRoute(this);
  }
}
typedef calleventback = void Function(callback);

class DropdownBelow<T> extends StatefulWidget {
  DropdownBelow({
    Key? key,
    @required this.items,
    this.value,
    this.hint,
    this.itemTextstyle,
    this.itemWidth,
    this.boxHeight,
    this.boxWidth,
    this.circularWidth,
    this.icondata,
    this.iconcolor,
    this.containercolor=Colors.white,
    this.paddingbottomWidth=0.0,
    this.paddingtopWidth=0.0,
    this.iconrightpadding=0.0,
    this.boxPadding,
    this.boxTextstyle,
    @required this.onChanged,
    this.elevation = 8,
    this.style,
    this.iconSize = 24.0,
    this.selectedtextcolor = "${Colorstring.black}",
    this.textcolor = "${Colorstring.black}",
    this.dropdownbgcolor = "${Colorstring.white}",
    this.errormessage = "",
    this.isDense = false,
    this.onclickdropdown = true,
    this.apicalldropdown ,
    this.bottomsheet = false,

  });  /*:assert(value == null ||
      items.where((MenuListItem item) => (item.id == value.id))
          .length ==
          1),
        super(key: key);*/
  final List<MenuListItem>? items;
  /// item list
  final MenuListItem? value;
  /// printed value
  final double? itemWidth;
  final double? paddingtopWidth;
  final double? paddingbottomWidth;
  /// each item width
  final double? boxHeight;
  /// whole box height
  final double? boxWidth;
  /// whole box width
  final double? circularWidth;
  /// whole box circularwidth
  final IconData? icondata;
  final Color? iconcolor;
  final Color? containercolor;
  final double? iconrightpadding;

  /// whole box icon

  final EdgeInsetsGeometry? boxPadding;
  /// default box padding
  final TextStyle? boxTextstyle;
  /// default box text style
  final TextStyle? itemTextstyle;
  /// default each item's text style
  final Widget? hint;
  /// default value that printed which has no touch to dropdown widget.
  final ValueChanged<MenuListItem>? onChanged;
  /// click item then, function triggered
  final int? elevation;
  final TextStyle? style;
  final double iconSize;
  /// if you use icon this value designate icon size
  final bool isDense;
  final bool onclickdropdown;
  final calleventback? apicalldropdown;
  final bool bottomsheet;
  final String textcolor;
  final String selectedtextcolor;
  final String errormessage;
  final dropdownbgcolor;

  List<DropdownMenuItem<T>>? selectionitems;
  @override
  _DropdownBelowState<T> createState() => new _DropdownBelowState<T>();
  void tapeventcalled(){
    print("tapeventcalled  test values");
    //createState().handleTap();
  }
}


class _DropdownBelowState<T> extends State<DropdownBelow<T>>
    with WidgetsBindingObserver {


   int? _selectedIndex;
   _DropdownRoute<T>? _dropdownRoute;

  @override
  void initState() {
    super.initState();
    _updateSelectedIndex();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _removeDropdownRoute();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    _removeDropdownRoute();
  }

  void _removeDropdownRoute() {
    _dropdownRoute?._dismiss();
    _dropdownRoute = null;
  }

  @override
  void didUpdateWidget(DropdownBelow<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateSelectedIndex();
  }

  void _updateSelectedIndex() {
    if(widget.value!=null) {
      print("defalut values name ${widget.value!.name}");
    bool itemstatus=  widget.items! .where((MenuListItem item) => item.id == widget.value!.id)   .length ==  1;
     /* assert(
      widget.items
          .where((MenuListItem item) => item.id == widget.value.id)
          .length ==
          1);*/
    if(itemstatus){
    _selectedIndex = null;
    if(widget.value!=null){
    for (int itemIndex = 0; itemIndex < widget.items!.length; itemIndex++) {
      if (widget.items![itemIndex].id == widget.value!.id) {
        _selectedIndex = itemIndex;
        return;
      }
      }
    }

  }
  }
  }

  TextStyle? get _textStyle =>
      widget.style ?? Theme.of(context).textTheme.subtitle1;
  void _showToast(BuildContext context , int mode) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: new Duration(milliseconds: 3000),
        content:  CustomText(
            text:mode == 1 ? ('No Data found for the selected values.Please select/change the above values.'):"Sorry!. You can't able to change the value.",
        ),
        action: SnackBarAction(
            label: 'OK', onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar),
      ),
    );
  }
  void _shownormalToast(BuildContext context , int mode) {
     Toast.show("No Data found for the selected values.Please select/change the above values.", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }
callback rethandelcallback(){
    callback returncallback=(){
      handleTap();
    };
    return returncallback;
}

  void handleTap() {

print("on handle tap down call values ");
    if(widget.onclickdropdown == false)
    {
      _showToast(context , 2);

      return;
    }
    if(widget.items!.length==0 )
      {
        /*if(widget.bottomsheet == true) {
          _shownormalToast(context,1);
          return;

        }
        else{
          _showToast(context, 1);
          return;
        }*/
        if(widget.apicalldropdown!=null){
          widget.apicalldropdown!(rethandelcallback());

        }

        if(widget.bottomsheet == true) {
          return;

        }
        else{
          return;
        }
      }




      final RenderBox itemBox = context.findRenderObject() as RenderBox;
    final Rect itemRect = itemBox.localToGlobal(Offset.zero) & itemBox.size;
    final TextDirection textDirection = Directionality.of(context);
    final EdgeInsetsGeometry menuMargin =
    ButtonTheme.of(context).alignedDropdown
        ? _kAlignedMenuMargin
        : _kUnalignedMenuMargin;

    assert(_dropdownRoute == null);
    _dropdownRoute = new _DropdownRoute<T>(
      itemWidth:widget.itemWidth,
      items: widget.items,
      buttonRect: menuMargin.resolve(textDirection).inflateRect(itemRect),
      padding: _kMenuItemPadding.resolve(textDirection),
      selectedIndex: -1,
      elevation: widget.elevation,
      theme: Theme.of(context),
      style: _textStyle,
      textcolor: widget.textcolor,
      dropdownbgcolor: widget.dropdownbgcolor,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    );

    Navigator.push(context, _dropdownRoute!)
        .then<void>(
            (_DropdownRouteResult<T>? newValue) {
      _dropdownRoute = null;
      if (!mounted || newValue == null) return;
      if (widget.onChanged != null)  widget.onChanged!(newValue.result);
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    //final List<Widget> items = new List<Widget>.from(widget.items);
    final List<Widget> items = [];
    widget.items!.forEach((element) {

      items.add(

        CustomText(
          text: element.name,
          familytype: 2,
          textcolor: CommonUtils.getColorFromHex(_selectedIndex==null?widget.textcolor:widget.selectedtextcolor),
          textsize: Dimension.text_medium,
          softwrap: true,
        )
      );
    });
    int hintIndex;
    if (widget.hint != null) {
      hintIndex = items.length;
      items.add(new DefaultTextStyle(
        style: widget.boxTextstyle!,
        child: new IgnorePointer(
          child: widget.hint,
          ignoringSemantics: false,
        ),
      ));
    }

    Widget result = new DefaultTextStyle(
      style: widget.boxTextstyle!,
      child: Padding(
        padding:  EdgeInsets.only(top:(widget.paddingtopWidth)! , bottom: (widget.paddingbottomWidth)!),
        child: Container(
          width: widget.boxWidth,
          child: Column(children:[
            new Container(
            decoration: BoxDecoration(
              border: Border.all(color:CommonUtils.isHavingvalue(widget.errormessage)?Colors.red:widget.containercolor!, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(widget.circularWidth!)),
              color: Colors.transparent,
            ),
            padding: widget.boxPadding,
            height: widget.boxHeight,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: new IndexedStack(
                    index: _selectedIndex,
                    alignment: AlignmentDirectional.centerStart,
                    children: items,
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(right:(widget.iconrightpadding)!),
                  child: new Icon(widget.icondata,color:widget.iconcolor,),
                ),
                // new Icon(Icons.arrow_drop_down,
                //     size: widget.iconSize,
                //     color: Color(0XFFbbbbbb)),
              ],
            ),
          ),
            Visibility(
              visible: CommonUtils.isHavingvalue(widget.errormessage),
              child: CustomText(
                marginvalue: EdgeInsets.only(top: 10),
                align: Alignment.centerLeft,
                textalign: TextAlign.left,
                text: "${widget.errormessage}",
                familytype: 2,
                textcolor: CommonUtils.getColorFromHex(Colorstring.emailred),
                textsize: Dimension.text_medium,
                softwrap: true,
              ),
            )
          ]),
        ),
      ),
    );

    if (!DropdownButtonHideUnderline.at(context)) {
      result = new Stack(
        children: <Widget>[
          result,
          new Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0,
            child: new Container(
              height: 0.0,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom:
                      BorderSide(color: Colors.transparent, width: 0))),
            ),
          ),
        ],
      );
    }

    return new Semantics(
      button: true,
      child: new GestureDetector(
          onTap: handleTap, behavior: HitTestBehavior.opaque, child: result),
    );
  }
}

class MenuListItem {
  String name;
  String id;

  MenuListItem(this.id, this.name);
}