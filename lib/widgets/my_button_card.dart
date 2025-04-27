import 'package:doffa/widgets/my_login_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButtonCard extends StatelessWidget {
  const MyButtonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        return Container(
          width: maxWidth,
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
            padding: const EdgeInsets.all(32.0),
            child: Column(
              spacing: 16,
              mainAxisSize: MainAxisSize.min,
              children: [
                MyLoginButton(
                  icon: CupertinoIcons.bolt_fill,
                  label: "Login with Fitbit",
                  color: const Color(0xFF00B0B9),
                  onPressed: () async {},
                ),
                MyLoginButton(
                  icon: CupertinoIcons.play_circle_fill,
                  label: "Try Demo",
                  color: const Color(0xFF000000),
                  onPressed: () async {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
