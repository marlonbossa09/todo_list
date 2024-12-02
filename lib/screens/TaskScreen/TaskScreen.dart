import 'package:flutter/material.dart';
import 'package:flutter_todo/viewModels/TaskViewModel/TaskViewModels.dart';
import 'package:provider/provider.dart';

// En esta vista está la parte visual del proyecto

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vistaDeTarea = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Gestor de Tareas')),
      body: vistaDeTarea.cargando
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: vistaDeTarea.tasks.length,
              itemBuilder: (context, index) {
                final task = vistaDeTarea.tasks[index];
                return ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(task.completed
                            ? Icons.check_box
                            : Icons.check_box_outline_blank),
                        onPressed: () => vistaDeTarea.toggleTaskCompletion(task.id),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => vistaDeTarea.deleteTask(task.id),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Nueva Tarea'),
        content: TextField(
          controller: titleController,
          decoration: InputDecoration(labelText: 'Título'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<TaskViewModel>(context, listen: false)
                  .addTask(titleController.text);
              Navigator.pop(context);
            },
            child: Text('Agregar'),
          ),
        ],
      ),
    );
  }
}
