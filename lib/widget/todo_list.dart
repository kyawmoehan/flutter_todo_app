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
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'No Transcations!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    // height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : SizedBox(
            height: 600,
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (ctx, index) {
                final dateToCheck = todos[index].date;
                final aDate = DateTime(
                    dateToCheck.year, dateToCheck.month, dateToCheck.day);
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        onChanged: (bool) =>
                            {changeComplete(todos[index].id, bool)},
                        value: todos[index].complete,
                      ),
                      title: Text(
                        todos[index].title,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      subtitle: Text(
                        '${todos[index].time.format(context)} : ${today == aDate ? "Today" : DateFormat.yMMMd().format(todos[index].date)}',
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      trailing: IconButton(
                        onPressed: () => deleteTodo(todos[index].id),
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
