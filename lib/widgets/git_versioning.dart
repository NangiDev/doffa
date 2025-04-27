import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GitVersioningWidget extends StatelessWidget {
  const GitVersioningWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Version: ${const String.fromEnvironment('GIT_HASH', defaultValue: 'Unknown')}',
          style: GoogleFonts.montserrat(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w100,
            height: 1,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          '© 2020 Doffa. All rights reserved.',
          style: GoogleFonts.montserrat(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w100,
            height: 1,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
