import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:demoapp/generated/i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_config.dart';
import 'package:demoapp/1_19_demo/missing.dart';
import 'package:demoapp/20_data_transfer/index.dart';
import 'package:demoapp/21_router_demo/index.dart';
import 'package:demoapp/21_router_demo/404_not_found.dart';
import 'package:demoapp/22_app_animation/index.dart';
import 'package:demoapp/24_network_demo/index.dart';
import 'package:demoapp/25_data_persistence/index.dart';
import 'package:demoapp/30_provider_demo/index.dart';
import 'package:demoapp/33_multi_screen_demo/index.dart';
import 'package:demoapp/39_crashy_demo/index.dart';
import 'package:demoapp/40_peformance_demo/pv_exception.dart';
import 'package:demoapp/40_peformance_demo/index.dart';

// IOS主题
final ThemeData kIOSTheme = ThemeData(
    brightness: Brightness.light,
    accentColor: Colors.white,
    primaryColor: Colors.blue,
    iconTheme: IconThemeData(color: Colors.grey),
    textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black87))
);

// Android主题
final ThemeData kAndroidTheme = ThemeData(
    brightness: Brightness.dark,
    accentColor: Colors.black,
    primaryColor: Colors.cyan,
    iconTheme: IconThemeData(color: Colors.blue),
    textTheme: TextTheme(bodyText1: TextStyle(color: Colors.red))
);

class MyApp extends StatelessWidget {
  final appTitle = 'Flutter App';

  final List<ListItemModel> list = [
    ListItemModel(
        icon: Icon(Icons.settings),
        title: Text('1_19_demo'),
        model: Missing()
    ),
    ListItemModel(
        icon: Icon(Icons.settings),
        title: Text('20_data_transfer'),
        model: DataTransfer()
    ),
    ListItemModel(
        icon: Icon(Icons.settings),
        title: Text('21_route_demo'),
        model: RoutePage()
    ),
    ListItemModel(
        icon: Icon(Icons.settings),
        title: Text('22_app_animation'),
        model: AnimationPage()
    ),
    ListItemModel(
        icon: Icon(Icons.settings),
        title: Text('24_network_demo'),
        model: NetworkPage(title: 'Network demo',)
    ),
    ListItemModel(
        icon: Icon(Icons.settings),
        title: Text('25_data_persistence'),
        model: DataPersistencePage(title: '本地存储与数据库')
    ),
    ListItemModel(
        icon: Icon(Icons.settings),
        title: Text('30_provider_demo'),
        model: ProviderPage()
    ),
    ListItemModel(
        icon: Icon(Icons.settings),
        title: Text('33_multi_screen_demo'),
        model: MultiScreenPage()
    ),
    ListItemModel(
        icon: Icon(Icons.settings),
        title: Text('39_crashy_demo'),
        model: CrashyPage()
    ),
    ListItemModel(
        icon: Icon(Icons.settings),
        title: Text('40_peformance_demo'),
        model: PeformancePage()
    ),
  ];

  @override
  Widget build(BuildContext context) {
    assert(() {
      //Do sth for debug
      print('checking debug in assert ');
      return true;
    }());

    if(kReleaseMode){
      //Do sth for release
      print('checking release from Environment ');
    } else {
      //Do sth for debug
      print('checking debug from Environment ');
    }
    
    var config = AppConfig.of(context);
    
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      onGenerateTitle: (context) {
        return S.of(context).app_title;
      },
      navigatorObservers: [
        MyObserver()
      ],
      theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme : kAndroidTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('主页标题：${config.appName}', style: TextStyle(fontSize: 24),),
              Text('接口域名：${config.apiBaseUrl}', style: TextStyle(fontSize: 24),)
            ],
          ),
        ),
        drawer: Drawer(
          child: Container(
            padding: EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                CustomDrawerHeader(),
                Expanded(
                  flex: 1,
                  child: ListItem(list: list),
                )
              ],
            ),
          ),
        ),
      ),
      routes: {
        "second_page": (context) => SecondPage(),
        "third_page": (context) => ThirdPage()
      },
      onUnknownRoute: (RouteSettings setting) => MaterialPageRoute(builder: (context) => UnknownPage()),
    );
  }
}

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor
        ),
        child: Center(
          child: SizedBox(
            width: 80.0,
            height: 80.0,
            child: CircleAvatar(
              backgroundColor: Colors.black12,
              child: Text(
                'R',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
        )
    );
  }
}

class ListItemModel {
  final Icon icon;
  final Text title;
  final Widget model;

  ListItemModel({
    @required this.icon,
    @required this.title,
    @required this.model
  });
}

class ListItem extends StatelessWidget {
  final List<ListItemModel> list;

  ListItem({
    Key key,
    @required this.list
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.pink,
          child: list[index].icon,
        ),
        title: list[index].title,
        onTap: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => list[index].model));
        },
      ),
    );
  }
}
