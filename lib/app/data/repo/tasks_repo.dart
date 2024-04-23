import '../models/task.dart';

class TasksRepo {
  Task createTask(Map<String, dynamic> json) {
    return Task.fromJson(json);
  }

  Task editTask(Task task, Map<String, dynamic> json) {
    return task.copyWith(
      name: json['name'],
      description: json['description'],
      deadline: json['deadline'],
      assignedTo: json['assignedTo'],
    );
  }

  List<Task> getTasks(List<dynamic> json) {
    return json.map((task) => Task.fromJson(task)).toList();
  }
}
