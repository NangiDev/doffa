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
        final progressData = {
          "DAYS": apiProvider.progress.days,
          "BMI": apiProvider.progress.bmi,
          "FAT": apiProvider.progress.fat,
          "LEAN": apiProvider.progress.lean,
          "WEIGHT": apiProvider.progress.kg,
        };

        return ExpandableSection(
          title: "Progress",
          storageKey: "progress_section_state",
          child: Column(
            children: [
              ...progressData.entries.map((entry) {
                return Row(
                  spacing: 16.0,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        entry.key,
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text("${entry.value}", textAlign: TextAlign.left),
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
}
