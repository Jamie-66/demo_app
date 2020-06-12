import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';

class DataPersistencePage extends StatefulWidget {
  final String title;
  DataPersistencePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DataPersistencePageState();
}

class _DataPersistencePageState extends State<DataPersistencePage> {
  fileDemo() {
    _readFileContent().then((value){
      print("before:$value");
      _writeFileContent('$value .').then((_){
        _readFileContent().then((value)=>print("after:$value"));
      });
    });
  }

  //创建文件目录
  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/content.txt');
  }

  //将字符串写入文件
  Future<File> _writeFileContent(String content) async {
    final file = await _localFile;

    // Write the file.
    return file.writeAsString(content);
  }

  //从文件读出字符串
  Future<String> _readFileContent() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return "";
    }
  }

  deleteDocument() async {
    try {
      final file = await _localFile;
      await file.delete();
    } catch (e) {
    }
  }

  spDemo() {
    _readSPCounter().then((value) {
      print("before:$value");
      _writeSPCounter().then((_) {
        _readSPCounter().then((value) {
          print("after:$value");
        });
      });
    });
  }

  //读取SharedPreferences中key为counter的值
  Future<int> _readSPCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0);
    return counter;
  }

  //递增写入SharedPreferences中key为counter的值
  Future<void> _writeSPCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    prefs.setInt('counter', counter);

  }

  deleteSP() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('counter');
    } catch (e) {
    }
  }

  int studentID = 123;

  dbDemo() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'students_database.db'),
      onCreate: (db, version) => db.execute("CREATE TABLE students(id TEXT PRIMARY KEY, name TEXT, score INTEGER)"),
      onUpgrade: (db, oldVersion, newVersion) => print("old:$oldVersion,new:$newVersion"),
      version: 1
    );

    Future<void> insertStudent(Student std) async {
      final Database db = await database;
      await db.insert(
        'students',
        std.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace
      );
    }

    Future<List<Student>> students() async {
      final Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query('students');
      return List.generate(maps.length, (i) => Student.fromJson(maps[i]));
    }

    var student1 = Student(id: '${++studentID}', name: '张三', score: 90);
    var student2 = Student(id: '${++studentID}', name: '李四', score: 80);
    var student3 = Student(id: '${++studentID}', name: '王五', score: 85);

    await insertStudent(student1);
    await insertStudent(student2);
    await insertStudent(student3);

    students().then((list) => list.forEach((s) => print('id: ${s.id}, name: ${s.name}, score: ${s.score}')));
    final Database db = await database;
    db.close();
  }

  deleteDB() async {
    String path = join(await getDatabasesPath(), 'students_database.db');
    await deleteDatabase(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('文件 demo'),
              onPressed: ()=>fileDemo(),
            ),
            RaisedButton(
              child: Text('删除文件'),
              onPressed: ()=>deleteDocument(),
            ),
            RaisedButton(
              child: Text('SharedPreference demo'),
              onPressed: ()=>spDemo(),
            ),
            RaisedButton(
              child: Text('删除SharedPreference'),
              onPressed: ()=>deleteSP(),
            ),
            RaisedButton(
              child: Text('数据库 demo'),
              onPressed: ()=>dbDemo(),
            ),
            RaisedButton(
              child: Text('删除数据库'),
              onPressed: ()=>deleteDB(),
            ),
          ],
        ),
      ),
    );
  }
}

class Student{
  String id;
  String name;
  int score;

  Student({this.id, this.name, this.score,});
  factory Student.fromJson(Map<String, dynamic> parsedJson){
    return Student(
      id: parsedJson['id'],
      name : parsedJson['name'],
      score : parsedJson ['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'score': score,};
  }
}
