import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter_model.dart';
import 'provider_demo.dart';
import 'consumer_demo.dart';

class ProviderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: 30.0),
        ChangeNotifierProvider.value(value: CounterModel())
      ],
      child: MaterialApp(
        title: 'Provider demo',
        theme: ThemeData(
          primaryColor: Colors.blue
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: [
              ConsumerTabPage1(),
              ProviderTabPage1(),
            ]
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home),text: "Consumer",),
              Tab(icon: Icon(Icons.rss_feed),text: "Provider",),
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
