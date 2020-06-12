import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class NetworkPage extends StatefulWidget {
  final String title;
  NetworkPage({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  httpClientDemo() async {

    try {
      //创建网络调用示例，设置通用请求行为(超时时间)
      var httpClient = HttpClient();
      httpClient.idleTimeout = Duration(seconds: 5);

      //构造URI，设置user-agent为"Custom-UA"
      var uri = Uri.parse('https://flutter.dev');
      var request = await httpClient.getUrl(uri);
      request.headers.add('user-agent', 'Custom-UA');

      //发起请求，等待响应
      var response = await request.close();

      //收到响应，打印结果
      if(response.statusCode == HttpStatus.ok) {
        print(await response.transform(utf8.decoder).join());
      } else {
        print('Respone code: ${response.statusCode}');
      }
    }
    catch(e) {
      print('Error:$e');
    }

  }

  httpDemo() async {

    try {
      //创建网络调用示例
      var client = http.Client();
      //构造URI
      var uri = Uri.parse('https://flutter.dev');

      //设置user-agent为"Custom-UA"，随后立即发出请求
      http.Response response = await client.get(uri, headers: {'user-agent': 'Custom-UA'});

      //收到响应，打印结果
      if(response.statusCode == HttpStatus.ok) {
        print(response.body);
      } else {
        print('Respone code: ${response.statusCode}');
      }

    }
    catch(e) {
      print('Error:$e');
    }

  }

  dioDemo() async {

    try {
      //创建网络调用示例
      Dio dio = Dio();

      //设置URI及请求user-agent后发起请求
      var response = await dio.get('https://flutter.dev', options: Options(headers: {'user-agent': 'Custom-UA'}));

      //打印请求结果
      if(response.statusCode == HttpStatus.ok) {
        print(response.data.toString());
      } else {
        print('Respone code: ${response.statusCode}');
      }
    }
    catch(e) {
      print('Error:$e');
    }

  }

  dioParallDemo() async {

    try {
      //创建网络调用示例
      Dio dio = Dio();

      //同时发起两个并行请求
      List<Response> responseX = await Future.wait([dio.get("https://flutter.dev"),dio.get("https://pub.dev/packages/dio")]);

      //打印请求1响应结果
      print("Response1: ${responseX[0].toString()}");
      //打印请求2响应结果
      print("Response2: ${responseX[1].toString()}");
    }
    catch(e) {
      print('Error:$e');
    }

  }

  dioInterceptorReject() async {
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) {
        //检查是否有token，没有则直接报错
        if(options.headers['token'] == null) {
          return dio.reject('Error: 请先登录');
        }
        return options;
      }
    ));

    try {
      var response = await dio.get("https://flutter.dev");
      print(response.data.toString());
    }
    catch(e) {
      print('Error:$e');
    }
  }

  dioIntercepterCache() async {
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          //检查缓存是否有数据
          if(options.uri == Uri.parse('https://flutter.dev')) {
            return dio.resolve('返回缓存数据');
          }
          return options;
        }
    ));

    try {
      var response = await dio.get("https://flutter.dev");
      print(response.data.toString());
    }
    catch(e) {
      print('Error:$e');
    }
  }

  dioIntercepterCustomHeader() async {
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          options.headers['user-agent'] = 'Custom-UA';
          return options;
        }
    ));

    try {
      var response = await dio.get("https://flutter.dev");
      print(response.data.toString());
    }
    catch(e) {
      print('Error:$e');
    }
  }

  String jsonString = '''
    {
      "id":"123",
      "name":"张三",
      "score" : 95,
      "teacher": [
        {
          "name": "李四",
          "age" : 40
        }, 
        {
          "name": "王五",
          "age" : 45
        }
      ]
    }
   ''';

  static Student parseStudent(String content) {
    final jsonResponse = json.decode(content);
    Student student = Student.fromJson(jsonResponse);
    return student;
  }

  Future<Student> loadStudent() {
    return compute(parseStudent, jsonString);
  }

  jsonParseDemo() {
    loadStudent().then((s) {
      String content = '''
        name: ${s.name}
        score:${s.score}
        teacher:${s.teacher[0].name}
      ''';
      print(content);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('HttpClient demo'),
              onPressed: () => httpClientDemo()
            ),
            RaisedButton(
              child: Text('Http demo'),
              onPressed: () => httpDemo()
            ),
            RaisedButton(
              child: Text('Dio demo'),
              onPressed: () => dioDemo()
            ),
            RaisedButton(
              child: Text('Dio 并发demo'),
              onPressed: () => dioParallDemo(),
            ),
            RaisedButton(
              child: Text('Dio 拦截'),
              onPressed: () => dioInterceptorReject(),
            ),
            RaisedButton(
              child: Text('Dio 缓存'),
              onPressed: () => dioIntercepterCache(),
            ),
            RaisedButton(
              child: Text('Dio 自定义header'),
              onPressed: () => dioIntercepterCustomHeader(),
            ),
            RaisedButton(
              child: Text('JSON解析demo'),
              onPressed: () => jsonParseDemo(),
            )
          ],
        ),
      ),
    );
  }
}

class Student {
  String id;
  String name;
  int score;
  List<TeacherItem> teacher;
  Student({this.id, this.name, this.score, this.teacher});

  //JSON解析工厂类，使用字典数据为对象初始化赋值
  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    return Student(
      id: parsedJson['id'],
      name : parsedJson['name'],
      score : parsedJson ['score'],
      teacher: TeacherList.fromJson(parsedJson['teacher']).list
    );
  }
}

class TeacherList {
  List<TeacherItem> list = List();
  TeacherList({this.list});

  TeacherList.fromJson(dynamic parsedJson) {
    parsedJson.forEach((value) {
      print(value);
      list.add(TeacherItem(
          name: value['name'],
          age: value['age']
      ));
    });
  }

}

class TeacherItem {
 String name;
 int age;
 TeacherItem({this.name ,this.age});


 //JSON解析工厂类，使用字典数据为对象初始化赋值
 factory TeacherItem.fromJson(Map<String, dynamic> parsedJson) {
   return TeacherItem(
       name: parsedJson['name'],
       age: parsedJson['age']
   );
 }
}
