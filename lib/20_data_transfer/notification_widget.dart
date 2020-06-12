import 'package:flutter/material.dart';

/// Notificaiton的数据流动方式是从子 Widget向上传递至父Widget

class CustomNotification extends Notification {
  CustomNotification({this.msg});

  final String msg;
}

class CustomChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      // 按钮点击时分发通知
      onPressed: () => CustomNotification(msg: 'Hi').dispatch(context),
      child: Text('Fire Notification'),
    );
  }
}

class NotificationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationWidget> {
  String _msg = '通知：';

  @override
  Widget build(BuildContext context) {
    // 监听通知
    return NotificationListener<CustomNotification>(
      onNotification: (notification) {
        setState(() {
          _msg += notification.msg + ' ';
        });
        return true;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _msg,
            style: TextStyle(fontSize: 20)
          ),
          CustomChild()
        ],
      )
    );
  }
}
