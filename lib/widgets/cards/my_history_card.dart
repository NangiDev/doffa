import 'package:doffa/storage/storage.dart';
import 'package:doffa/widgets/cards/common/my_graph_card.dart';
import 'package:flutter/material.dart';

class MyHistoryCard extends StatelessWidget {
  const MyHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MyGraphCard(
      title: "HISTORY",
      subtitle: "Ratio over time",
      section: StorageKeys.expandedHistory,
    );
  }
}
