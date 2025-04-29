import 'package:flutter/material.dart';

class WordColor {
  final String _word;
  final Color color;

  const WordColor(String word, this.color) : _word = word;

  String get word => _word.toUpperCase();
}

final Map<int, WordColor> motivationScale = {
  -100: WordColor('Beginning', Color(0xFFFF3B30)),
  -90: WordColor('Noticing', Color(0xFFFF5E3A)),
  -80: WordColor('Awakening', Color(0xFFFF764A)),
  -70: WordColor('Checking In', Color(0xFFFF974F)),
  -60: WordColor('Curious', Color(0xFFFFB74D)),
  -50: WordColor('Reflective', Color(0xFFFFD54F)),
  -40: WordColor('Observant', Color(0xFFFFF176)),
  -30: WordColor('Aware', Color(0xFFE6EE9C)),
  -20: WordColor('Open', Color(0xFFAED581)),
  -10: WordColor('Warming Up', Color(0xFF81C784)),
  0: WordColor('Centered', Color(0xFF42A5F5)),
  10: WordColor('Motivated', Color(0xFF4FC3F7)),
  20: WordColor('Committed', Color(0xFF29B6F6)),
  30: WordColor('Steady', Color(0xFF26C6DA)),
  40: WordColor('Focused', Color(0xFF26A69A)),
  50: WordColor('Balanced', Color(0xFF66BB6A)),
  60: WordColor('Capable', Color(0xFF4CAF50)),
  70: WordColor('Energized', Color(0xFF43A047)),
  80: WordColor('Empowered', Color(0xFF388E3C)),
  90: WordColor('Confident', Color(0xFF2E7D32)),
  100: WordColor('Thriving', Color(0xFF1B5E20)),
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
