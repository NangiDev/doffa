import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDatePickers extends StatefulWidget {
  final String title;

  const MyDatePickers({super.key, required this.title});

  @override
  _MyDatePickersState createState() => _MyDatePickersState();
}

class _MyDatePickersState extends State<MyDatePickers> {
  DateTime? selectedDate;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setDate(DateTime.now());
  }

  void _setDate(DateTime date) {
    setState(() {
      selectedDate = date;
      _controller.text = DateFormat('yyyy-MM-dd').format(date);
    });
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: 300, // Adjust the width as per your need
            child: CalendarDatePicker(
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              onDateChanged: (date) => Navigator.of(context).pop(date),
            ),
          ),
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      _setDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          readOnly: true,
          onTap: _pickDate,
          decoration: InputDecoration(
            labelText: widget.title,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            suffixIcon: const Icon(Icons.calendar_today),
          ),
        ),
      ),
    );
  }
}
