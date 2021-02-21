import 'package:flutter/material.dart';

import '../modal/todo.dart';

class TodayCard extends StatelessWidget {
  final List<Todo> todayTodo;
  TodayCard(this.todayTodo);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      // color: Colors.indigo,
      borderOnForeground: true,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Things To Do',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Container(
              // margin: EdgeInsets.all(100.0),
              decoration: BoxDecoration(
                // color: Color(0xFFB74093),
                shape: BoxShape.circle,
                border: Border.all(
                    width: 2.5, color: Theme.of(context).accentColor),
              ),
              padding: EdgeInsets.all(15),
              child: Text(
                '${todayTodo.length.toString()}',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
