import 'package:flutter/material.dart';

class HabitItem extends StatelessWidget {
  final bool isChecked;
  final int dayCount;

  const HabitItem({
    Key? key,
    required this.isChecked,
    required this.dayCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 1.0),
          borderRadius: BorderRadius.circular(15.0),
          color: isChecked ? Colors.green[200] : Colors.red[400],
        ),
        child: Center(
          child: Text(
            isChecked
                ? '✔️ Tarea Completada día $dayCount'
                : '❌ Tarea No Completada día $dayCount',
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
