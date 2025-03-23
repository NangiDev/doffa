import 'package:doffa/api/api_provider.dart';
import 'package:doffa/models/fetch_result.dart';
import 'package:doffa/widgets/expandable_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyData extends StatelessWidget {
  const MyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (context, apiProvider, child) {
        final startData = apiProvider.startData;
        final endData = apiProvider.endData;

        return ExpandableSection(
          title: "Data",
          storageKey: "data_section_state",
          child: Column(children: _buildDataRows(startData, endData)),
        );
      },
    );
  }

  List<Widget> _buildDataRows(Data startData, Data endData) {
    final labels = ["DATE", "BMI", "KG", "FAT", "LEAN"];
    final startValues = [
      "${startData.date.year}-${startData.date.month.toString().padLeft(2, '0')}-${startData.date.day.toString().padLeft(2, '0')}",
      "${startData.bmi}",
      "${startData.kg}",
      "${startData.fat}",
      "${startData.lean}",
    ];
    final endValues = [
      "${endData.date.year}-${endData.date.month.toString().padLeft(2, '0')}-${endData.date.day.toString().padLeft(2, '0')}",
      "${endData.bmi}",
      "${endData.kg}",
      "${endData.fat}",
      "${endData.lean}",
    ];

    return List.generate(labels.length, (index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(startValues[index], textAlign: TextAlign.right)),
          Expanded(
            child: Text(
              labels[index],
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(endValues[index], textAlign: TextAlign.left)),
        ],
      );
    });
  }
}
