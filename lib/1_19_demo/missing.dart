import 'package:date_format/date_format.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Missing extends StatelessWidget {
  Missing({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver,SingleTickerProviderStateMixin {
  // 滚动控制
  ScrollController _controller; // ListView 控制器
  // 使用控制Tabbar切换
  TabController _tabController; // TabBar 控制器
  bool isToTop = false; // 标示目前是否需要启用 "Top" 按钮
  final List<UpdatedItemModel> model = [
    UpdatedItemModel(
      appIcon: 'assets/images/icon_map.png', //App图标
      appName: 'Google Maps - Translation of Test', //App名称
      appSize: '103.2', //App大小
      appDate: '2019年3月9日', //App更新日期
      appDescription: 'Thanks you for using Google Maps!Thanks you for using Google Maps!Thanks you for using Google Maps!Thanks you for using Google Maps!', //App更新文案
      appVersion: '5.01', //App版本
    ),
    UpdatedItemModel(
      appIcon: 'assets/images/icon_timg.jpeg', //App图标
      appName: '天猫', //App名称
      appSize: '137.2', //App大小
      appDate: '2019年6月5日', //App更新日期
      appDescription: 'Thanks you for using Google Maps!Thanks you for using Google Maps!Thanks you for using Google Maps!Thanks you for using Google Maps!', //App更新文案
      appVersion: '5.19', //App版本
    ),
  ];
  int _counter = 0;
  List<Widget> pages = List<Widget>();
  double _top = 0.0;
  double _left = 0.0;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 1, vsync: this, length: 4);
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset > 1000) {
        setState(() {
          isToTop = true;
        });
      } else if(_controller.offset < 300) {
        setState(() {
          isToTop = false;
        });
      }
    });
    WidgetsBinding.instance.addObserver(this); // 注册监听器
  }

  @override
  @mustCallSuper
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this); // 移除监听器
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // print("单次Frame绘制回调"); // 只回调一次
    });
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      // print("实时Frame绘制回调"); // 每帧都回调
    });
    print('$state');
    if(state == AppLifecycleState.resumed) {
      // do sth
    }
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child:  Text('You have pushed the button this many times: $_counter'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: RaisedButton(
                            onPressed: _incrementCounter,
                            child: Icon(Icons.add),
                          ),
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(20.0),
                    margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
                    width: 180.0,
                    height: 240.0,
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text('Container(容器)在UI框架中是一个很常见的概念，Flutter也不例外。'),
                  ),
                  Center(
                    child: Text('Hello'),
                  ),
                  Row(
                    children: <Widget>[
                      Container(color: Colors.indigoAccent,width: 60,height: 80),
                      Container(color: Colors.red,width: 100,height: 180),
                      Container(color: Colors.green,width: 60,height: 80),
                      Container(color: Colors.blue,width: 60,height: 80),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(color: Colors.indigoAccent,width: 60,height: 80),
                      Container(color: Colors.red,width: 100,height: 180),
                      Container(color: Colors.green,width: 60,height: 80),
                      Container(color: Colors.blue,width: 60,height: 80),
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Container(color: Colors.yellow, height: 150.0),
                      Positioned(
                        child: Container(color: Colors.green, width: 50.0, height: 50.0),
                        top: 18,
                        right: 18,
                      ),
                      Positioned(
                        child: Text('Stack提供了层叠布局的容器'),
                        top: 70,
                        left: 18,
                      )
                    ],
                  ),
                ],
              ),
              Container(
                child: UpdatedItem(
                    model: model,
                    onPressed: (int index) {
                      print('Clicked ${index+1} OPEN button');
                    }
                ),
              ),
              Center(
                child: Cake(),
              ),
              ListView(
                children: <Widget>[
                  // 冒泡分发机制
                  Listener(
                    child: Container(
                      color: Colors.red,
                      height: 200,
                      child: Center(
                        child: Listener(
                          onPointerDown: (event) => print('Child pointer down'),
                          child: Container(
                            color: Colors.blue,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    ),
                    onPointerDown: (event) => print('Parent pointer down'), // 手势按下回调
                    onPointerMove: (event) => print('move $event'), // 手势移动回调
                    onPointerUp: (event) => print('up $event'), // 手势抬起回调
                  ),
                  // 子容器实现拖拽事件监听
                  Stack(
                    children: <Widget>[
                      Container(color: Colors.yellow, height: 200),
                      Positioned(
                          top: _top,
                          left: _left,
                          child: GestureDetector(
                            child: Container(
                              color: Colors.green,
                              width: 100,
                              height: 100,
                              child: Center(
                                child: Text('可拖拽'),
                              ),
                            ),
                            onTap: () => print('Tap'),
                            onDoubleTap: () => print('Double Tap'),
                            onLongPress: () => print('Long Press'),
                            onPanUpdate: (e) {
                              setState(() {
                                _left += e.delta.dx;
                                _top += e.delta.dy;
                              });
                            },
                          )
                      )
                    ],
                  ),
                  // 父容器与子容器同时添加点击事件监听
                  GestureDetector(
                    onTap: () => print('Parent tapped'),
                    child: Container(
                      color: Colors.pinkAccent,
                      height: 200,
                      child: Center(
                        child: GestureDetector(
                          onTap: () => print('Child tapped'),
                          child: Container(
                            color: Colors.white,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // 使父容器能监听到子容器的点击事件
                  RawGestureDetector(
                    gestures: {
                      MultipleTapGestureRecognizer: GestureRecognizerFactoryWithHandlers<MultipleTapGestureRecognizer> (
                            () => MultipleTapGestureRecognizer(),
                            (MultipleTapGestureRecognizer instance) {
                          instance.onTap = () => print('Parent tapped');
                        },
                      )
                    },
                    child: Container(
                      color: Colors.cyan,
                      height: 200,
                      child: Center(
                        child: GestureDetector(
                          onTap: () => print('Child tapped'),
                          child: Container(
                            color: Colors.black45,
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ]
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          child: Icon(Icons.wb_sunny),
        ),
        bottomNavigationBar: SafeArea(
          child: Material(
            color: Colors.white,
            child: TabBar(
                controller: _tabController,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black26,
                indicator: BoxDecoration(),
                tabs: <Widget>[
                  Tab(
                    text: '组合',
                    icon: Icon(Icons.border_all),
                  ),
                  Tab(
                    text: 'App',
                    icon: Icon(Icons.apps),
                  ),
                  Tab(
                    text: '自绘',
                    icon: Icon(Icons.palette),
                  ),
                  Tab(
                    text: '监听',
                    icon: Icon(Icons.landscape),
                  )
                ]
            ),
          ),
        )
    );
  }
}

class UpdatedItemModel {
  final String appIcon; //App图标
  final String appName; //App名称
  final String appSize; //App大小
  final String appDate; //App更新日期
  final String appDescription; //App更新文案
  final String appVersion; //App版本
  UpdatedItemModel({this.appIcon, this.appName, this.appSize, this.appDate, this.appDescription, this.appVersion});
}

typedef IndexCallback = void Function(int index);

class UpdatedItem extends StatelessWidget {
  final List<UpdatedItemModel> model; //数据模型
  final IndexCallback onPressed;
  // 构造函数语法糖，用来给model赋值
  UpdatedItem({Key key, this.model, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: model.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Container(
            padding: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: Colors.black38,
                    style: BorderStyle.solid,
                  )
              ),
            ),
            child: Column(
              children: <Widget>[
                buildTopRow(context, index),
                buildBottomRow(context, index),
              ],
            ),
          ),
        )
    );
  }

  Widget buildTopRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(model[index].appIcon, width: 55.0, height: 55.0),
          ),
        ),
        Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(model[index].appName, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold),),
                Text(model[index].appDate, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            )
        ),
        Container(
          padding: EdgeInsets.only(left: 15),
          child: FlatButton(
            padding: EdgeInsets.all(0),
            materialTapTargetSize: MaterialTapTargetSize.padded,
            textColor: Color.fromRGBO(64, 158, 255, 1),
            color: Color.fromRGBO(235, 238, 245, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Text('OPEN'),
            onPressed: () {
              print(formatDate(DateTime.now(), [yyyy,'-',mm,'-',dd,' ', HH,':',nn,':',ss]));
              onPressed(index);
            },
          ),
        )
      ],
    );
  }

  Widget buildBottomRow(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(model[index].appDescription),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child:  Text("Version ${model[index].appVersion} • ${model[index].appSize} MB"),
          )
        ],
      ),
    );
  }
}

