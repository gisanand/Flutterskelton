import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeletonapp/basepackage/baseclass.dart';
import 'package:flutter_skeletonapp/constants/StringConstants.dart';
import 'package:flutter_skeletonapp/constants/UrlConstants.dart';
import 'package:flutter_skeletonapp/utils/CommonUtils.dart';

import 'AppResponse.dart';

class Apiutils with baseclass {
  StreamController<ApiResponse<Object>> streamController = StreamController<
      ApiResponse<Object>>();

  StreamSink<ApiResponse<Object>> get responseStremSink =>
      streamController.sink;

  Stream<ApiResponse<Object>> get responseStrem => streamController.stream;
  ApiResponse? finalresponse;

  Future<Response> hitApi(String url, int method, Map<String, dynamic> params,
      int setToken) async {
    try {
      print("Api Method $method Url ${UrlConstants.Baseurl}$url  ");
      BaseOptions options = new BaseOptions(
        baseUrl: "${UrlConstants.Baseurl}",
        connectTimeout: 5000,
        receiveTimeout: 3000,
      );

      var dio = Dio(options);
      dio.options.headers["Content-Type"] = "application/json";
      dio.options.headers["Accept"] = "application/json";
      if (setToken == 1) {
        dio.options.headers["authorization"] =
        "Bearer ${loaddata(StringConstants.PREF_TOKEN, 1)}";
        print("${dio.options.headers.toString()}");
      }

      try {
        var response;
        if (method == 1) {
          response = await dio.get('$url');
        } else if (method == 2) {
          print(" Method $method Url $url  params $params");
          response = dio.post('$url', data: params);
        } else if (method == 3) {
          print(" Method $method Url $url  params $params");
          response = dio.put('$url', data: params);
        } else if (method == 4) {
          response = dio.delete("$url");
        }

        // response = await _dio.get(_endpoint);
        return response;
      } on DioError catch (error) {
        print('DioErrorCatechintry: $error');
        throw error;
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        throw error;
      }
    } on DioError catch (error) {
      print('DioErrorCatech: $error');
      throw error;
    } catch (e) {
      CommonUtils.hideprogressloading();
      print(e);

      throw e;
    }
  }

  Future<Response> uploadImageApi(String url, int method, FormData params,
      int setToken,filesendprogress sendprogressstatus ) async {
    try {
      print("Api Method $method Url ${UrlConstants.Baseurl}$url  ");
      BaseOptions options = new BaseOptions(
        baseUrl: "${UrlConstants.Baseurl}",
        connectTimeout: 5000,
        receiveTimeout: 3000,
      );

      var dio = Dio(options);
     // dio.options.headers["Content-Type"] = "multipart/form-data";
      //dio.options.headers["Content-Type"] = "application/json";
     // dio.options.headers["Accept"] = "application/json";
      if (setToken == 1) {
        dio.options.headers["authorization"] =
        "Bearer ${loaddata(StringConstants.PREF_TOKEN, 1)}";
        print("${dio.options.headers.toString()}");
      }

      try {
        var response;
        if (method == 1) {
          response = await dio.get('$url');
        } else if (method == 2) {
          print(" Method $method Url $url  params $params");
          response = dio.post('$url', data: params,onSendProgress:sendprogressstatus);
        } else if (method == 3) {
          print(" Method $method Url $url  params $params");
          response = dio.put('$url', data: params,onSendProgress:sendprogressstatus);
        } else if (method == 4) {
          response = dio.delete("$url");
        }

        // response = await _dio.get(_endpoint);
        return response;
      } on DioError catch (error) {
        print('DioErrorCatechintry: $error');
        throw error;
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        throw error;
      }
    } on DioError catch (error) {
      print('DioErrorCatech: $error');
      throw error;
    } catch (e) {
      CommonUtils.hideprogressloading();
      print(e);

      throw e;
    }
  }

