import 'package:doffa/widgets/git_versioning.dart';
import 'package:doffa/widgets/my_ads.dart';
import 'package:doffa/widgets/my_data_card.dart';
import 'package:doffa/widgets/my_date_picker_card.dart';
import 'package:doffa/widgets/my_logo_wide.dart';
import 'package:doffa/widgets/my_progress_card.dart';
import 'package:doffa/widgets/my_ratio_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 8,
              children: [
                MyLogoWide(),
                MyDatePickerCard(),
                MyAds(),
                MyRatioCard(),
                // MyHistoryCard(),
                MyDataCard(),
                MyProgressCard(),
                MyAds(),
                MyAds(),
                GitVersioningWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
