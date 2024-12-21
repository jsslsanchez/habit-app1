import 'package:flutter/material.dart';

class AddHabitDialog extends StatefulWidget {
  final Function(bool) onAddHabit;

  const AddHabitDialog({Key? key, required this.onAddHabit}) : super(key: key);

  @override
  _AddHabitDialogState createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFEB75A1),
      title: const Text(
        'Agregar Día',
        style: TextStyle(color: Colors.white),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '¿Completado?',
            style: TextStyle(color: Colors.white),
          ),
          Checkbox(
            activeColor: Colors.white,
            checkColor: Colors.pink,
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value ?? true;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.onAddHabit(isChecked);
          },
          child: const Text(
            'Agregar',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
