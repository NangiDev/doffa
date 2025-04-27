import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLogoTall extends StatelessWidget {
  const MyLogoTall({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          './assets/opt_prism_dark.svg',
          semanticsLabel: 'App Logo',
          width: 80,
          height: 80,
        ),
        const SizedBox(height: 8),
        Text(
          'DOFFA',
          style: GoogleFonts.russoOne(fontSize: 72, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          'Track your fitness progress with precision',
          style: GoogleFonts.montserrat(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
