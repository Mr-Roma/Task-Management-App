import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/task_entity.dart';

class TaskProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<TaskEntity> _tasks = [];

  List<TaskEntity> get tasks => List.unmodifiable(_tasks);

  /// Add a new task to Firestore and update the local list
  Future<void> addTask(TaskEntity task) async {
    try {
      await _firestore
          .collection('tasks')
          .doc(task.id.toString())
          .set(task.toJson());
      _tasks.add(task);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  void toggleTodayTask(String taskId) {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      // Example logic to toggle the 'isTodayTask' or similar property
      // Update the logic according to your task model
      final task = _tasks[taskIndex];
      // Perform your toggle operation here
      notifyListeners();
    }
  }

  /// Update an existing task in Firestore and the local list
  Future<void> updateTask(String taskId, TaskEntity updatedTask) async {
    try {
      await _firestore
          .collection('tasks')
          .doc(taskId)
          .update(updatedTask.toJson());
      final index = _tasks.indexWhere((task) => task.id == taskId);
      if (index != -1) {
        _tasks[index] = updatedTask;
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  /// Delete a task from Firestore and the local list
  Future<void> deleteTask(String id) async {
    try {
      await _firestore.collection('tasks').doc(id).delete();
      _tasks.removeWhere((task) => task.id == id);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  /// Fetch tasks from Firestore and update the local list
  Future<void> fetchTasks() async {
    try {
      final querySnapshot = await _firestore.collection('tasks').get();
      _tasks.clear();
      for (var doc in querySnapshot.docs) {
        _tasks.add(TaskEntity.fromJson(doc.data()));
      }
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }
}
