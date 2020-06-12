import 'package:flutter/material.dart';

/// 路由导航位未知页面

class UnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('404'),
      ),
      body: Center(
        child: Text('404 not found'),
      ),
    );
  }
}