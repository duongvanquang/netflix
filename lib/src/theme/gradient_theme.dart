import 'package:flutter/material.dart';

class GradientTheme {
  static const pinkGradient = LinearGradient(
    colors: [
      Color(0xFF5f0a87),
      Color(0xFFa4508b),
    ],
    end: Alignment.topLeft,
    begin: Alignment.bottomRight,
    stops: [0.0, 1.0],
  );
}
