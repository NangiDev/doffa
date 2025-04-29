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

  Widget _buildExpandedContent(double maxWidth) {
    return Container(
      width: maxWidth,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 55, 55, 55),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MyMontserrat(
              text: "Additional content displayed when expanded",
              maxWidth: maxWidth,
              sizeFactor: 24,
              fontWeight: FontWeight.w200,
            ),
          ],
        ),
      ),
    );
  }
}
