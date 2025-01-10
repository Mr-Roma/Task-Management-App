import 'package:task_management_app/models/task_entity.dart';
import 'package:task_management_app/models/task_model.dart';

abstract class TaskBase {
  final String id;
  final String title;
  final String description;

  TaskBase({
    required this.id,
    required this.title,
    required this.description,
  });

  // Abstract properties and methods that subclasses must implement
  bool get isCompleted;
  bool get isTodayTask;
  Map<String, dynamic> toJson();

  /// Factory constructor to create a TaskBase instance
  factory TaskBase.fromJson(Map<String, dynamic> json) {
    if (json['type'] == 'task') {
      return Task(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        isCompleted: json['isCompleted'],
        isTodayTask: json['isTodayTask'],
      );
    } else if (json['type'] == 'taskEntity') {
      return TaskEntity(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        createdDate: DateTime.parse(json['createdDate']),
        dueDate: DateTime.parse(json['dueDate']),
        status: json['status'],
        priority: json['priority'],
      );
    } else {
      throw Exception('Unknown TaskBase type: ${json['type']}');
    }
  }
}
