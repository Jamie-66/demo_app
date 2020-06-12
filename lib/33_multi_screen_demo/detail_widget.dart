import 'package:flutter/material.dart';

class DetailWidget extends StatefulWidget {
  final int data;
  DetailWidget(this.data);

  @override
  State<StatefulWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
      child: Center(
        child: Text('index: ${widget.data}', style: TextStyle(fontSize: 20),),
      ),
    );
  }
}
