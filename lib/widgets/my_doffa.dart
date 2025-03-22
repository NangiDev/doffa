import 'package:doffa/models/fetch_result.dart';
import 'package:doffa/widgets/my_coffee_button.dart';
import 'package:doffa/widgets/my_data.dart';
import 'package:doffa/widgets/my_date_pickers.dart';
import 'package:doffa/widgets/my_logo.dart';
import 'package:doffa/widgets/my_progress.dart';
import 'package:doffa/widgets/my_ratio.dart';
import 'package:doffa/widgets/my_sign_out_button.dart';
import 'package:flutter/material.dart';

class MyDoffa extends StatelessWidget {
  const MyDoffa({super.key});

  @override
  Widget build(BuildContext context) {
    final startData = Data(
      date: DateTime(2025, 3, 10),
      bmi: 24.5,
      kg: 75.0,
      fat: 20.0,
      lean: 60.0,
    );
    final endData = Data(
      date: DateTime(2025, 3, 20),
      bmi: 25.5,
      kg: 76.0,
      fat: 21.0,
      lean: 61.0,
    );

    final progress = Progress(
      days: 4,
      bmi: 24.5,
      kg: 75.0,
      fat: 20.0,
      lean: 60.0,
    );

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 400, maxWidth: 600),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [MyCoffeeButton(), MyLogo(), MySignOutButton()],
                ),
              ),
            ),
            MyDatePickers(title: "Start Date"),
            MyDatePickers(title: "End Date"),
            // MyGraph(),
            MyData(startData: startData, endData: endData),
            MyProgress(progress: progress),
            MyRatio(),
            // AdsGoogle(),
          ],
        ),
      ),
    );
  }
}
