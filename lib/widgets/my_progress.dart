import 'package:doffa/api/api_provider.dart';
import 'package:doffa/widgets/expandable_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProgress extends StatelessWidget {
  const MyProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (context, apiProvider, child) {
        return ExpandableSection(
          title: "Progress",
          storageKey: "progress_section_state",
          child: Flex(
            direction: Axis.vertical,
            children: [
              Flex(
                spacing: 16.0,
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Text(
                      "DAYS",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${apiProvider.progress.days}",
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Flex(
                spacing: 16.0,
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Text(
                      "BMI",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${apiProvider.progress.bmi}",
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Flex(
                spacing: 16.0,
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Text(
                      "KG",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${apiProvider.progress.kg}",
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Flex(
                spacing: 16.0,
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Text(
                      "FAT",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${apiProvider.progress.fat}",
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Flex(
                spacing: 16.0,
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Text(
                      "LEAN",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${apiProvider.progress.lean}",
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
