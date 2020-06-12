import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
import 'dart:async';

/// EventBus事件总线是在Flutter中实现跨组件通信的机制,遵循发布/订阅模式

class CustomEvent {
  String msg;
  CustomEvent({this.msg});
}

EventBus eventBus = new EventBus();

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String msg = '通知：';
  StreamSubscription subscription;

  @override
  void initState() {
    //监听CustomEvent事件，刷新UI
    subscription = eventBus.on<CustomEvent>().listen((event) {
      print(event);
      setState(() {
        msg += '${event.msg} ';
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // State销毁时，清理注册
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Center(
        child: Text(
          msg,
          style: TextStyle(fontSize: 20)
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()));
        },
        child: Icon(Icons.arrow_forward_ios)
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () => eventBus.fire(CustomEvent(msg: 'hello')),
          child: Text('Fire Event'),
        ),
      ),
    );
  }
}