import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProgressCard extends StatefulWidget {
  const MyProgressCard({super.key});

  @override
  State<MyProgressCard> createState() => _MyProgressCardState();
}

class _MyProgressCardState extends State<MyProgressCard> {
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
                "PROGRESS",
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
                "Changes between start and end date",
                style: GoogleFonts.montserrat(
                  fontSize: maxWidth / 28,
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
