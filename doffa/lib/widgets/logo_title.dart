import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoTitle extends StatelessWidget {
  const LogoTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth > 400;
        return Flex(
          direction: isWide ? Axis.horizontal : Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/opt_prism_dark.svg', height: 120),
            SizedBox(width: isWide ? 12 : 8, height: isWide ? 0 : 8),
            const Text(
              'DOFFA',
              style: TextStyle(fontSize: 64, fontWeight: FontWeight.w300),
            ),
          ],
        );
      },
    );
  }
}
