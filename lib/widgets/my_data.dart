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

        final dataEntries = {
          "DATE": [formatDate(startData.date), formatDate(endData.date)],
          "BMI": [startData.bmi, endData.bmi],
          "FAT": [startData.fat, endData.fat],
          "LEAN": [startData.lean, endData.lean],
          "WEIGHT": [startData.kg, endData.kg],
        };

        return ExpandableSection(
          title: "Data",
          storageKey: "data_section_state",
          child: Column(
            children: [
              ...dataEntries.entries.map((entry) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        entry.value[0].toString(),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        entry.key,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        entry.value[1].toString(),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                );
              }),
              const Divider(color: Colors.black12),
              const Text(
                "Fat, lean mass, and weight are measured in kilograms (kg).",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        );
      },
    );
  }

  String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
