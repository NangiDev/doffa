import 'package:doffa/models/progress.dart';
import 'package:doffa/widgets/expandable_section.dart';
import 'package:flutter/material.dart';

class MyProgress extends StatelessWidget {
  final Progress progress;

  const MyProgress({super.key, required this.progress});
  @override
  Widget build(BuildContext context) {
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
                child: Text("${progress.days}", textAlign: TextAlign.left),
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
                child: Text("${progress.bmi}", textAlign: TextAlign.left),
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
                child: Text("${progress.kg}", textAlign: TextAlign.left),
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
                child: Text("${progress.fat}", textAlign: TextAlign.left),
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
                child: Text("${progress.lean}", textAlign: TextAlign.left),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
