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
            MyData(),
            MyProgress(),
            MyRatio(),
            // AdsGoogle(),
          ],
        ),
      ),
    );
  }
}
