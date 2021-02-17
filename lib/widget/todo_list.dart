import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../modal/todo.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function deleteTodo;
  final Function changeComplete;
  TodoList(this.todos, this.deleteTodo, this.changeComplete);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return todos.isEmpty
        ? Text(
            'empty',
          )
        : SizedBox(
            height: 600,
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (ctx, index) {
                final dateToCheck = todos[index].date;
                final aDate = DateTime(
                    dateToCheck.year, dateToCheck.month, dateToCheck.day);
                return Card(
                  child: ListTile(
                    leading: Checkbox(
                      onChanged: (bool) =>
                          {changeComplete(todos[index].id, bool)},
                      value: todos[index].complete,
                    ),
                    title: Text(todos[index].title),
                    subtitle: Text(
                      '${todos[index].time.format(context)} : ${today == aDate ? "Today" : DateFormat.yMMMd().format(todos[index].date)}',
                    ),
                    trailing: IconButton(
                      onPressed: () => deleteTodo(todos[index].id),
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
              },
            ),
          );
  }
}
