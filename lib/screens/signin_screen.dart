import 'package:doffa/widgets/git_versioning.dart';
import 'package:doffa/widgets/my_logo_tall.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 42,
            children: [
              Ads(row: 1),
              MyLogoTall(),
              ButtonCard(),
              Ads(row: 2),
              Ads(row: 1),
              GitVersioningWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

// return Column(
//   children: [
//     Flexible(child: Container(color: Colors.lightBlueAccent)),
//     Flexible(child: Container(color: Colors.lightGreenAccent)),
//     Flexible(child: Container(color: Colors.redAccent)),
//     Flexible(child: Container(color: Colors.lightBlueAccent)),
//     Flexible(child: Container(color: Colors.lightGreenAccent)),
//     Flexible(child: Container(color: Colors.redAccent)),
//   ],
// );
// return Scaffold(
//   body: Center(
//     child: IntrinsicWidth(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         spacing: 42,
//         children: [
//           Ads(row: 1),
//           MyLogoTall(),
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF3A3A3A), Color(0xFF222222)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.all(Radius.circular(8)),
//               border: Border.all(color: Color(0xFF606060), width: 1),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: IntrinsicWidth(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     LoginButton(
//                       icon: const Icon(
//                         CupertinoIcons.bolt_fill,
//                         color: Colors.white,
//                       ),
//                       label: "Login with Fitbit",
//                       color: const Color(0xFF00B0B9),
//                       onPressed: () async {},
//                     ),
//                     const SizedBox(height: 16),
//                     LoginButton(
//                       icon: const Icon(
//                         CupertinoIcons.play_circle_fill,
//                         color: Colors.white,
//                       ),
//                       label: "Try Demo",
//                       color: const Color(0xFF000000),
//                       onPressed: () async {},
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Ads(row: 2),
//           Ads(row: 1),
//           GitVersioningWidget(),
//         ],
//       ),
//     ),
//   ),
// );

class ButtonCard extends StatelessWidget {
  const ButtonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3A3A3A), Color(0xFF222222)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Color(0xFF606060), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoginButton(
                icon: const Icon(CupertinoIcons.bolt_fill, color: Colors.white),
                label: "Login with Fitbit",
                color: const Color(0xFF00B0B9),
                onPressed: () async {},
              ),
              const SizedBox(height: 16),
              LoginButton(
                icon: const Icon(
                  CupertinoIcons.play_circle_fill,
                  color: Colors.white,
                ),
                label: "Try Demo",
                color: const Color(0xFF000000),
                onPressed: () async {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Ads extends StatelessWidget {
  final int row;
  const Ads({required this.row, super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.0, // Add spacing between items
      runSpacing: 8.0, // Add spacing between rows
      children: [
        for (int i = 0; i < row; i++)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3A3A3A), Color(0xFF222222)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: Color(0xFF606060), width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Google Ads',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
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

class LoginButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const LoginButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      // Center the button within its constraints
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 200,
          minHeight: 40,
        ), // Set maxWidth here
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: icon,
          label: Text(label),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            textStyle: GoogleFonts.montserrat(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w300,
              height: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }
}
