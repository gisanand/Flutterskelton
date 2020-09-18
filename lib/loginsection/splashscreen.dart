import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_appskeleton/basepackage/user_preferences.dart';
import 'package:flutter_appskeleton/customtexts/CustomText.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_appskeleton/basepackage/custom_theme.dart';
import 'package:flutter_appskeleton/constants/StringConstants.dart';
import 'package:flutter_appskeleton/customtexts/MyAssetImage.dart';
import 'package:flutter_appskeleton/customtexts/RoundButton.dart';
import 'package:flutter_appskeleton/customtexts/AppStrings.dart';
import 'package:flutter_appskeleton/customtexts/colorstring.dart';
import 'package:flutter_appskeleton/customtexts/dimension.dart';
import 'package:flutter_appskeleton/utils/StatefulWrapper.dart';
import 'package:flutter_appskeleton/utils/CommonUtils.dart';
import 'package:flutter_appskeleton/utils/resumable_state.dart';
import 'package:flutter_appskeleton/basepackage/baseclass.dart';

class splashscreenpage extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends ResumableState<splashscreenpage> with baseclass {
  bool alreadylogin = false;

  void onitemselected() {
    print("text clicked");
  }
void initprefrance()async
{
 // SharedPreferences.setMockInitialValues;


}
@override
  void initState() {
    super.initState();
    initprefrance();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkloginstatus);
  }

  void onitemLoginselected() {
    print("onitemLoginselected clicked");

   /* Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Loginscreen()),
    );*/
  }

  void checkloginstatus() {
    setState(() {
      if (isHavingvalue(
          "${loaddata(StringConstants.PREF_TOKEN, 1)}")) {
        alreadylogin = true;
      } else {
        alreadylogin = false;
      }
    });
  }

  void onitemgetstartedselected() {
    print("onitemgetstartedselected clicked");
    print(
        "Load Shared data  token from prefrance ${loaddata(StringConstants.PREF_TOKEN, 1)}");
    if (isHavingvalue("${loaddata(StringConstants.PREF_TOKEN, 1)}")) {
      if (isHavingvalue(
          "${loaddata(StringConstants.PREF_ACHIVEID, 1)}")) {
       /* Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );*/
      } else {
        /*Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => intrestlistscreen()),
        );*/
      }
    } else {
     /* Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Getstartedscreen()),
      );*/
    }
  }

  void termsclicked() {
    print("termsclicked clicked");
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    ScreenUtil.init(context,
        width: screenwidth, height: screenheight, allowFontScaling: true);
    return MaterialApp(builder: (context, child) {
      return MediaQuery(
        child: Container(
            color: Colors.white,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(children: <Widget>[
                new Flexible(
                  child: MyAssetImage(
                    imageName: "intoimage.webp",
                    width: MediaQuery.of(context).size.width,
                    customfit: BoxFit.fill,
                  ),
                  flex: 1,
                ),
                new Flexible(
                  child: Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                          padding: const EdgeInsets.all(0.0),
                          child: Center(
                              child: Column(
                            children: <Widget>[
                             /* logoui(
                                maringvalues:
                                    EdgeInsets.only(top: 15, bottom: 10),
                              ),*/
                              Visibility(
                                child: Roundtext(
                                    startcolor: "#8CC67E",
                                    endcolor: "#39B59D",
                                    roundradius: 40,
                                    blurRadius: 20,
                                    width: 300,
                                    height: 50,
                                    marginvalue: EdgeInsets.only(top: 15),
                                    textchild: CustomText(
                                      text: "Login now",
                                      textcolor: Colors.white,
                                      textalign: TextAlign.center,
                                      textsize: ScreenUtil()
                                          .setSp(dimension.text_large),
                                      familytype: 2,
                                    ),
                                    onItemtabed: onitemLoginselected),
                                visible: !alreadylogin,
                              ),
                              Visibility(
                                child: Row(children: <Widget>[
                                  Expanded(child: Divider()),
                                  Container(
                                      margin:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      color: Colors.white,
                                      child: CustomText(
                                        onItemtaped: onitemselected,
                                        text: "OR",
                                        textcolor: Colors.black,
                                        textalign: TextAlign.center,
                                        textsize: ScreenUtil()
                                            .setSp(dimension.text_large),
                                        familytype: 1,
                                      )),
                                  Expanded(child: Divider()),
                                ]),
                                visible: !alreadylogin,
                              ),
                              Roundtext(
                                  onItemtabed: onitemgetstartedselected,
                                  startcolor: "#8CC67E",
                                  endcolor: "#39B59D",
                                  roundradius: 40,
                                  blurRadius: 20,
                                  width: 300,
                                  height: 50,
                                  marginvalue: EdgeInsets.only(top: 5),
                                  textchild: CustomText(
                                    onItemtaped: onitemselected,
                                    text: "Get Started",
                                    textcolor: Colors.white,
                                    textalign: TextAlign.center,
                                    textsize: 15,
                                    familytype: 2,
                                  )),
                              CustomText(
                                marginvalue:
                                    EdgeInsets.only(top: 20, bottom: 10),
                                onItemtaped: onitemselected,
                                text: "${getStringName("privacytext")}",
                                textcolor: Colors.black,
                                textalign: TextAlign.center,
                                textsize:
                                    ScreenUtil().setSp(dimension.text_medium),
                                familytype: 1,
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 15),
                                child: new GestureDetector(
                                    onTap: termsclicked,
                                    child: Text.rich(
                                      TextSpan(
                                        text: '',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Reguler'),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'Terms of Service',
                                              style: TextStyle(
                                                fontSize: ScreenUtil().setSp(
                                                    dimension.text_medium),
                                                fontFamily: 'Reguler',
                                                decoration:
                                                    TextDecoration.underline,
                                              )),
                                          TextSpan(
                                              text: ' and ',
                                              style: TextStyle(
                                                  fontSize: ScreenUtil().setSp(
                                                      dimension.text_medium),
                                                  fontFamily: 'Reguler')),
                                          TextSpan(
                                              text: 'Privacy Policy.',
                                              style: TextStyle(
                                                fontSize: ScreenUtil().setSp(
                                                    dimension.text_medium),
                                                fontFamily: 'Reguler',
                                                decoration:
                                                    TextDecoration.underline,
                                              )),
                                          // can add more TextSpans here...
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          )))),
                  flex: 2,
                ),
              ]),
              bottomNavigationBar: BottomAppBar(
                  color: getColorFromHex(colorstring.screenbg),
                  child: Wrap(
                    children: <Widget>[
                      Center(
                        child: CustomText(
                          text: getStringName("rights"),
                          familytype: 1,
                          textsize: dimension.text_small,
                          marginvalue:
                              EdgeInsets.all(dimension.margin_extra_very_small),
                        ),
                      ),
                      Center(
                        child: CustomText(
                          text: getStringName("rightslocation"),
                          familytype: 1,
                          textsize: dimension.text_small,
                          marginvalue:
                              EdgeInsets.all(dimension.margin_extra_very_small),
                        ),
                      ),
                    ],
                  )),
            )),
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      );
    });

    throw UnimplementedError();
  }

//
}
