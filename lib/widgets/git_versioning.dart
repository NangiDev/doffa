import 'package:flutter/material.dart';

class GitVersioningWidget extends StatelessWidget {
  const GitVersioningWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Version: ${const String.fromEnvironment('GIT_HASH', defaultValue: 'Unknown')}',
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
