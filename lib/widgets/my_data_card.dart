import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDataCard extends StatefulWidget {
  const MyDataCard({super.key});

  @override
  MyDataCardState createState() => MyDataCardState();
}

class MyDataCardState extends State<MyDataCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;

        return Container(
          width: maxWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3A3A3A), Color(0xFF222222)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Color(0xFF606060), width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      spacing: 8,
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
                        _isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
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
                        Text(
                          "100",
                          style: GoogleFonts.montserrat(
                            fontSize: maxWidth / 6,
                            color: Color.fromARGB(255, 109, 255, 129),
                            fontWeight: FontWeight.w900,
                            height: 1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Additional content displayed when expanded",
                          style: GoogleFonts.montserrat(
                            fontSize: maxWidth / 32,
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                            height: 1,
                          ),
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
