import 'package:flutter/material.dart';

import '../widgets/date_picker.dart';
import '../widgets/expandable_section.dart';
import '../widgets/logo_title.dart';
import '../widgets/progress_row.dart';
import '../widgets/ratio_box.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime startDate = DateTime.now();
  DateTime stopDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? startDate : stopDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          stopDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                spacing: 16,
                children: [
                  const LogoTitle(),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      bool isWide = constraints.maxWidth > 400;

                      var startPicker = DatePickerField(
                        label: 'Start Date',
                        date: startDate,
                        onTap: () => _selectDate(context, true),
                      );

                      var endPicker = DatePickerField(
                        label: 'Stop Date',
                        date: stopDate,
                        onTap: () => _selectDate(context, false),
                      );

                      return isWide
                          ? Row(
                            spacing: 16,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [startPicker, endPicker],
                          )
                          : Column(
                            spacing: 16,
                            mainAxisSize: MainAxisSize.min,
                            children: [startPicker, endPicker],
                          );
                    },
                  ),
                  const ExpandableSection(title: 'Graph', child: SizedBox()),
                  ExpandableSection(
                    title: 'Data',
                    child: Column(
                      children: [
                        ProgressRow(
                          values: ['2024-10-07', 'DATE', '2024-10-11'],
                        ),
                        ProgressRow(values: ['22.54', 'BMI', '22.46']),
                        ProgressRow(values: ['83.1', 'KG', '82.8']),
                        ProgressRow(values: ['14.25', 'FAT', '14.09']),
                        ProgressRow(values: ['68.85', 'LEAN', '68.71']),
                      ],
                    ),
                  ),
                  ExpandableSection(
                    title: 'Progess',
                    child: Column(
                      children: [
                        ProgressRow(
                          values: ['2024-10-07', 'DATE', '2024-10-11'],
                        ),
                        ProgressRow(values: ['22.54', 'BMI', '22.46']),
                        ProgressRow(values: ['83.1', 'KG', '82.8']),
                        ProgressRow(values: ['14.25', 'FAT', '14.09']),
                        ProgressRow(values: ['68.85', 'LEAN', '68.71']),
                      ],
                    ),
                  ),
                  const RatioBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
