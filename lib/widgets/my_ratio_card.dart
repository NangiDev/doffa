import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRatioCard extends StatelessWidget {
  const MyRatioCard({super.key});

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
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Center(
              child: Column(
                spacing: 8,
                children: [
                  Text(
                    "RATIO",
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
                    "Overall Progress Quality",
                    style: GoogleFonts.montserrat(
                      fontSize: maxWidth / 32,
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      height: 1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
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
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        spacing: 8,
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
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF4AB358), Color(0xFF33723B)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(1000),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "EXCELLENT",
                                    style: GoogleFonts.montserrat(
                                      fontSize: maxWidth / 32,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      height: 1,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
