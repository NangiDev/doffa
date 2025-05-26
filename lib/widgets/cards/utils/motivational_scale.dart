import 'package:flutter/material.dart';

class WordColor {
  final String _word;
  final Color color;

  const WordColor(String word, this.color) : _word = word;

  String get word => _word.toUpperCase();
}

final Map<int, WordColor> motivationScale = {
  -100: WordColor('Beginning', const Color(0xFFFF5252)), // pastel red
  -90: WordColor('Noticing', const Color(0xFFFF6D6D)),
  -80: WordColor('Awakening', const Color(0xFFFF8585)),
  -70: WordColor('Checking In', const Color(0xFFFF9D9D)),
  -60: WordColor('Curious', const Color(0xFFFFB6B6)),
  -50: WordColor('Reflective', const Color(0xFFFFCFCF)),
  -40: WordColor('Observant', const Color(0xFFD0D4FA)), // fading toward blue
  -30: WordColor('Aware', const Color(0xFFB0C5FA)),
  -20: WordColor('Open', const Color(0xFF90B5FA)),
  -10: WordColor('Warming Up', const Color(0xFF70A6FA)),
  0: WordColor('Centered', const Color(0xFF448AFF)), // pastel blue
  10: WordColor('Motivated', const Color(0xFF63B9DD)),
  20: WordColor('Committed', const Color(0xFF7FCFBF)),
  30: WordColor('Steady', const Color(0xFF8CDBAD)),
  40: WordColor('Focused', const Color(0xFF98E79A)),
  50: WordColor('Balanced', const Color(0xFFA3F288)),
  60: WordColor('Capable', const Color(0xFFADF67A)),
  70: WordColor('Energized', const Color(0xFFB7F96D)),
  80: WordColor('Empowered', const Color(0xFFBFFB67)),
  90: WordColor('Confident', const Color(0xFFC8FD61)),
  100: WordColor('Thriving', const Color(0xFF69F0AE)), // pastel green
};

WordColor getWordColor(int ratio) {
  final rounded = (ratio / 10).round() * 10;
  return motivationScale[rounded] ??
      const WordColor("Keep Going", Colors.white);
}

/// Function to determine the text color based on the background color
Color readableTextColor(Color backgroundColor) {
  // Compute luminance: 0 (black) to 1 (white)
  final brightness = backgroundColor.computeLuminance();
  return brightness > 0.5 ? Colors.black : Colors.white;
}
