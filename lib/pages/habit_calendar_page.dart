import 'package:calc_app/models/habit.dart';
import 'package:flutter/material.dart';

class HabitCalendarPage extends StatefulWidget {
  final Habit habit;

  const HabitCalendarPage({super.key, required this.habit});

  @override
  _HabitCalendarPageState createState() => _HabitCalendarPageState();
}

class _HabitCalendarPageState extends State<HabitCalendarPage> {
  late Habit habit;

  @override
  void initState() {
    super.initState();
    habit = widget.habit; // Inicializa el hábito
  }

  void _markDayAsCompleted(int dayIndex) {
    setState(() {
      // Marca como completado
      habit.daysCompleted[dayIndex] = true;
      // Aumenta la racha si el día no estaba fallido
      habit.currentStreak += 1;
    });
  }

  void _markDayAsFailed(int dayIndex) {
    setState(() {
      // Reinicia el contador de racha
      habit.currentStreak = 0;
      // Reinicia todos los días marcados como cumplidos
      for (int i = 0; i < habit.daysCompleted.length; i++) {
        habit.daysCompleted[i] = false; // Marca todos como no completados
      }
      habit.daysCompleted[dayIndex] =
          false; // Asegúrate de que el día fallido también esté marcado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(habit.name),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Racha actual: ${habit.currentStreak} días'),
            Expanded(
              child: ListView.builder(
                itemCount: habit.daysCompleted.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Día ${index + 1}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Mostrar el botón de completado solo si no ha sido completado
                        if (!habit.daysCompleted[index]) ...[
                          IconButton(
                            icon: const Icon(Icons.check),
                            color: Colors.green,
                            onPressed: () => _markDayAsCompleted(
                                index), // Marca como completado
                          ),
                          IconButton(
                            icon: const Icon(Icons.clear),
                            color: Colors.red,
                            onPressed: () =>
                                _markDayAsFailed(index), // Marca como fallido
                          ),
                        ]
                      ],
                    ),
                    leading: Checkbox(
                      value: habit.daysCompleted[index],
                      onChanged:
                          null, // Deshabilitado para evitar cambios accidentales
                    ),
                    // Muestra un mensaje si el día ya fue completado
                    subtitle:
                        habit.daysCompleted[index] ? Text('Completado') : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
