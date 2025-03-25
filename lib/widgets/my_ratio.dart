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
              spacing: 8.0,
              children: [
                Text(
                  "Doffa Ratio",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "${apiProvider.ratio.lean} / ${apiProvider.ratio.fat}",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Divider(color: Colors.black12),
                const Text(
                  "Left side is fat mass, right side is lean mass.\nThe number represents the percentage of the weight change.",
                  style: TextStyle(fontStyle: FontStyle.italic),
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
