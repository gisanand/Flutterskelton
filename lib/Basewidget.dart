import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapiapp/network/Apicallback.dart';
import 'package:load/load.dart';
bool loading=true;
class  BasePage extends StatefulWidget  {
  final  _LoaderState loadstate=null;
  final String title;
  final bool showloader=false;

  BasePage({Key key, this.title}) : super(key: key);
  /*@override
  State<StatefulWidget> createState() {

    return _LoaderState();
  }*/

  @override
  State<BasePage> createState() => LoaderState();
}



Widget sholoader(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("LinearProgressIndicator"),
    ),
    body: Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child:loading
            ? LinearProgressIndicator()
            : Text("Press button to download"),
      ),
    ),
  );
}

class _LoaderState extends State<BasePage>  {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("LinearProgressIndicator"),
          actions: <Widget>[

            buildCustomLoadingButton(),

          ]
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child:loading
              ? LinearProgressIndicator()
              : Text("Press button to download"),
        ),
      ),
    );
  }

  Widget buildCustomLoadingButton() {
    return IconButton(
      icon: Icon(Icons.cloud_download),
      onPressed: () {
        showCustomLoadingWidget(
          Center(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  LinearProgressIndicator(),
                  Container(
                    height: 10,
                  ),
                  Text("loading"),
                ],
              ),
            ),
          ),
          tapDismiss: false,
        );
      },
    );
  }

}




class LoaderState extends State<BasePage> {

  bool _loadingInProgress;

  @override
  void initState() {
    super.initState();
    _loadingInProgress = true;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Custom Loading Animation example"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loadingInProgress) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new Center (
        child: new Text('Data loaded'),
      );
    }
  }

}