import 'package:flutter/material.dart';

class TodayCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text('Today Card'),
      ),
    );
  }
}