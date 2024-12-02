import 'package:flutter/foundation.dart';
import 'package:flutter_todo/models/Task/Task.dart';
import 'package:flutter_todo/services/mockupService/MockupService.dart';

class TaskViewModel extends ChangeNotifier {
  final MockService servicio = MockService();
  List<Task> tareas = [];
  bool _cargando = false;

  // Se define lista de objetos de las tareas y el estado de carga
  List<Task> get tasks => tareas;
  bool get cargando => _cargando;

  // Obtener las tareas, se mapea los datos obtenidos y una vez obtenido se actualiza el estado 'cargando'
  Future<void> fetchTasks() async {
    _cargando = true;
    notifyListeners();

    final fetchedTasks = await servicio.fetchTasks();
    tareas = fetchedTasks.map((task) => Task.fromJson(task)).toList();

    _cargando = false;
    notifyListeners();
  }

  int _nuevoId = 3;

  // Crear las tareas, al ser local cree un contador para asignarlo a cada id que inicializa en 3 (Ya que hay datos de pruebas que iniciarían desde el 1 y2 )
  Future<void> addTask(String title) async {
    final newTask = Task(id: _nuevoId++, title: title); 
    await servicio.addTask(newTask.toJson()); 
    tareas.add(newTask); 
    notifyListeners();
  }

  Future<void> toggleTaskCompletion(int id) async {
    final taskIndex = tareas.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      final cambiarTarea = tareas[taskIndex];
      cambiarTarea.completed = !cambiarTarea.completed;  // Estado de completado

      await servicio.updateTask(id, cambiarTarea.toJson());
      tareas[taskIndex] = cambiarTarea;  // Se actualiza la lista
      notifyListeners();
    }
  }

  Future<void> deleteTask(int id) async {
    await servicio.deleteTask(id);
    tareas.removeWhere((task) => task.id == id); //Se elimina por id
    notifyListeners();
  }
}