/// 绘制饼图
class WheelPainter extends CustomPainter {
  final List<double> wheelRadius;

  WheelPainter({@required this.wheelRadius});

  Paint getColoredPaint(Color color) { //根据颜色返回不同的画笔
    Paint paint = Paint(); //生成画笔
    paint.color = color; //设置画笔颜色
    return paint;
  }

  @override
  void paint(Canvas canvas, Size size) { //绘制逻辑
    double wheelSize = min(size.width, size.height) / 2; //饼图的尺寸
    double nbElem = wheelRadius.fold(0, (curr, next) => curr + next);
    double radius = (2 * pi) / nbElem;
    double currRadius = 0;
    // 包裹饼图这个圆形的矩形框
    Rect boundingRect = Rect.fromCircle(center: Offset(wheelSize, wheelSize), radius: wheelSize);
    wheelRadius.asMap().keys.forEach((i) {
      canvas.drawArc(boundingRect, currRadius, wheelRadius[i] * radius, true, getColoredPaint(Colors.primaries[Random().nextInt(Colors.primaries.length)]));
      currRadius += wheelRadius[i] * radius;
    });
  }

  // 判断是否需要重绘，这里我们简单的做下比较即可
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}

class Cake extends StatelessWidget {
  final List<double> _list = [1, 2, 3, 4];
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: WheelPainter(wheelRadius: _list),
    );
  }
}

class MultipleTapGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
