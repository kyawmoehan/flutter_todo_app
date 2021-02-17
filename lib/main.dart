import 'package:flutter/material.dart';

import './modal/todo.dart';
import './widget/todo_list.dart';
import './widget/today_card.dart';

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
      date: new DateTime.utc(2021, 2, 10),
      time: TimeOfDay(hour: 19, minute: 30),
      complete: true,
    ),
    Todo(
      id: 't2',
      title: 'go to bad',
      date: DateTime.now(),
      time: TimeOfDay(hour: 9, minute: 30),
      complete: false,
    ),
    Todo(
      id: 't3',
      title: 'plan todo',
      date: DateTime.now(),
      time: TimeOfDay(hour: 12, minute: 30),
      complete: false,
    ),
  ];

  void _deleteTodo(String id) {
    setState(() {
      _todoList.removeWhere((todo) => todo.id == id);
    });
  }

  void _changeComplete(String id, bool state) {
    var index = _todoList.indexWhere((todo) => todo.id == id);
    setState(() {
      _todoList[index].complete = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TodayCard(),
            TodoList(_todoList, _deleteTodo, _changeComplete),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {},
      ),
    );
  }
}
