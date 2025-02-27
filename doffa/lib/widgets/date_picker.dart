import 'package:flutter/material.dart';

class DatePickerField extends StatefulWidget {
  final String label;
  final DateTime date;
  final VoidCallback onTap;

  const DatePickerField({
    super.key,
    required this.label,
    required this.date,
    required this.onTap,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _formatDate(widget.date));
  }

  @override
  void didUpdateWidget(covariant DatePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.date != oldWidget.date) {
      _controller.text = _formatDate(widget.date);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static String _formatDate(DateTime date) =>
      "${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}";

  static String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: widget.label,
          border: OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        controller: _controller,
        onTap: widget.onTap,
      ),
    );
  }
}
