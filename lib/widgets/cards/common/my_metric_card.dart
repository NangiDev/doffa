import 'package:doffa/providers/god_provider.dart';
import 'package:doffa/storage/storage.dart';
import 'package:doffa/widgets/cards/common/my_expandable_header.dart';
import 'package:doffa/widgets/cards/common/my_expandable_table.dart';
import 'package:doffa/widgets/my_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyMetricCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final StorageKeys section;
  final List<MetricColumn> columns;

  const MyMetricCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.section,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GodProvider>();

    return FutureBuilder<bool>(
      future: provider.isExpanded(section),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final isExpanded = snapshot.data!;

        return LayoutBuilder(
          builder: (context, constraints) {
            final double maxWidth = constraints.maxWidth;

            return GestureDetector(
              onTap: () => provider.toggleExpanded(section),
              child: MyContainer(
                maxWidth: maxWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyExpandableHeader(
                      title: title,
                      subtitle: subtitle,
                      maxWidth: maxWidth,
                      isExpanded: isExpanded,
                      onToggle: () => provider.toggleExpanded(section),
                      secondChild: MyExpandableTable(
                        maxWidth: maxWidth,
                        columns: columns,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
