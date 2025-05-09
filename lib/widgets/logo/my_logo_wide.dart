import 'package:doffa/widgets/text/my_russo_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyLogoWide extends StatelessWidget {
  const MyLogoWide({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        return Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                './assets/opt_prism_dark.svg',
                semanticsLabel: 'App Logo',
                width: maxWidth / 6,
                height: maxWidth / 6,
              ),
              SizedBox(width: 16),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyRussoOne(text: 'DOFFA', maxWidth: maxWidth, sizeFactor: 8),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
