import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
              padding: const EdgeInsets.only(left: 16, right: 32),
              child: FittedBox(
                child: Text(
                  'DOFFA',
                  style: GoogleFonts.russoOne(
                    fontSize: 1000,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: FittedBox(
                child: Text(
                  'Track your fitness progress with precision',
                  style: GoogleFonts.montserrat(
                    fontSize: 1000,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    height: 1,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
