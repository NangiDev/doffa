import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyLogo extends StatelessWidget {
  const MyLogo({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              './assets/opt_prism_dark.svg',
              semanticsLabel: 'App Logo',
            ),
            Text(
              'DOFFA',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
