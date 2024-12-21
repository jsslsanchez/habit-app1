import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../models/habit.dart';
import '../widgets/habit_item.dart';
import 'habit_calendar_page.dart';

class HabitListPage extends StatefulWidget {
  const HabitListPage({super.key});

  @override
  _HabitListPageState createState() => _HabitListPageState();
}

class _HabitListPageState extends State<HabitListPage> {
  final List<Habit> _habits = [];

  // Añadir un hábito
  void _addHabit(String name, Color color) {
    setState(() {
      _habits.add(Habit(
          name: name,
          color: color,
          daysCompleted: List.filled(21, false),
          isStrict: true)); // Asignar isStrict como true por defecto
    });
    Navigator.of(context).pop();
  }

  // Editar hábito
  void _editHabit(int index, String newName, Color newColor) {
    setState(() {
      _habits[index] = Habit(
          name: newName,
          color: newColor,
          daysCompleted: _habits[index].daysCompleted);
    });
  }

  // Eliminar hábito
  void _deleteHabit(int index) {
    setState(() {
      _habits.removeAt(index);
    });
  }

  // Mostrar diálogo para añadir un hábito
  void _showAddHabitDialog() {
    String habitName = '';
    Color selectedColor = Colors.blue;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar Hábito'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Nombre del hábito'),
                onChanged: (value) {
                  habitName = value;
                },
              ),
              const SizedBox(height: 10),
              BlockPicker(
                pickerColor: selectedColor,
                onColorChanged: (color) {
                  selectedColor = color;
                },
              ),
              // Se elimina la sección de 'Estricto'
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _addHabit(habitName, selectedColor); // Se elimina isStrict
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  // Mostrar menú para editar/eliminar un hábito
  void _showHabitMenu(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar'),
              onTap: () {
                Navigator.of(context).pop();
                _showEditHabitDialog(index);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Eliminar'),
              onTap: () {
                Navigator.of(context).pop();
                _deleteHabit(index);
              },
            ),
          ],
        );
      },
    );
  }

  // Diálogo para editar el hábito
  void _showEditHabitDialog(int index) {
    String habitName = _habits[index].name;
    Color selectedColor = _habits[index].color;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _habitController =
            TextEditingController(text: habitName);

        return AlertDialog(
          title: const Text('Editar Hábito'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _habitController,
                decoration:
                    const InputDecoration(labelText: 'Nombre del hábito'),
                onChanged: (value) {
                  habitName = value;
                },
              ),
              const SizedBox(height: 10),
              BlockPicker(
                pickerColor: selectedColor,
                onColorChanged: (color) {
                  selectedColor = color;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                habitName = _habitController
                    .text; // Actualiza el valor del nombre del hábito
                _editHabit(index, habitName, selectedColor);
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _showHabitCalendar(Habit habit) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HabitCalendarPage(habit: habit),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Hábitos'),
      ),
      body: ListView.builder(
        itemCount: _habits.length,
        itemBuilder: (context, index) {
          final habit = _habits[index];
          return ListTile(
            title: Text(habit.name),
            leading: CircleAvatar(
              backgroundColor: habit.color,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => _showHabitMenu(context, index),
            ),
            onTap: () => _showHabitCalendar(habit),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddHabitDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