  void callNetworkrequest(BuildContext context,
      String url,
      int method,
      Map<String, dynamic> params,
      int setToken,
      int requestCode,
      Successcallback successcall,
      Errorresponsecallback errorcall,
      jsontomodelconvertion resfun,
      bool showerror,
      bool showprogress) {
    checkConnection().then((value) {
      if (value) {
        if (showprogress) {
          CommonUtils.showProgressloading(context);
        }
        hitApi(url, method, params, setToken).then((value) {
          try {

            print("Api utils Response String   $value");
            print("Api utils Response value.statusCode   ${value.statusCode }");
            print("Api utils Response value.data.toString()  ${value.data.toString() }");
            if (showprogress) {
              CommonUtils.hideprogressloading();
            }
            Map<String, dynamic> resmap = json.decode("$value");
            print("Response of status ${resmap["status"]}");
            if (getaboutststatus(resmap["status"])) {
              if (resfun != null) {
                successcall(resfun("$value"), requestCode);
              } else {
                successcall("$value", requestCode);
              }
            } else {
              if(showerror){

                  if (resmap.containsKey("message")) {
                    CommonUtils.showAlertDialog(
                        context, getStringName("appname"), resmap["message"]);
                    errorcall(getStringName("appname"), requestCode);
                  } else {
                    CommonUtils.showAlertDialog(
                        context, getStringName("appname"),
                        getStringName("unkownerror"));
                    errorcall(getStringName("unkownerror"), requestCode);
                  }

              }
            }
          } catch (e) {
            print("error while json convertions  \n$e");
            appLog("$e");
            if (showerror) {
              errorcall("error while json convertions", requestCode);
            }
            if(showerror){
            CommonUtils.showAlertDialog(context, getStringName("appname"),
                getStringName("unkownerror"));
          }
          }
        }).catchError((e) {
          if (showprogress) {
            CommonUtils.hideprogressloading();
          }
          print(" Return in Diew error Block");

          if (e is DioError) {
            try {
              print("Api utils Response e.response values ${e.type}    ${e.response }");
              if (e.type == DioErrorType.connectTimeout) {
                if(showerror) {
                  CommonUtils.showAlertDialog(
                      context, getStringName("appname"),
                      getStringName("connectiontimeerror"));
                }
                errorcall(getStringName("appname"), requestCode);
              }else if (e.type == DioErrorType.other) {
                if(showerror) {
                  CommonUtils.showAlertDialog(
                      context, getStringName("appname"),
                      getStringName("unkownerror"));
                }
                errorcall(getStringName("appname"), requestCode);
              } else {


              print("Api utils Response e.response.statusCode   ${e.response!.statusCode }");
              Map<String, dynamic> errorresponse = Map();
              errorresponse = json.decode(e.response.toString());
              print("converted json $errorresponse");
              if (e.response!.statusCode == 401) {
                CommonUtils.sessionexpiered(
                    context, getStringName("appname"), "Session expired");
              } else {
                if (errorresponse["responsecode"] != "401") {
                  errorcall("${errorresponse["message"]}", requestCode);
                  if (errorresponse.containsKey("message")) {
                    if (showerror) {
                      CommonUtils.showAlertDialog(
                          context, getStringName("appname"),
                          "${errorresponse["message"]}");
                    }
                  } else {
                    if (showerror) {
                      CommonUtils.showAlertDialog(
                          context, getStringName("appname"),
                          getStringName("unkownerror"));
                    }
                  }
                }
              }
            }
            } on FormatException catch (e) {
              print('The provided string is not valid JSON $e');
              if(showerror) {
                CommonUtils.showAlertDialog(context, getStringName("appname"),
                    getStringName("unkownerror"));
              }
            } catch (e) {
              if (showprogress) {
                CommonUtils.hideprogressloading();
              }
              print("Error values in try in try");
              print(e);
              if(showerror){
              CommonUtils.showAlertDialog(context, getStringName("appname"),
                  getStringName("unkownerror"));
            }
            }
          } else {
            print("Some Other error");
            print(e);
            if(showerror){
            CommonUtils.showAlertDialog(context, getStringName("appname"),
                getStringName("unkownerror"));
          }
          }
          //     print(" Api Error  ${DioError.response}");
        });
      }
      else {
        if (showprogress) {
          CommonUtils.hideprogressloading();
        }

        CommonUtils.showAlertDialog(
            context, getStringName("appname"),
            getStringName("connectionerror"));
      }

    });
  }

