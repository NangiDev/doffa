import 'package:doffa/widgets/cards/my_expandable_header.dart';
import 'package:doffa/widgets/my_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProgressCard extends StatefulWidget {
  const MyProgressCard({super.key});

  @override
  State<MyProgressCard> createState() => _MyProgressCardState();
}

class _MyProgressCardState extends State<MyProgressCard> {
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
        final double maxWidth = constraints.maxWidth;

        return MyContainer(
          maxWidth: maxWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyExpandableHeader(
                title: "PROGRESS",
                subtitle: "Changes between start and end date",
                maxWidth: maxWidth,
                initiallyExpanded: _isExpanded,
                onToggle: _handleToggle,
              ),
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

  Widget _buildExpandedContent(double maxWidth) {
    return Column(
      children: [
        Container(
          width: maxWidth,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 55, 55, 55),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Metric",
                      style: GoogleFonts.montserrat(
                        fontSize: maxWidth / 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Change",
                        style: GoogleFonts.montserrat(
                          fontSize: maxWidth / 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Status",
                        style: GoogleFonts.montserrat(
                          fontSize: maxWidth / 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: maxWidth,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 35, 35, 35),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 8.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    spacing: 2,
                    children: [
                      Row(
                        spacing: 16,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "BMI",
                              style: GoogleFonts.montserrat(
                                fontSize: maxWidth / 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                height: 1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "29.5",
                                style: GoogleFonts.montserrat(
                                  fontSize: maxWidth / 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  height: 1,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "29.5",
                                style: GoogleFonts.montserrat(
                                  fontSize: maxWidth / 24,
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.w300,
                                  height: 1,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 2,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    spacing: 2,
                    children: [
                      Row(
                        spacing: 16,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Fat (%)",
                              style: GoogleFonts.montserrat(
                                fontSize: maxWidth / 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                height: 1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "29.5",
                                style: GoogleFonts.montserrat(
                                  fontSize: maxWidth / 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  height: 1,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "29.5",
                                style: GoogleFonts.montserrat(
                                  fontSize: maxWidth / 24,
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.w300,
                                  height: 1,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 2,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    spacing: 2,
                    children: [
                      Row(
                        spacing: 16,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Fat (kg)",
                              style: GoogleFonts.montserrat(
                                fontSize: maxWidth / 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                height: 1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "29.5",
                                style: GoogleFonts.montserrat(
                                  fontSize: maxWidth / 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  height: 1,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "29.5",
                                style: GoogleFonts.montserrat(
                                  fontSize: maxWidth / 24,
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.w300,
                                  height: 1,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 2,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    spacing: 2,
                    children: [
                      Row(
                        spacing: 16,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Lean (kg)",
                              style: GoogleFonts.montserrat(
                                fontSize: maxWidth / 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                height: 1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "29.5",
                                style: GoogleFonts.montserrat(
                                  fontSize: maxWidth / 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  height: 1,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "29.5",
                                style: GoogleFonts.montserrat(
                                  fontSize: maxWidth / 24,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w300,
                                  height: 1,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 2,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    spacing: 16,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Weight (kg)",
                          style: GoogleFonts.montserrat(
                            fontSize: maxWidth / 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            height: 1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "29.5",
                            style: GoogleFonts.montserrat(
                              fontSize: maxWidth / 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              height: 1,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "29.5",
                            style: GoogleFonts.montserrat(
                              fontSize: maxWidth / 24,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w300,
                              height: 1,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
