import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDataCard extends StatefulWidget {
  const MyDataCard({super.key});

  @override
  State<MyDataCard> createState() => _MyDataCardState();
}

class _MyDataCardState extends State<MyDataCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;

        return Container(
          width: maxWidth,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF3A3A3A), Color(0xFF222222)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF606060), width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(maxWidth),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                firstChild: const SizedBox.shrink(),
                secondChild: _buildExpandedContent(maxWidth),
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

  Widget _buildHeader(double maxWidth) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DATA",
                style: GoogleFonts.montserrat(
                  fontSize: maxWidth / 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                "Measurements",
                style: GoogleFonts.montserrat(
                  fontSize: maxWidth / 32,
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                  height: 1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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

  Widget _buildExpandedContent(double maxWidth) {
    return Container(
      width: maxWidth,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 55, 55, 55),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Metric Column
            Expanded(
              child: _buildColumn(
                maxWidth: maxWidth,
                fontWeight: FontWeight.w600,
                alignment: CrossAxisAlignment.start,
                values: const [
                  "Metric",
                  "BMI",
                  "Fat (%)",
                  "Fat (kg)",
                  "Lean (kg)",
                  "Weight (kg)",
                ],
              ),
            ),
            // First Date Column
            Expanded(
              child: _buildColumn(
                maxWidth: maxWidth,
                fontWeight: FontWeight.w300,
                alignment: CrossAxisAlignment.center,
                values: const [
                  "2025-01-01",
                  "24.5",
                  "18.2",
                  "14.6",
                  "65.3",
                  "80.1",
                ],
              ),
            ),
            // Second Date Column
            Flexible(
              flex: 0,
              child: _buildColumn(
                maxWidth: maxWidth,
                fontWeight: FontWeight.w300,
                alignment: CrossAxisAlignment.center,
                values: const [
                  "2025-05-25",
                  "24.5",
                  "18.2",
                  "14.6",
                  "65.3",
                  "80.1",
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColumn({
    required CrossAxisAlignment alignment,
    required double maxWidth,
    required FontWeight fontWeight,
    required List<String> values,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Column(
        spacing: 2,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: alignment,
        children:
            values
                .map(
                  (text) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      text,
                      style: GoogleFonts.montserrat(
                        fontSize: maxWidth / 28,
                        color: Colors.white,
                        fontWeight: fontWeight,
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
