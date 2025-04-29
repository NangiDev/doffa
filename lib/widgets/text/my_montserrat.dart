import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyMontserrat extends StatelessWidget {
  const MyMontserrat({
    super.key,
    required this.maxWidth,
    required this.text,
    this.sizeFactor = 1,
    this.color = Colors.white,
    this.fontWeight = FontWeight.w600,
  });

  final double maxWidth;
  final String text;
  final double sizeFactor;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: MyMontserrat.defaultStyle(
        maxWidth: maxWidth,
        sizeFactor: sizeFactor,
        color: color,
        fontWeight: fontWeight,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle defaultStyle({
    double maxWidth = 1000,
    double sizeFactor = 1,
    Color color = Colors.white,
    FontWeight fontWeight = FontWeight.w400,
    double height = 1.4,
  }) {
    return GoogleFonts.montserrat(
      fontSize: maxWidth / sizeFactor,
      color: color,
      fontWeight: fontWeight,
      height: 1,
    );
  }
}
