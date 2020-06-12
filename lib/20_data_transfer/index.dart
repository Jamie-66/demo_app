import 'package:flutter/material.dart';
import 'count_container.dart';
import 'notification_widget.dart';
import 'event_bus_page.dart';

class DataTransfer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            CounterPage(),
            NotificationWidget(),
            FirstPage()
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home),text: "InheritedWidget",),
              Tab(icon: Icon(Icons.rss_feed),text: "Notification",),
              Tab(icon: Icon(Icons.linear_scale),text: "EventBus",)
            ],
            unselectedLabelColor: Colors.blueGrey,
            labelColor: Colors.blue,
            indicator: BoxDecoration(),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.red,
          ),
        ),
      )
    );
  }
}
