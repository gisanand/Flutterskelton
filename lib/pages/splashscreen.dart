import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_skeletonapp/applistview/AppListview.dart';
import 'package:flutter_skeletonapp/applistview/applistviewtile.dart';
import 'package:flutter_skeletonapp/basepackage/baseclass.dart';
import 'package:flutter_skeletonapp/basepackage/basestate.dart';
import 'package:flutter_skeletonapp/basepackage/fcm_preferance.dart';
import 'package:flutter_skeletonapp/basepackage/user_preferences.dart';
import 'package:flutter_skeletonapp/constants/StringConstants.dart';
import 'package:flutter_skeletonapp/custom_drawer/drawer_user_controller.dart';
import 'package:flutter_skeletonapp/custom_drawer/home_drawer.dart';
import 'package:flutter_skeletonapp/customtexts/AswomeDrawer.dart';
import 'package:flutter_skeletonapp/customtexts/CustomText.dart';
import 'package:flutter_skeletonapp/customtexts/colorstring.dart';
import 'package:flutter_skeletonapp/customtexts/customdropdownboxadded.dart';
import 'package:flutter_skeletonapp/customtexts/dimension.dart';
import 'package:flutter_skeletonapp/utils/CommonUtils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_core/firebase_core.dart';

class Splashscreen extends BasePage
{
  SplashState createState() => SplashState();


}
class SplashState extends State<Splashscreen> with baseclass , TickerProviderStateMixin {
String? updatvalues;
DrawerIndex currentscreenindex=DrawerIndex.HOME;

MenuListItem? seletedcondition;
List<AwsomeMenuListItem>_conditiondropdown2 = [];
List<MenuListItem>_conditiondropdown = [];
String conditionerror = "";

bool _isBackPressedOrTouchedOutSide = false,
    _isDropDownOpened = false,
    _isPanDown = false;
String _selectedItem = 'Please select';
  @override
  Widget build(BuildContext context) {

    print( "Deviceratio ${MediaQuery.of(context).devicePixelRatio}");
    // TODO: implement build
    //var shortestSide = MediaQuery.of(context).size.shortestSide;
    //var useMobileLayout = shortestSide < 600;



    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
   /* ScreenUtil.init(context,
        width: screenwidth, height: screenheight, allowFontScaling: true);*/

    return Scaffold(
body: DrawerUserController(
  screenIndex: currentscreenindex,
  drawerWidth: MediaQuery.of(context).size.width * 0.75,
  onDrawerCall: (DrawerIndex drawerIndexdata) {
    setState(() {
      currentscreenindex=drawerIndexdata;
    });
    //changeIndex(drawerIndexdata);
    //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
  },
  screenView: GestureDetector(
    onTap: (){
      setState(() {
        _isBackPressedOrTouchedOutSide = true;
        FocusScope.of(context).requestFocus(FocusNode());
      });


    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: getHeight(context),
      color: currentscreenindex==DrawerIndex.HOME? Colors.blue:currentscreenindex==DrawerIndex.Help?Colors.green:Colors.purple,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownBelow(
            paddingtopWidth: 10,
            paddingbottomWidth: 10,
            errormessage: conditionerror,
            selectedtextcolor:Colorstring.white,
            itemWidth: MediaQuery.of(context).size.width * 0.90,
            textcolor: Colorstring.white,
            onclickdropdown: true,
            boxTextstyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
            boxPadding: EdgeInsets.fromLTRB(13, 12, 0, 12),
            boxWidth: MediaQuery.of(context).size.width * 0.90,
            circularWidth: 10,
            dropdownbgcolor: Colorstring.black,
            icondata: Icons.keyboard_arrow_down_outlined,
            iconcolor: Colors.white,
            iconrightpadding: 20,
            boxHeight: 55,
            hint: Text("select the condition"),
            value: seletedcondition,
            items: _conditiondropdown,
            onChanged: (values) {
              print(values);
              setState(() {
                //if(seletedcondition==null||"${seletedcondition.id}" !=values.id) {
                  seletedcondition = values;
                  conditionerror = "";

              });
            },
          ),
          AwesomeDropDown(
            numOfListItemToShow: 5,
            isPanDown: _isPanDown,
            dropDownList: _conditiondropdown2,
            isBackPressedOrTouchedOutSide: _isBackPressedOrTouchedOutSide,
            selectedItem: _selectedItem,
            onDropDownItemClick: (selectedItem) {
              _selectedItem = selectedItem;
            },
            dropStateChanged: (isOpened) {
              _isDropDownOpened = isOpened;
              if (!isOpened) {
                _isBackPressedOrTouchedOutSide = false;
              }
            },
          ),

        ],
      ),

    ),
  ),
  //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
),
      /*body: Container(
        color: Colors.white,
      child: AppListview(
        count:10, listchildfun:(AnimationController tilecontroller){
          return (context,index){
            return  applistviewtile.initlistviewtile(10, index, Container(
              width: 50,height: 100,
              child:Card(
                child: Container(
                  margin: EdgeInsets.all(15),
                  width: 50,height: 100,
                  color: Colors.green,
                ),
              ),
            ), tilecontroller);
          };
      },scrolldirection: Axis.vertical,
      )
      ),*/
    );
  }

  @override
  void initState() {
    super.initState();
    _conditiondropdown.add(MenuListItem("new", "New"));
    _conditiondropdown.add(MenuListItem("mint", "Mint"));
    _conditiondropdown.add(MenuListItem("used", "Used"));
    _conditiondropdown.add(MenuListItem("fair", "Fair"));
    _conditiondropdown.add(MenuListItem("worn", "Worn"));
    _conditiondropdown2.add(AwsomeMenuListItem("new", "New"));
    _conditiondropdown2.add(AwsomeMenuListItem("mint", "Mint"));
    _conditiondropdown2.add(AwsomeMenuListItem("used", "Used"));
    _conditiondropdown2.add(AwsomeMenuListItem("fair", "Fair"));
    _conditiondropdown2.add(AwsomeMenuListItem("worn", "Worn"));
    _conditiondropdown2.add(AwsomeMenuListItem("good", "good"));
      startTime();


    // ignore: unnecessary_statements
    //  Firebase.initializeApp().then((value) {
    // intisharedvalues().then((values){
    //   /*setState(() {
    //     updatvalues=loaddata("test", 1);
    //   });
    //   savedata("test", "updatvalues");*/
    //   startTime();
    // });
    //  });
  }
startTime() async {
  var duration = new Duration(seconds: 3);
  return new Timer(duration, route);
}
route() {
     /* Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => HomeDrawer(callBackIndex: (value){
            print("Selected navigate index values $value");
          },)
      )
      );*/
     // navigateScreen();

}

void navigateScreen()
{
}
   intisharedvalues()async
  {
    WidgetsFlutterBinding.ensureInitialized();
    await Fcmpreferance().init(context);
    await UserPreferences().init();
  }
void navigateNotificationScreen(Map<String, dynamic> message)
{
  //Navigator.pushNamed(context, routeName);
  /*Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => MainScreen(fromnotificationscreen:"1")),
  );
*/
}
}