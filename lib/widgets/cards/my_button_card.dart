import 'package:doffa/widgets/buttons/my_login_button.dart';
import 'package:doffa/widgets/my_container.dart';
import 'package:flutter/cupertino.dart';

class MyButtonCard extends StatelessWidget {
  const MyButtonCard({super.key});

  @override
  Widget build(BuildContext context) {
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
