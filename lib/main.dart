import 'package:flutter/material.dart';
import 'app_config.dart';
import 'my_app.dart';

void main() {
  // 将debugPrint指定为空的执行体, 所以它什么也不做
  debugPrint = (String message, {int wrapWidth}) {};

  var configuredApp = AppConfig(
    appName: 'example',//主页标题
    apiBaseUrl: 'http://api.example.com/',//接口域名
    child: MyApp(),
  );
  runApp(configuredApp);//启动应用入口
}
