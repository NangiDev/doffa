import 'package:doffa/api/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRatio extends StatelessWidget {
  const MyRatio({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (context, apiProvider, child) {
        return Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Flex(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              direction: Axis.vertical,
              children: [
                Text(
                  "${apiProvider.ratio.lean}/${apiProvider.ratio.fat}",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
