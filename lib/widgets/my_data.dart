import 'package:doffa/api/api_provider.dart';
import 'package:doffa/widgets/expandable_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyData extends StatelessWidget {
  const MyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (context, apiProvider, child) {
        return ExpandableSection(
          title: "Data",
          storageKey: "data_section_state",
          child: Flex(
            direction: Axis.vertical,
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Text(
                      "${apiProvider.startData.date.year}-${apiProvider.startData.date.month.toString().padLeft(2, '0')}-${apiProvider.startData.date.day.toString().padLeft(2, '0')}",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "DATE",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${apiProvider.endData.date.year}-${apiProvider.endData.date.month.toString().padLeft(2, '0')}-${apiProvider.endData.date.day.toString().padLeft(2, '0')}",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Text(
                      "${apiProvider.startData.bmi}",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "BMI",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${apiProvider.endData.bmi}",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Text(
                      "${apiProvider.startData.kg}",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "KG",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${apiProvider.endData.kg}",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Text(
                      "${apiProvider.startData.fat}",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "FAT",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${apiProvider.endData.fat}",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Text(
                      "${apiProvider.startData.lean}",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "LEAN",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${apiProvider.endData.lean}",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ); // Moved this closing parenthesis here
      },
    );
  }
}
