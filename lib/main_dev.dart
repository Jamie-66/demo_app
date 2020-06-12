import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'app_config.dart';
import 'dart:ui';
import 'my_app.dart';
import 'package:demoapp/40_peformance_demo/pv_exception.dart';
import 'package:demoapp/40_peformance_demo/fps_calculate.dart';

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

void main() {
  //将debugPrint指定为同步打印数据
  debugPrint = (String message, {int wrapWidth}) => debugPrintSynchronously(message, wrapWidth: wrapWidth);

  var configuredApp = AppConfig(
    appName: 'dev',//主页标题
    apiBaseUrl: 'http://dev.example.com/',//接口域名
    child: MyApp(),
  );

  // 统一使用Zone去处理应用内的所有异常
  FlutterError.onError = (FlutterErrorDetails details) async {
    //转发至Zone中
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  // 重写ErrorWidget.builder方法
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    return Scaffold(
      body: Center(
        child: Text('Custom Error Widget"'),
      ),
    );
  };

  // 入口catch错误
  runZoned<Future<Null>>(() async {
    runApp(configuredApp);//启动应用入口

    //设置帧回调函数并保存原始帧回调函数
    // orginalCallback = window.onReportTimings;
    // window.onReportTimings = onReportTimings;
  }, onError: (error, stackTrace) async {
    await reportError(error, stackTrace);
  });
}
