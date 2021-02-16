import 'package:flutter/material.dart';

import './modal/todo.dart';
import './widget/todo_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Todo> _todoList = [
    Todo(
      id: 't1',
      title: 'Buy dinner',
      date: DateTime.now(),
      time: TimeOfDay(hour: 00, minute: 00),
      complete: true,
    ),
    Todo(
      id: 't2',
      title: 'go to bad',
      date: DateTime.now(),
      time: TimeOfDay.now(),
      complete: false,
    ),
    Todo(
      id: 't2',
      title: 'go to bad',
      date: DateTime.now(),
      time: TimeOfDay.now(),
      complete: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              "Top Section",
            ),
            TodoList(_todoList),
          ],
        ),
      ),
    );
  }
}
