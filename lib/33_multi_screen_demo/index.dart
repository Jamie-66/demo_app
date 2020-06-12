import 'package:flutter/material.dart';
import 'master_detail_page.dart';
import 'orientation_demo.dart';

class MultiScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text('手机适配'),),
        body: TabBarView(
          children: [
            MasterDetailPage(),
            OrientationDemo(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.grid_on),text: "多窗格",),
            Tab(icon: Icon(Icons.rss_feed),text: "转屏",),
          ],
          unselectedLabelColor: Colors.blueGrey,
          labelColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.red,
        ),
      ),
    );
  }
}
