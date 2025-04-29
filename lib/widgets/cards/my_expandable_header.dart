import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';

class MyExpandableHeader extends StatefulWidget {
  final String title;
  final String subtitle;
  final double maxWidth;
  final ValueChanged<bool> onToggle;
  final bool initiallyExpanded;

  const MyExpandableHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.maxWidth,
    required this.onToggle,
    this.initiallyExpanded = false,
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
    widget.onToggle(_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            onPressed: _toggleExpanded,
          ),
        ],
      ),
    );
  }
}
