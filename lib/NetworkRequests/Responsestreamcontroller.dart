import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_skeletonapp/NetworkRequests/Apiutils.dart';
import 'package:flutter_skeletonapp/NetworkRequests/AppResponse.dart';
import 'package:flutter_skeletonapp/basepackage/baseclass.dart';

class Responsestreamcontroller
{
  StreamController<ApiResponse>? _responsecontroller;
  ValueChanged<Object>? responseemitor;
  String type="";



  StreamSink<ApiResponse> get responsecontrollerSink => _responsecontroller!.sink;

  Stream<ApiResponse> get responsecontrollerStream =>  _responsecontroller!.stream;


  Responsestreamcontroller.initstream() {
    _responsecontroller = StreamController<ApiResponse>();
  }


  Responsestreamcontroller(BuildContext context,
      String url,
      int method,
      Map<String, dynamic> params,
      int setToken,
      int requestCode,
      jsontomodelconvertion resfun,
      bool showerror,
      bool showprogress,responseemitor,
      bool callafter,bool showshimmerloader
      ){
    _responsecontroller=StreamController<ApiResponse>();
if(!callafter) {
  bool addloading=false;
  if(showshimmerloader)
    {
      addloading=false;
      responsecontrollerSink.add(ApiResponse.loading("",requestCode));
    }else{
    addloading=showprogress;
  }

  Apiutils().callNetworkrequest(
      context,
      url,
      method,
      params,
      setToken,
      requestCode,
          (value, requestcode) {
        print("responselitiner called in ");
        responsecontrollerSink.add(ApiResponse.completed(value,requestcode));
        if (responseemitor != null) {
          responseemitor(ApiResponse.completed(value,requestcode));
        }
      }, (msg,
      requestcode) {
    responsecontrollerSink.add(ApiResponse.error(msg,requestcode));
    if (responseemitor != null) {
      responseemitor(msg);
    }
  },
      resfun,
      showerror,
      addloading);
}
  }
void  responsestreamcontrolleCallapi(BuildContext context,
      String url,
      int method,
      Map<String, dynamic> params,
      int setToken,
      int requestCode,
      jsontomodelconvertion resfun,
      bool showerror,
      bool showprogress,responseemitor,bool showshimmerloader
      ){
    _responsecontroller=StreamController<ApiResponse>();
    bool addloading=false;
    if(showshimmerloader)
    {
      addloading=false;
      responsecontrollerSink.add(ApiResponse.loading("",requestCode));
    }else{
      addloading=showprogress;
    }
    Apiutils().callNetworkrequest(
        context,
        url,
        method,
        params,
        setToken,
        requestCode,
            (value, requestcode) {
          print("responselitiner called in ");
          responsecontrollerSink.add(ApiResponse.completed(value,requestcode));
          if(responseemitor!=null)
          {
            responseemitor(ApiResponse.completed(value,requestcode));
          }
        }, (msg,
        requestcode) {
      responsecontrollerSink.add(ApiResponse.error(msg,requestcode));
      if(responseemitor!=null)
      {
        responseemitor(msg);
      }
    },
        resfun,
        showerror,
        addloading);
  }

}