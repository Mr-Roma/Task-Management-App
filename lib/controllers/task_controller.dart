import 'package:flutter/material.dart'; // Import ChangeNotifier
import 'package:task_management_app/models/task_entity.dart';
import 'package:task_management_app/services/task_service.dart';

class TaskController extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  List<TaskEntity> tasks = [];

  Future<void> fetchTasks() async {
    tasks = await _taskService.getTasks();
    notifyListeners(); // Notify listeners after fetching tasks
  }

  Future<void> addTask(TaskEntity task) async {
    await _taskService.addTask(task);
    tasks.add(task);
    notifyListeners(); // Notify listeners after adding a task
  }

  Future<void> updateTask(TaskEntity task) async {
    await _taskService.updateTask(task);
    final index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = task;
      notifyListeners(); // Notify listeners after updating a task
    }
  }

  Future<void> deleteTask(String taskId) async {
    await _taskService.deleteTask(taskId);
    tasks.removeWhere((t) => t.id == taskId);
    notifyListeners(); // Notify listeners after deleting a task
  }
}
