class MockService {
List<Map<String, dynamic>> tasks = [
{ "id": 1, "title": "Tarea de ejemplo 1", "completed": false },
{ "id": 2, "title": "Tarea de ejemplo 2", "completed": true }
];
Future<List<Map<String, dynamic>>> fetchTasks() async {
await Future.delayed(Duration(seconds: 1)); // Simula tiempo de red
return tasks;
}
Future<void> addTask(Map<String, dynamic> task) async {
await Future.delayed(Duration(milliseconds: 500));
tasks.add(task);
}
Future<void> updateTask(int id, Map<String, dynamic> updatedTask) async {
await Future.delayed(Duration(milliseconds: 500));
tasks = tasks.map((task) => task['id'] == id ? updatedTask : task).toList();
}
Future<void> deleteTask(int id) async {
await Future.delayed(Duration(milliseconds: 500));
tasks.removeWhere((task) => task['id'] == id);
}
}