import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDatePickerCard extends StatelessWidget {
  const MyDatePickerCard({super.key});

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
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Text(
                  "INTERVAL - 50 DAYS",
                  style: GoogleFonts.montserrat(
                    fontSize: maxWidth / 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyDatePicker(title: "Start Date"),
                    MyDatePicker(title: "End Date"),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyDatePicker extends StatelessWidget {
  const MyDatePicker({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          return Expanded(
            child: TextField(
              controller: TextEditingController(),
              readOnly: true,
              style: GoogleFonts.montserrat(
                fontSize: maxWidth / 14,
                color: Colors.white,
                fontWeight: FontWeight.w300,
                height: 1,
              ),
              decoration: InputDecoration(
                labelText: title,
                labelStyle: GoogleFonts.montserrat(
                  fontSize: maxWidth / 12,
                  color: Colors.white70,
                  fontWeight: FontWeight.w300,
                ),
                prefixIcon: const Icon(
                  Icons.calendar_today,
                  color: Colors.white70,
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 55, 55, 55),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Colors.white24),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Colors.white24),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
