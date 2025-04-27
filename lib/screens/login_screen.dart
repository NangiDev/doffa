import 'package:doffa/widgets/git_versioning.dart';
import 'package:doffa/widgets/my_button_card.dart';
import 'package:doffa/widgets/my_logo_tall.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 400, // Set max width (adjust as needed)
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 64,
              children: [MyLogoTall(), MyButtonCard(), GitVersioningWidget()],
            ),
          ),
        ),
      ),
    );
  }
}
