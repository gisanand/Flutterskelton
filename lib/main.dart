import 'dart:convert';

import 'package:flutter/material.dart';

import 'basepackage/user_preferences.dart';
import 'customtexts/AppStrings.dart';
import 'loginsection/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();
  languestr=jsonDecode(AppStrings.languagejson);
  runApp(App());

}

Map<String, dynamic> languestr=Map();
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: splashscreenpage(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String data;

  @override
  void initState() {
    data =  UserPreferences().loaddata("Anand", 1) as String;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test app'),
      ),
      body: Column(
        children: <Widget>[
          Text(data ?? '', style: TextStyle(fontSize: 33)),
          RaisedButton(
            child: Text('Change data'),
            onPressed: () {
              //  UserPreferences().data = data + 'a';
              UserPreferences().savedata("Anand", (data + 'a'));
              setState(() {
                //data = UserPreferences().data;
                data = UserPreferences().loaddata("Anand", 1) as String;
              });
            },
          )
        ],
      ),
    );
  }
}
