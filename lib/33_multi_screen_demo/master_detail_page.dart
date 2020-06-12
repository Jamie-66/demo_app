import 'package:flutter/material.dart';
import 'list_widget.dart';
import 'detail_widget.dart';

class MasterDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MasterDetailPageState();
}

class _MasterDetailPageState extends State<MasterDetailPage> {
  var selectedValue = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
          builder: (context, orientation) {
            if(MediaQuery.of(context).size.width > 480) {
              return Row(
                children: <Widget>[
                  Expanded(
                      child: ListWidget((value) {
                        setState(() {
                          selectedValue = value;
                        });
                      })
                  ),
                  Expanded(
                      child: DetailWidget(selectedValue)
                  )
                ],
              );
            } else {
              return ListWidget((value) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Scaffold(
                    body: DetailWidget(value),
                  );
                }));
              });
            }
          }
      ),
    );
  }
}
