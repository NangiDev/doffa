import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:doffa/widgets/my_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDatePickerCard extends StatelessWidget {
  const MyDatePickerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        return MyContainer(
          maxWidth: maxWidth,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                MyMontserrat(
                  maxWidth: maxWidth,
                  text: "INTERVAL - 50 DAYS",
                  sizeFactor: 24,
                  fontWeight: FontWeight.w600,
                ),
                Row(
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyDatePicker(title: "Start Date"),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white70,
                      size: maxWidth / 24, // You can adjust the size
                    ),
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
          return TextField(
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
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: GoogleFonts.montserrat(
                fontSize: maxWidth / 10,
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
          );
        },
      ),
    );
  }
}
