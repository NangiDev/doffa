import 'package:doffa/screens/gradient_container.dart';
import 'package:doffa/widgets/my_doffa.dart';
import 'package:flutter/material.dart';

class OldHomeScreen extends StatelessWidget {
  const OldHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 400, maxWidth: 600),
            child: MyDoffa(),
          ),
        ),
      ),
    );
  }
}
