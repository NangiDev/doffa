import 'package:doffa/widgets/cards/my_expandable_header.dart';
import 'package:doffa/widgets/my_container.dart';
import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';

class MyHistoryCard extends StatefulWidget {
  const MyHistoryCard({super.key});

  @override
  MyHistoryCardState createState() => MyHistoryCardState();
}

class MyHistoryCardState extends State<MyHistoryCard> {
  bool _isExpanded = false;

  void _handleToggle(bool expanded) {
    setState(() {
      _isExpanded = expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                initiallyExpanded: _isExpanded,
                onToggle: _handleToggle,
              ),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                firstChild: Container(),
                secondChild: Container(
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
                  ),
                ),
                crossFadeState:
                    _isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
              ),
            ],
          ),
        );
      },
    );
  }
}
