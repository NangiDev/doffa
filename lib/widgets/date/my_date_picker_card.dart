import 'package:doffa/common/models.dart';
import 'package:doffa/providers/god_provider.dart';
import 'package:doffa/widgets/my_container.dart';
import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDatePickerCard extends StatelessWidget {
  const MyDatePickerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GodProvider>();
    final days = provider.getDays();

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        return MyContainer(
          maxWidth: maxWidth,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyMontserrat(
                  maxWidth: maxWidth,
                  text: "INTERVAL - $days DAY(S)",
                  sizeFactor: 24,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const MyDatePicker(isStart: true),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white70,
                      size: maxWidth / 24,
                    ),
                    const MyDatePicker(isStart: false),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyDatePicker extends StatelessWidget {
  const MyDatePicker({super.key, required this.isStart});
  final bool isStart;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GodProvider>();
    final metric = isStart ? provider.startMetrics : provider.endMetrics;
    final title = isStart ? "Start Date" : "End Date";

    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;

          return InkWell(
            onTap: () => _pickDate(context, title, maxWidth, metric),
            borderRadius: BorderRadius.circular(4),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: _boxDecoration(),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.white70),
                  const SizedBox(width: 12),
                  Text(
                    metric.dateAsString,
                    style: MyMontserrat.defaultStyle(
                      maxWidth: maxWidth,
                      sizeFactor: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  BoxDecoration _boxDecoration() => BoxDecoration(
    color: const Color.fromARGB(255, 55, 55, 55),
    borderRadius: BorderRadius.circular(4),
    border: Border.all(color: Colors.white24),
  );

  Future<void> _pickDate(
    BuildContext context,
    String title,
    double maxWidth,
    Metrics metric,
  ) async {
    await showDialog<DateTime>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Material(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFF1E1E1E),
            child: Theme(
              data: _themeOverride(context),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyMontserrat(
                      text: title,
                      maxWidth: maxWidth,
                      fontWeight: FontWeight.w600,
                      sizeFactor: 8,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 300,
                      child: CalendarDatePicker(
                        initialDate: metric.date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        onDateChanged: (date) {
                          final provider = context.read<GodProvider>();
                          final updated =
                              isStart
                                  ? provider.startMetrics.copyWith(date: date)
                                  : provider.endMetrics.copyWith(date: date);

                          isStart
                              ? provider.setStartMetrics(updated)
                              : provider.setEndMetrics(updated);

                          Navigator.of(context).pop(date);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ThemeData _themeOverride(BuildContext context) {
    return Theme.of(context).copyWith(
      datePickerTheme: DatePickerThemeData(
        dayForegroundColor: WidgetStateProperty.resolveWith<Color?>(
          (states) =>
              states.contains(WidgetState.selected)
                  ? Colors.white
                  : Colors.white70,
        ),
        todayForegroundColor: WidgetStateProperty.all(Colors.white70),
        dayStyle: MyMontserrat.defaultStyle(
          maxWidth: 16,
          fontWeight: FontWeight.w400,
        ),
        yearStyle: MyMontserrat.defaultStyle(
          maxWidth: 16,
          fontWeight: FontWeight.w400,
        ),
        todayBackgroundColor: WidgetStateProperty.all(Colors.transparent),
        todayBorder: BorderSide.none,
      ),
    );
  }
}
