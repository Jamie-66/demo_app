import 'package:flutter/material.dart';
import 'normal_animate_widget.dart';
import 'builder_animate_widget.dart';
import 'widget_animate_widget.dart';
import 'hero_transition.dart';

class AnimationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
              children: [
                NormalAnimateWidget(),
                BuilderAnimateWidget(),
                WidgetAnimateWidget(),
                Page1()
              ]
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: '普通动画',),
              Tab(icon: Icon(Icons.rss_feed),text: "Builder动画",),
              Tab(icon: Icon(Icons.perm_identity),text: "Widget动画",),
              Tab(icon: Icon(Icons.message),text:'hero动画')
            ],
            unselectedLabelColor: Colors.blueGrey,
            labelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.red,
          ),
        )
    );
  }
}
