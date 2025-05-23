import 'package:doffa/providers/god_provider.dart';
import 'package:doffa/services/service.dart';
import 'package:doffa/widgets/my_container.dart';
import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyButtonCard extends StatelessWidget {
  const MyButtonCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<GodProvider>();
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        return MyContainer(
          maxWidth: maxWidth,
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
                  onPressed: () async {
                    await provider.selectPlatform(PlatformProvider.fitbit);
                    await provider.logIn();
                  },
                ),
                MyLoginButton(
                  icon: CupertinoIcons.heart_fill,
                  label: "Login with Withings",
                  color: const Color(0xFF2aa77c),
                  onPressed: () async {
                    await provider.selectPlatform(PlatformProvider.withings);
                    await provider.logIn();
                  },
                ),
                MyLoginButton(
                  icon: CupertinoIcons.play_circle_fill,
                  label: "Try Demo",
                  color: const Color(0xFF000000),
                  onPressed: () async {
                    await provider.selectPlatform(PlatformProvider.demo);
                    await provider.logIn();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyLoginButton extends StatelessWidget {
  final IconData icon; // Use IconData instead of Widget
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const MyLoginButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        double iconSize = maxWidth / 10; // Adjust this value for icon scaling

        return ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(
            icon, // Directly use the IconData
            size: iconSize, // Set the icon size to scale with the width
          ),
          label: MyMontserrat(
            maxWidth: maxWidth,
            text: label,
            sizeFactor: 16,
            fontWeight: FontWeight.w400,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.all(16),
            minimumSize: Size(double.infinity, 48), // Ensure button fills width
          ),
        );
      },
    );
  }
}
