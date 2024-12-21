import 'package:flutter/material.dart';

class CompletionDialog extends StatelessWidget {
  const CompletionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFEB75A1),
      title: const Text(
        '¡Felicidades!',
        style: TextStyle(color: Colors.white),
      ),
      content: const Text(
        '¡Hábito completado después de 21 días!',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Aceptar',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
