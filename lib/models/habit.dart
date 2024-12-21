import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Habit {
  final String name;
  final Color color;
  List<bool> daysCompleted;
  int currentStreak;
  final bool isStrict; // Propiedad para definir si es estricto o flexible

  Habit({
    required this.name,
    required this.color,
    required this.daysCompleted,
    this.currentStreak = 0,
    this.isStrict = false, // Por defecto es flexible
  });
}
