import 'package:doffa/api/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDatePickers extends StatefulWidget {
  final String title;

  const MyDatePickers({super.key, required this.title});

  @override
  MyDatePickersState createState() => MyDatePickersState();
}

class MyDatePickersState extends State<MyDatePickers> {
  DateTime? selectedDate;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.title == "Start Date") {
      _loadStartDate().then((_) {});
    } else {
      _setDate(DateTime.now());
    }
  }

  Future<void> _loadStartDate() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedStartDateString = prefs.getString('start_date');
    if (savedStartDateString != null) {
      setState(() {
        selectedDate = DateTime.parse(savedStartDateString);
        _controller.text = DateFormat('yyyy-MM-dd').format(selectedDate!);
      });
    } else {
      _setDate(DateTime.now());
    }

    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.fetchStartData(_controller.text);
  }

  void _setDate(DateTime date) {
    setState(() {
      selectedDate = date;
      _controller.text = DateFormat('yyyy-MM-dd').format(date);
    });

    // For Start Date, save it in SharedPreferences
    if (widget.title == "Start Date") {
      _saveStartDate(date);
    }

    // Trigger data fetch on date selection
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    if (widget.title == "Start Date") {
      apiProvider.fetchStartData(_controller.text);
    } else {
      apiProvider.fetchEndData(_controller.text);
    }
  }

  Future<void> _saveStartDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('start_date', DateFormat('yyyy-MM-dd').format(date));
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
