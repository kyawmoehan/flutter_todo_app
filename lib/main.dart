import 'dart:io';
import 'package:flutter/material.dart';

import './modal/todo.dart';
import './widget/todo_list.dart';
import './widget/today_card.dart';
import './widget/new_todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(
        primaryColor: Color(0xff355d69),
        // primarySwatch: Color(0xff355d69),
        accentColor: Color(0xff355d69),
        fontFamily: 'Roboto',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              caption: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              subtitle: TextStyle(
                fontFamily: 'Opensans',
                fontSize: 16,
                color: Colors.grey,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Opensans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
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

  bool _showCard = false;

  List<Todo> get _todayTodo {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    var getTodayTodo = _todoList.where((todo) {
      final dateToCheck = todo.date;
      return today ==
          DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    }).toList();
    return getTodayTodo;
  }

  void _addNewTodo(String title, DateTime chosenDate, TimeOfDay chosenTime) {
    final newTodo = Todo(
      id: DateTime.now().toString(),
      title: title,
      date: chosenDate,
      time: chosenTime,
      complete: false,
    );
    setState(() {
      _todoList.insert(0, newTodo);
    });
  }

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

  void _startAddNewTodo(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return NewTodo(_addNewTodo);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = AppBar(
      title: Text('Todo'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => {_startAddNewTodo(context)},
        )
      ],
    );

    final todoListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TodoList(_todoList, _deleteTodo, _changeComplete),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show Card',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    onChanged: (val) {
                      setState(() {
                        _showCard = val;
                      });
                    },
                    value: _showCard,
                  ),
                ],
              ),
            if (!isLandScape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: TodayCard(_todayTodo),
              ),
            if (!isLandScape) todoListWidget,
            if (isLandScape)
              _showCard
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: TodayCard(_todayTodo),
                    )
                  : todoListWidget,
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => {_startAddNewTodo(context)},
            ),
    );
  }
}
