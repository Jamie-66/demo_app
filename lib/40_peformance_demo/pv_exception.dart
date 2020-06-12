import 'package:flutter/material.dart';
import 'dart:async';
//import 'package:flutter_crash_plugin/flutter_crash_plugin.dart';

//异常发生次数
int exceptionCount = 0;

//上报数据至Bugly
Future<Null> reportError(dynamic error, dynamic stackTrace) async {
  print('Caught error: $error');

  print('Reporting to Bugly...');

  exceptionCount++; //累加异常次数

  //FlutterCrashPlugin.postException(error, stackTrace);
}

int totalPV = 0;

class MyObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route previousRoute) {
    totalPV++;//累加PV
    super.didPush(route, previousRoute);
  }
}

//页面异常率
double pageException() {
  if(totalPV == 0) return 0;
  return exceptionCount/totalPV;
}
