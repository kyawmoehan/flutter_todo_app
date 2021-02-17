import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Todo {
  final String id;
  final String title;
  final DateTime date;
  final TimeOfDay time;
  bool complete;

  Todo({
    @required this.id,
    @required this.title,
    @required this.date,
    @required this.time,
    @required this.complete,
  });
}
