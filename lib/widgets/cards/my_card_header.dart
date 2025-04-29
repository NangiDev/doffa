import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';

class MyCardheader extends StatefulWidget {
  const MyCardheader({super.key, required this.maxWidth});
  final double maxWidth;

  @override
  State<MyCardheader> createState() => _MyCardheaderState();
}

class _MyCardheaderState extends State<MyCardheader> {
  bool _isExpanded = false;

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
                text: "DATA",
                sizeFactor: 18,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 8),
              MyMontserrat(
                maxWidth: widget.maxWidth,
                text: "Measurements",
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
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
        ],
      ),
    );
  }
}
