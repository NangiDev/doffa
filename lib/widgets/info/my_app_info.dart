import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';

class MyAppInfo extends StatelessWidget {
  const MyAppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: FittedBox(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: MyMontserrat.defaultStyle(),
                children: [
                  TextSpan(
                    text:
                        'Version: ${const String.fromEnvironment('GIT_HASH', defaultValue: 'Unknown')}\n',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text: '© 2020 Doffa. All rights reserved.',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
