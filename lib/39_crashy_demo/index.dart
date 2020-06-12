import 'package:flutter/material.dart';
//import 'package:flutter_crash_plugin/flutter_crash_plugin.dart';
import 'dart:async';
import 'dart:io';

class CrashyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CrashyPageState();
}

class CrashyPageState extends State<CrashyPage> {
  @override
  void initState() {
    //由于Bugly视iOS和Android为两个独立的应用，因此需要使用不同的App ID进行初始化
    if(Platform.isAndroid){
      //FlutterCrashPlugin.setUp('43eed8b173');
    }else if(Platform.isIOS){
      //FlutterCrashPlugin.setUp('088aebe0d5');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crashy demo'),),
      body: Center(
        child: Column(
          children: <Widget>[
            //使用try-catch捕获同步异常
            RaisedButton(
              child: Text('抛出同步异常'),
              elevation: 1.0,
              onPressed: () {
                throw StateError('This is a Dart exception.');
              },
            ),
            RaisedButton(
              child: Text('抛出异步异常'),
              elevation: 1.0,
              onPressed: () {
                Future.delayed(Duration(seconds: 1))
                    .then((e) => throw StateError('This is a Dart exception in Future.'));
              },
            ),
            //使用try-catch捕获同步异常
            RaisedButton(
              child: Text('try-catch捕获同步异常'),
              elevation: 1.0,
              onPressed: () {
                try {
                  throw StateError('This is a Dart exception.');
                }
                catch(e) {
                  print(e);
                }
              },
            ),
            //使用catchError捕获异步异常
            RaisedButton(
              child: Text('catchError捕获异步异常'),
              elevation: 1.0,
              onPressed: () {
                Future.delayed(Duration(seconds: 1))
                  .then((e) => throw StateError('This is a Dart exception in Future.'))
                  .catchError((e)=>print(e));
              },
            ),
            //注意，以下代码无法捕获异步异常
            RaisedButton(
              child: Text('try-catch捕获异步异常(无效)'),
              elevation: 1.0,
              onPressed: () {
                try {
                  //Future.delayed(Duration(seconds: 1)).then((e) => Future.error("This is an async Dart exception."));
                  Future.delayed(Duration(seconds: 1)).then((e) => throw StateError('This is a Dart exception in Future.'));
                }
                catch(e) {
                  print("This line will never be executed. ");
                }
              },
            ),
            RaisedButton(
              child: Text('Zone捕获同步异常'),
              elevation: 1.0,
              onPressed: () {
                runZoned(() {
                  //同步抛出异常
                  throw StateError('This is a Dart exception.');
                }, onError: (dynamic e, StackTrace stack) {
                  print('Sync error caught by zone');
                });
              },
            ),
            RaisedButton(
              child: Text('Zone捕获异步异常'),
              elevation: 1.0,
              onPressed: () {
                runZoned(() {
                  //异步抛出异常
                  Future.delayed(Duration(seconds: 1))
                    .then((e) => throw StateError('This is a Dart exception in Future.'));
                }, onError: (dynamic e, StackTrace stack) {
                  print('Async error aught by zone');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
