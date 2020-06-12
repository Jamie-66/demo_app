// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:demoapp/38_test_app/index.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  //第一个用例，判断Counter对象调用increase方法后是否等于1
  test('Increase a counter value should be 1', () {
    final counter = Counter();
    counter.increase();
    expect(counter.count, 1);
  });

  //第二个用例，判断1+1是否等于2
  test('1+1 should be 2', () {
    expect(1+1, 2);
  });

  //组合测试用例，判断Counter对象调用increase方法后是否等于1，并且判断Counter对象调用decrease方法后是否等于-1
  group('Counter', () {
    test('Increase a counter value should be 1', () {
      final counter = Counter();
      counter.increase();
      expect(counter.count, 1);
    });

    test('Decrease a counter value should be -1', () {
      final counter = Counter();
      counter.decrease();
      expect(counter.count, -1);
    });
  });

  group('fetchTodo', () {
    test('returns a Todo if successful', () async {
      final client = MockClient();

      //使用Mockito注入请求成功的JSON'字段
      when(client.get('https://xxx.com/todos/1'))
          .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));
      //验证请求结果是否为Todo实例
      expect(await fetchTodo(client), isInstanceOf<Todo>());
    });

    test('throws an exception if error', () {
      final client = MockClient();

      //使用Mockito注入请求失败的Error
      when(client.get('https://xxx.com/todos/1'))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //验证请求结果是否抛出异常
      expect(fetchTodo(client), throwsException);
    });
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    //声明所需要验证的Widget对象(即MyApp)，并触发其渲染
    await tester.pumpWidget(MyApp());

    //查找字符串文本为'0'的Widget，验证查找成功
    expect(find.text('0'), findsOneWidget);
    //查找字符串文本为'1'的Widget，验证查找失败
    expect(find.text('1'), findsNothing);

    //查找'+'按钮，施加点击行为
    await tester.tap(find.byIcon(Icons.add));
    //触发其渲染
    await tester.pump();

    //查找字符串文本为'0'的Widget，验证查找失败
    expect(find.text('0'), findsNothing);
    //查找字符串文本为'1'的Widget，验证查找成功
    expect(find.text('1'), findsOneWidget);
  });
}
