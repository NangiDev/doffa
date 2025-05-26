import 'package:doffa/widgets/my_container.dart';
import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';

class MyAds extends StatelessWidget {
  const MyAds({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        return MyContainer(
          maxWidth: maxWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Center(
              child: MyMontserrat(
                maxWidth: maxWidth,
                text: "Google Ads",
                sizeFactor: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
  }
}
