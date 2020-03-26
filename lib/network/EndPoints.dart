import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapiapp/model/BeerListModel.dart';
import 'package:flutterapiapp/network/Apicallback.dart';
import 'package:flutterapiapp/Basewidget.dart' as globals;

// get reponse from API
import 'package:http/http.dart' as http;

// to check internet connection
import 'package:flutterapiapp/model/BeerListModel.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';
import 'dart:developer' as developer;
import 'package:load/load.dart';
import '../Basewidget.dart';
import 'customProgressDialog.dart';


customProgressDialog pr;
// Here we are using http package to fetch data from API
// We defined retrun type BeerListModel
/*Future<BeerListModel> getBeerListData() async {
  developer.log('get getBeerListData api hited', name: 'my.app.category ');
  final response = await http.get(
    url,
  );
  //json.decode used to decode response.body(string to map)
  return BeerListModel.fromJson(json.decode(response.body));
}*/

/*Future<String> getString() async {
  developer.log('get sting api hited', name: 'my.app.category ');
  final response =
      await http.get('https://jsonplaceholder.typicode.com/albums/1');

  // final response = await http.get(url,);
  //json.decode used to decode response.body(string to map)
  String resstr = response.body;
  return resstr;
}*/

Future<Response> callNetwork(String url,int method,String json,String token) async {
  developer.log('get url $url ', name: 'my.app.category ');
Response response;
  Map<String, String> custheaders =
  {
    "Content-type": "application/json",
    "Authorization": token,
  };
  if(method==1){


 response =
await http.post(url,headers:custheaders,body: json);
}if(method==2){
 response =
await http.get(url,headers: custheaders);
}else if(method==3){
 response =
await http.put(url,headers:custheaders,body: json);
}
  // final response = await http.get(url,);
  //json.decode used to decode response.body(string to map)
  String resstr = response.body;
  return response;
}



// method defined to check internet connectivity
Future<bool> isConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

void Apicall(BuildContext context, Apicallback litiner,String url,int method,String json,int token ,bool needprogress,bool showerrormsg,int requestcode) async {
  isConnected().then((internet) {
    if(internet) {
      if (needprogress) {
        showprogressbar(context);
      }
      Future<BeerListModel> beerListFuture;
      Future<String> strlist;
      String res = "";
      String token = "";

      if (internet) {
        callNetwork(url, method, json, token).then((data) {
          hideprogressbar();
          Response response = data as Response;


          switch (response.statusCode) {
            case 200:
              litiner.SuccessResponse(
                  "test waste ${response.body}", requestcode);
              break;
            case 401:
              litiner.ErrorResponse("authandication failed", requestcode);
              break;

            default:
              litiner.ErrorResponse("authandication failed", requestcode);
          }
        });
      }
    }else{

    }

  });


}

void showprogressbar(BuildContext context) {
  pr = new customProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);

  pr.show();
  globals.loading = true;
}

void hideprogressbar() {
  if(pr!=null)
    {
      pr.dismiss();
    }
  globals.loading = true;
}
