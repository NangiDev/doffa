import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GitVersioningWidget extends StatelessWidget {
  const GitVersioningWidget({super.key});

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
                style: GoogleFonts.montserrat(
                  fontSize: 1000,
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                  height: 1.4,
                ),
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
