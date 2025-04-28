import 'package:doffa/widgets/info/my_app_info.dart';
import 'package:doffa/widgets/ad/my_ads.dart';
import 'package:doffa/widgets/cards/my_button_card.dart';
import 'package:doffa/widgets/logo/my_logo_tall.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 400, // Set max width (adjust as needed)
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 64,
              children: [
                MyAds(),
                MyLogoTall(),
                MyButtonCard(),
                Column(
                  spacing: 8,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        Expanded(child: MyAds()),
                        Expanded(child: MyAds()),
                      ],
                    ),
                    MyAds(),
                  ],
                ),
                MyAppInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
