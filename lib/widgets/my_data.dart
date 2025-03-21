import 'package:doffa/models/data.dart';
import 'package:doffa/widgets/expandable_section.dart';
import 'package:flutter/material.dart';

class MyData extends StatelessWidget {
  final Data startData;
  final Data endData;

  const MyData({super.key, required this.startData, required this.endData});

  @override
  Widget build(BuildContext context) {
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
                  "${startData.date.year}-${startData.date.month.toString().padLeft(2, '0')}-${startData.date.day.toString().padLeft(2, '0')}",
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
                  "${endData.date.year}-${endData.date.month.toString().padLeft(2, '0')}-${endData.date.day.toString().padLeft(2, '0')}",
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Text("${startData.bmi}", textAlign: TextAlign.left),
              ),
              Expanded(
                child: Text(
                  "BMI",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text("${endData.bmi}", textAlign: TextAlign.right),
              ),
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Text("${startData.kg}", textAlign: TextAlign.left),
              ),
              Expanded(
                child: Text(
                  "KG",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text("${endData.kg}", textAlign: TextAlign.right),
              ),
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Text("${startData.fat}", textAlign: TextAlign.left),
              ),
              Expanded(
                child: Text(
                  "FAT",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text("${endData.fat}", textAlign: TextAlign.right),
              ),
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Text("${startData.lean}", textAlign: TextAlign.left),
              ),
              Expanded(
                child: Text(
                  "LEAN",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text("${endData.lean}", textAlign: TextAlign.right),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
