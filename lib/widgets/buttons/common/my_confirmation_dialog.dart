import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';

void showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String confirmText,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: MyMontserrat(text: title, maxWidth: 20),
          content: MyMontserrat(
            text: message,
            maxWidth: 12,
            color: Colors.white70,
            fontWeight: FontWeight.w400,
          ),
          backgroundColor: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white70),
            borderRadius: BorderRadius.circular(8),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              child: const MyMontserrat(
                text: 'Cancel',
                maxWidth: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
                backgroundColor: Colors.greenAccent,
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              child: MyMontserrat(
                text: confirmText,
                maxWidth: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
  );
}
