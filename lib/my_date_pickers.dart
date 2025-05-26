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
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateDate(DateTime.now()); // Initialize with current date
  }

  void _updateDate(DateTime date) {
    setState(() {
      selectedDate = date;
      _controller.text = DateFormat('yyyy-MM-dd').format(date);
    });
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDialog<DateTime>(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CalendarDatePicker(
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  onDateChanged: (DateTime date) {
                    Navigator.of(
                      context,
                    ).pop(date); // Close dialog and pass the selected date
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      _updateDate(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                readOnly: true, // Prevents manual editing
                onTap: _selectDate, // Opens picker on tap
                decoration: InputDecoration(
                  labelText: widget.title,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
