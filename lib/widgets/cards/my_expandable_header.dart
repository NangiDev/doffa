import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';

class MyExpandableHeader extends StatefulWidget {
  final String title;
  final String subtitle;
  final double maxWidth;
  final Widget secondChild;
  final Widget? firstChild;
  final bool initiallyExpanded;
  final Duration animationDuration;

  const MyExpandableHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.maxWidth,
    required this.secondChild,
    this.firstChild,
    this.initiallyExpanded = false,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<MyExpandableHeader> createState() => _MyExpandableHeaderState();
}

class _MyExpandableHeaderState extends State<MyExpandableHeader> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

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
                    maxWidth: widget.maxWidth,
                    text: widget.title,
                    sizeFactor: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 8),
                  MyMontserrat(
                    maxWidth: widget.maxWidth,
                    text: widget.subtitle,
                    sizeFactor: 28,
                    fontWeight: FontWeight.w100,
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                onPressed: _toggleExpanded,
              ),
            ],
          ),
        ),
        AnimatedCrossFade(
          duration: widget.animationDuration,
          firstChild: widget.firstChild ?? const SizedBox.shrink(),
          secondChild: widget.secondChild,
          crossFadeState:
              _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
        ),
      ],
    );
  }
}
