import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';

class MyExpandableHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final double maxWidth;
  final Widget secondChild;
  final Widget? firstChild;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Duration animationDuration;

  const MyExpandableHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.maxWidth,
    required this.secondChild,
    required this.isExpanded,
    required this.onToggle,
    this.firstChild,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
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
                    fontWeight: FontWeight.w100,
                  ),
                ],
              ),
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
}
