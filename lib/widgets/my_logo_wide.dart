import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLogoWide extends StatelessWidget {
  const MyLogoWide({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        return Align(
          alignment: Alignment.centerLeft, // Align Row to the left
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment:
                MainAxisAlignment
                    .start, // Ensure the content starts at the left
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                './assets/opt_prism_dark.svg',
                semanticsLabel: 'App Logo',
                width: maxWidth / 6,
                height: maxWidth / 6,
              ),
              SizedBox(width: 16), // Add some space between the logo and text
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to the left
                children: [
                  Text(
                    'DOFFA',
                    style: GoogleFonts.russoOne(
                      fontSize:
                          maxWidth / 8, // Adjust font size based on maxWidth
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