  void uploadImageRequest(BuildContext context,
      String url,
      int method,
      FormData params,
      int setToken,
      int requestCode,
      Successcallback successcall,
      Errorresponsecallback errorcall,
      jsontomodelconvertion resfun,
          filesendprogress sendprogress,
      bool showerror,
      bool showprogress) {
    checkConnection().then((value) {
      if (value) {
        if (showprogress) {
          CommonUtils.showProgressloading(context);
        }
        uploadImageApi(url, method, params, setToken,sendprogress).then((value) {
          try {

            print("Api utils Response value String   ${value.toString()}");
            print("Api utils Response value.statusCode   ${value.statusCode }");
            print("Api utils Response value.data.toString()  ${value.data.toString() }");
            if (showprogress) {
              CommonUtils.hideprogressloading();
            }
            Map<String, dynamic> resmap = json.decode("$value");
            print("Response of status ${resmap["status"]}");
            if (getaboutststatus(resmap["status"])) {
              if (resfun != null) {
                successcall(resfun("$value"), requestCode);
              } else {
                successcall("$value", requestCode);
              }
            } else {
              if(showerror){

                if (resmap.containsKey("message")) {
                  CommonUtils.showAlertDialog(
                      context, getStringName("appname"), resmap["message"]);
                  errorcall(getStringName("appname"), requestCode);
                } else {
                  CommonUtils.showAlertDialog(
                      context, getStringName("appname"),
                      getStringName("unkownerror"));
                  errorcall(getStringName("unkownerror"), requestCode);
                }

              }
            }
          } catch (e) {
            print("error while json convertions  \n$e");
            appLog("$e");
            if (showerror) {
              errorcall("error while json convertions", requestCode);
            }
            if(showerror){
              CommonUtils.showAlertDialog(context, getStringName("appname"),
                  getStringName("unkownerror"));
            }
          }
        }).catchError((e) {
          if (showprogress) {
            CommonUtils.hideprogressloading();
          }
          print(" Return in Diew error Block");

          if (e is DioError) {
            try {
              if (e.type == DioErrorType.connectTimeout) {
                if(showerror) {
                  CommonUtils.showAlertDialog(
                      context, getStringName("appname"),
                      getStringName("connectiontimeerror"));
                }
                errorcall(getStringName("appname"), requestCode);
              }else if (e.type == DioErrorType.other) {
                if(showerror) {
                  CommonUtils.showAlertDialog(
                      context, getStringName("appname"),
                      getStringName("unkownerror"));
                }
                errorcall(getStringName("appname"), requestCode);
              } else {
              print("Api utils Response e.response.statusCode   ${e.response!
                  .statusCode }");
              Map<String, dynamic> errorresponse = Map();
              errorresponse = json.decode(e.response.toString());
              print("converted json $errorresponse");
              if (e.response!.statusCode == 401) {
                CommonUtils.sessionexpiered(
                    context, getStringName("appname"), "Session expired");
              } else {
                if (errorresponse["responsecode"] != "401") {
                  errorcall("${errorresponse["message"]}", requestCode);
                  if (errorresponse.containsKey("message")) {
                    if (showerror) {
                      CommonUtils.showAlertDialog(
                          context, getStringName("appname"),
                          "${errorresponse["message"]}");
                    }
                  } else {
                    if (showerror) {
                      CommonUtils.showAlertDialog(
                          context, getStringName("appname"),
                          getStringName("unkownerror"));
                    }
                  }
                }
              }
            }
            } on FormatException catch (e) {
              print('The provided string is not valid JSON $e');
              if(showerror) {
                CommonUtils.showAlertDialog(context, getStringName("appname"),
                    getStringName("unkownerror"));
              }
            } catch (e) {
              if (showprogress) {
                CommonUtils.hideprogressloading();
              }
              print("Error values in try in try");
              print(e);
              if(showerror){
                CommonUtils.showAlertDialog(context, getStringName("appname"),
                    getStringName("unkownerror"));
              }
            }
          } else {
            print("Some Other error");
            print(e);
            if(showerror){
              CommonUtils.showAlertDialog(context, getStringName("appname"),
                  getStringName("unkownerror"));
            }
          }
          //     print(" Api Error  ${DioError.response}");
        });
      }
      else {
        if (showprogress) {
          CommonUtils.hideprogressloading();
        }

        CommonUtils.showAlertDialog(
            context, getStringName("appname"),
            getStringName("connectionerror"));
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



  bool getaboutststatus(dynamic dstatus) {
    if(dstatus is bool) {
    return dstatus;
    }else{
      return "$dstatus"=="true";
    }
  }
}
