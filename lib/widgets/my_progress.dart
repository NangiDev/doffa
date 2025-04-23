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
          "DAYS": apiProvider.progress.days.toStringAsFixed(1),
          "BMI": apiProvider.progress.metrics.bmi.toStringAsFixed(1),
          "FAT": apiProvider.progress.metrics.fatInKg.toStringAsFixed(1),
          "LEAN": apiProvider.progress.metrics.leanInKg.toStringAsFixed(1),
          "WEIGHT": apiProvider.progress.metrics.weightInKg.toStringAsFixed(1),
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
                      child: Text(entry.value, textAlign: TextAlign.left),
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
