import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTodo extends StatefulWidget {
  final Function addNewTodo;
  NewTodo(this.addNewTodo);

  @override
  _NewTodoState createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final _titleController = TextEditingController();
  DateTime _selectedDate;
  TimeOfDay _selectedTime;

  void _presentDatePicker() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2200),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  void _presentTimePicker() async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 00, minute: 00),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitData() {
    final enterTitle = _titleController.text;
    if (enterTitle.isEmpty || _selectedDate == null || _selectedTime == null) {
      return;
    }
    widget.addNewTodo(enterTitle, _selectedDate, _selectedTime);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          margin: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No Date Chosen'
                          : '${DateFormat.yMd().format(_selectedDate)}',
                    ),
                    FlatButton(
                      child: Text('Choose Date'),
                      onPressed: _presentDatePicker,
                    )
                  ],
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedTime == null
                          ? 'No Time Chosen'
                          : '${_selectedTime.format(context)}',
                    ),
                    FlatButton(
                      child: Text('Choose Time'),
                      onPressed: _presentTimePicker,
                    )
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submitData,
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Add New Todo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
