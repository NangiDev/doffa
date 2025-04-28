import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLoginButton extends StatelessWidget {
  final IconData icon; // Use IconData instead of Widget
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const MyLoginButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        double iconSize = maxWidth / 10; // Adjust this value for icon scaling

        return ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(
            icon, // Directly use the IconData
            size: iconSize, // Set the icon size to scale with the width
          ),
          label: Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: maxWidth / 12, // Adjust text size based on width
              color: Colors.white,
              fontWeight: FontWeight.w300,
              height: 1,
            ),
            maxLines: 1, // Prevent text from wrapping
            overflow: TextOverflow.ellipsis, // Handle long text gracefully
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.all(16),
            minimumSize: Size(double.infinity, 48), // Ensure button fills width
          ),
        );
      },
    );
  }
}
