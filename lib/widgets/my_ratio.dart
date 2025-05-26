import 'package:flutter/material.dart';

class MyRatio extends StatelessWidget {
  const MyRatio({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          direction: Axis.vertical,
          children: [
            Text(
              '80/20',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
