import 'package:doffa/providers/ui_state_provider.dart';
import 'package:doffa/widgets/cards/common/my_expandable_header.dart';
import 'package:doffa/widgets/my_container.dart';
import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHistoryCard extends StatelessWidget {
  const MyHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final uiState = context.watch<UiStateProvider>();
    final isExpanded = uiState.isExpanded(ExpandableSection.history);

    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;

        return MyContainer(
          maxWidth: maxWidth,

          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyExpandableHeader(
                title: "HISTORY",
                subtitle: "Ratio over time",
                maxWidth: maxWidth,
                isExpanded: isExpanded,
                onToggle:
                    () => uiState.toggleExpanded(ExpandableSection.history),
                secondChild: _buildExpandedContent(maxWidth),
              ),
            ],
          ),
        );
      },
    );
  }

  Padding _buildExpandedContent(double maxWidth) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          MyMontserrat(
            text: "100",
            maxWidth: maxWidth,
            sizeFactor: 6,
            fontWeight: FontWeight.w900,
            color: Color.fromARGB(255, 109, 255, 129),
          ),
          MyMontserrat(
            text: "Additional content displayed when expanded",
            maxWidth: maxWidth,
            sizeFactor: 32,
            fontWeight: FontWeight.w200,
          ),
        ],
      ),
    );
  }
}
