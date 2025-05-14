import 'package:doffa/providers/god_provider.dart';
import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyExpandableHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final double maxWidth;
  final Widget secondChild;
  final Widget? firstChild;
  final bool isExpanded;
  final bool isGraph;
  final VoidCallback onToggle;
  final Duration animationDuration;

  const MyExpandableHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.maxWidth,
    required this.secondChild,
    required this.isExpanded,
    this.isGraph = false,
    required this.onToggle,
    this.firstChild,
    this.animationDuration = const Duration(milliseconds: 100),
  });

  @override
  Widget build(BuildContext context) {
    GodProvider provider = context.read<GodProvider>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyMontserrat(
                    maxWidth: maxWidth,
                    text: title,
                    sizeFactor: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 8),
                  MyMontserrat(
                    maxWidth: maxWidth,
                    text: subtitle,
                    sizeFactor: 28,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              if (isGraph) _buildGraphSelectionButtons(provider),
              IconButton(
                icon: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                onPressed: onToggle,
              ),
            ],
          ),
        ),
        AnimatedCrossFade(
          duration: animationDuration,
          firstChild: firstChild ?? const SizedBox.shrink(),
          secondChild: secondChild,
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ),
      ],
    );
  }

  Widget _buildGraphSelectionButtons(GodProvider provider) => Align(
    alignment: Alignment.centerRight,
    child: Wrap(
      spacing: 8,
      children: [
        _periodButton('1M', provider.period == MonthPeriod.one, () {
          provider.period = MonthPeriod.one;
        }),
        _periodButton('2M', provider.period == MonthPeriod.two, () {
          provider.period = MonthPeriod.two;
        }),
        _periodButton('3M', provider.period == MonthPeriod.three, () {
          provider.period = MonthPeriod.three;
        }),
      ],
    ),
  );

  Widget _periodButton(String label, bool isSelected, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blueAccent : Colors.black45,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
        child: Text(
          label,
          style: MyMontserrat.defaultStyle(
            height: 1,
            sizeFactor: 96,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
