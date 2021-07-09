import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_skeletonapp/NetworkRequests/AppResponse.dart';
import 'package:flutter_skeletonapp/NetworkRequests/Responsestreamcontroller.dart';
import 'package:flutter_skeletonapp/basepackage/baseclass.dart';
import 'package:flutter_skeletonapp/utils/CommonUtils.dart';

class UiWithNetworkclass extends StatelessWidget{
  Responsestreamcontroller responsecontrollerbloc=Responsestreamcontroller.initstream();
  Widget? childWidget;
  StremBuilderEmitter? stremBuilderEmitter;

  UiWithNetworkclass(Responsestreamcontroller? currentobj,{this.childWidget,this.stremBuilderEmitter});

  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<ApiResponse>(
      builder:( context,Snaphot)
      {
        var response=Snaphot.data as ApiResponse;
        switch(response.status)
        {
          case  Status.LOADING:
            {
              CommonUtils.showProgressloading(context);
              break;
            }
          case  Status.ERROR:
            {
              CommonUtils.hideprogressloading();

              break;
            }
          case  Status.COMPLETED:
            {
              CommonUtils.hideprogressloading();

              break;
            }
        }
        return  childWidget!;

      }
      
    );
    
  }
  
}