import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appskeleton/basepackage/baseclass.dart';
import 'package:flutter_appskeleton/constants/StringConstants.dart';
import 'package:flutter_appskeleton/constants/UrlConstants.dart';
import 'package:flutter_appskeleton/utils/CommonUtils.dart';

class Apiutils with baseclass {
  Future<Response> Callapi(
      String url, int method, Map<String, dynamic> params, int setToken) async {
    try {
      print(" Method $method Url $url  ");
      BaseOptions options = new BaseOptions(
        baseUrl: "${UrlConstants.Baseurl}",
        connectTimeout: 5000,
        receiveTimeout: 3000,
      );

      var dio = Dio(options);
      if (setToken == 1) {
        dio.options.headers["authorization"] = "${loaddata(StringConstants.PREF_TOKEN,1)}";
        print("${dio.options.headers.toString()}");
      }
      var response;
      if (method == 1) {
        response = await dio.get('${url}').catchError((DioError) {
          CommonUtils.hideprogressbar();
          print("Errror of Dio ");
          print(DioError);
          throw DioError.response.toString();
          ;
        });
      } else if (method == 2) {
        print(" Method $method Url $url  params $params");
        response = dio.post('${url}', data: params).catchError((DioError) {
          CommonUtils.hideprogressbar();
          print("Errror of Dio ${DioError.response.toString()} ");
          print(DioError);
          throw DioError;
        });
      } else if (method == 3) {
        print(" Method $method Url $url  params $params");
        response = dio.put('${url}', data: params).catchError((DioError) {
          CommonUtils.hideprogressbar();
          print("Errror of Dio ${DioError.response.toString()} ");
          print(DioError);
          throw DioError.response.toString();
        });
      } else if (method == 4) {
        response = dio.delete("${url}").catchError((DioError) {
          CommonUtils.hideprogressbar();
          print("Errror of Dio ");
          print(DioError.toString());
          throw DioError;
        });
      }

      return response;
    } catch (e) {
      CommonUtils.hideprogressbar();
      print(e);

      throw e;
    }
  }

  void callNetworkrequest(
      BuildContext context,
      String url,
      int method,
      Map<String, dynamic> params,
      int setToken,
      int Requestcode,
      Successcallback successcall,
      Errorresponsecallback errorcall,
      jsontomodelconvertion resfun,
      bool showerror,
      bool showprogress) {

      checkConnection().then((value) {
        if (value) {
          CommonUtils.showprogressbar(context);
          Callapi(url, method, params, setToken).then((value) {
            print("Api utils Response  $value");
            print("Api utils Response value.statusCode   ${value.statusCode }");
            print("Api utils Response value.data.toString()  ${value.data.toString() }");
            CommonUtils.hideprogressbar();
            if (value.statusCode == 200||value.statusCode == 201) {


                if (resfun != null) {
                  successcall(resfun("${value}"), Requestcode);

                } else {
                  successcall("${value}", Requestcode);
                }

            } else {
              Map<String,dynamic> resmap=json.decode("$value");
              if(resmap.containsKey("message")) {
                CommonUtils.showAlertDialog(
                    context, getStringName("appname"), resmap["message"]);
              }else{
                CommonUtils.showAlertDialog(
                    context, getStringName("appname"), getStringName("unkownerror"));
              }

            }
          }).catchError((e) {
            print(" Return in Diew error Block");
            if(e is DioError){
            CommonUtils.hideprogressbar();
            Map<String, dynamic> errorresponse = Map();
            print(DioError);

            errorresponse = json.decode(e.response.toString());
            print("converted json $errorresponse");
            if (errorresponse["responsecode"] != "401") {
              errorcall("${errorresponse["message"]}",Requestcode);
              if (errorresponse.containsKey("message")) {
                CommonUtils.showAlertDialog(context, getStringName("appname"), "${errorresponse["message"]}");
              } else {
                CommonUtils.showAlertDialog(context, getStringName("appname"),
                    getStringName("unkownerror"));
              }
              }
            } else{
              print("Some Other error");
              print(e);
              CommonUtils.showAlertDialog(context, getStringName("appname"),
                  getStringName("unkownerror"));
            }
       //     print(" Api Error  ${DioError.response}");
          });
        } else {

        }
      });

  }

  Future checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print("Connected to Mobile Network");
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("Connected to WiFi");
      return true;
    } else {
      print("Unable to connect. Please Check Internet Connection");
      return false;
    }
  }
}
