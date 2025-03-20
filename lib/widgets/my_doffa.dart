import 'package:doffa/widgets/ads_google.dart';
import 'package:doffa/widgets/my_data.dart';
import 'package:doffa/widgets/my_date_pickers.dart';
import 'package:doffa/widgets/my_graph.dart';
import 'package:doffa/widgets/my_logo.dart';
import 'package:doffa/widgets/my_progress.dart';
import 'package:doffa/widgets/my_ratio.dart';
import 'package:flutter/material.dart';

class MyDoffa extends StatelessWidget {
  const MyDoffa({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 400, maxWidth: 600),
        child: Column(
          children: const [
            MyLogo(),
            MyDatePickers(title: "Start Date"),
            MyDatePickers(title: "End Date"),
            MyGraph(),
            MyData(),
            MyProgress(),
            MyRatio(),
            AdsGoogle(),
          ],
        ),
      ),
    );
  }
}
