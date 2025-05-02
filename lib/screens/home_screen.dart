import 'package:doffa/widgets/buttons/my_coffee_button.dart';
import 'package:doffa/widgets/buttons/my_sign_out_button.dart';
import 'package:doffa/widgets/cards/my_data_card.dart';
import 'package:doffa/widgets/cards/my_progress_card.dart';
import 'package:doffa/widgets/cards/my_ratio_card.dart';
import 'package:doffa/widgets/date/my_date_picker_card.dart';
import 'package:doffa/widgets/info/my_app_info.dart';
import 'package:doffa/widgets/logo/my_logo_wide.dart';
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
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: MyLogoWide(),
                      ),
                    ),
                    Expanded(flex: 2, child: MyCoffeeButton()),
                    Expanded(flex: 2, child: MySignOutButton()),
                  ],
                ),
                MyDatePickerCard(),
                // MyAds(),
                MyRatioCard(),
                // MyHistoryCard(),
                MyDataCard(),
                MyProgressCard(),
                // MyAds(),
                // MyAds(),
                MyAppInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
