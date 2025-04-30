import 'package:doffa/common/models.dart';
import 'package:doffa/providers/metrics_provider.dart';
import 'package:doffa/widgets/my_container.dart';
import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDatePickerCard extends StatelessWidget {
  const MyDatePickerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final metricsProvider = context.watch<MetricsProvider>();
    final startMetrics = metricsProvider.startMetrics;
    final endMetrics = metricsProvider.endMetrics;
    final days = metricsProvider.getDays();

    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        return MyContainer(
          maxWidth: maxWidth,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                _buildTitle(maxWidth, days),
                _buildDatePickers(startMetrics, maxWidth, endMetrics),
              ],
            ),
          ),
        );
      },
    );
  }

  Row _buildDatePickers(
    Metrics startMetrics,
    double maxWidth,
    Metrics endMetrics,
  ) {
    return Row(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MyDatePicker(
          title: "Start Date",
          dateString: startMetrics.dateAsString,
        ),
        Icon(
          Icons.arrow_forward,
          color: Colors.white70,
          size: maxWidth / 24, // You can adjust the size
        ),
        MyDatePicker(title: "End Date", dateString: endMetrics.dateAsString),
      ],
    );
  }

  MyMontserrat _buildTitle(double maxWidth, int days) {
    return MyMontserrat(
      maxWidth: maxWidth,
      text: "INTERVAL - $days DAY(S)",
      sizeFactor: 24,
      fontWeight: FontWeight.w600,
    );
  }
}

class MyDatePicker extends StatelessWidget {
  const MyDatePicker({
    super.key,
    required this.title,
    required this.dateString,
  });

  final String title;
  final String dateString;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: dateString);

    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          return TextField(
            controller: controller,
            onTap: _pickDate,
            readOnly: true,
            style: MyMontserrat.defaultStyle(
              maxWidth: maxWidth,
              sizeFactor: 12,
              fontWeight: FontWeight.w400,
            ),
            decoration: _inputDecoration(maxWidth),
          );
        },
      ),
    );
  }

  void _pickDate() {
    // Implement the date picker logic here
    // For example, you can use showDatePicker to select a date
    // and then update the controller with the selected date.
  }

  InputDecoration _inputDecoration(double maxWidth) {
    return InputDecoration(
      labelText: title,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: MyMontserrat.defaultStyle(
        maxWidth: maxWidth,
        sizeFactor: 10,
        fontWeight: FontWeight.w400,
      ),
      prefixIcon: const Icon(Icons.calendar_today, color: Colors.white70),
      filled: true,
      fillColor: const Color.fromARGB(255, 55, 55, 55),
      border: _outlineInputBorder(),
      enabledBorder: _outlineInputBorder(),
      focusedBorder: _focusedBorder(),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Colors.white24),
    );
  }

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Colors.blueAccent),
    );
  }
}
