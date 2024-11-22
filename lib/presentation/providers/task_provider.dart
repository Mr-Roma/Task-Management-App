import 'package:flutter/material.dart';
import '../../domain/entities/task_entity.dart';

class TaskProvider with ChangeNotifier {
  final List<TaskEntity> _tasks = [];

  List<TaskEntity> get tasks => List.unmodifiable(_tasks);

  void addTask(TaskEntity task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(String taskId, TaskEntity updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  TaskEntity? getTaskById(String taskId) {
    return _tasks.firstWhere((task) => task.id == taskId,
        orElse: () => TaskEntity(
              id: '',
              title: '',
              description: '',
              createdDate: DateTime.now(),
              dueDate: DateTime.now(),
              status: '',
              priority: '',
            ));
  }
}
