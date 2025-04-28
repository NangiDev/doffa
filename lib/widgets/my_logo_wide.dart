import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLogoWide extends StatelessWidget {
  const MyLogoWide({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              './assets/opt_prism_dark.svg',
              semanticsLabel: 'App Logo',
              height: 64, // fixed height for logo
            ),
            SizedBox(width: 24),
            Text(
              'DOFFA',
              style: GoogleFonts.russoOne(
                fontSize: 64, // fixed font size
                color: Colors.white,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
