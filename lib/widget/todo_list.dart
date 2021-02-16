import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../modal/todo.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  TodoList(this.todos);

  @override
  Widget build(BuildContext context) {
    return todos.isEmpty
        ? Text(
            'empty',
          )
        : SizedBox(
            height: 600,
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (ctx, index) {
                return Card(
                  child: ListTile(
                    leading: Checkbox(
                      onChanged: (bool) => {},
                      value: todos[index].complete,
                    ),
                    title: Text(todos[index].title),
                    subtitle: Text(
                      '${DateFormat.yMMMd().format(todos[index].date)}',
                    ),
                    trailing: IconButton(
                      onPressed: () => {},
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
