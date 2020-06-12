import 'package:flutter/material.dart';

//用于打印build方法执行情况的自定义控件
class TestIcon extends StatelessWidget {
  final String name;
  TestIcon({
    Key key,
    this.name
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    print("TestIcon build $name");
    return Icon(Icons.add);//返回Icon实例
  }
}
