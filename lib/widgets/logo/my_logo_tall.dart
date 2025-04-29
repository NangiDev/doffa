import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:doffa/widgets/text/my_russo_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyLogoTall extends StatelessWidget {
  const MyLogoTall({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              child: SvgPicture.asset(
                './assets/opt_prism_dark.svg',
                semanticsLabel: 'App Logo',
                width: maxWidth / 3,
                height: maxWidth / 3,
              ),
            ),
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FittedBox(
                child: MyRussoOne(text: 'DOFFA', maxWidth: 1000, sizeFactor: 1),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: FittedBox(
                child: MyMontserrat(
                  maxWidth: 1000,
                  text: 'Track your fitness progress with precision',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
