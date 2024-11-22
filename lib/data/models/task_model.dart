import 'package:task_management_app/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required String id,
    required String title,
    required String description,
    required DateTime createdDate,
    required DateTime dueDate,
    required String status,
    required String priority,
  }) : super(
          id: id,
          title: title,
          description: description,
          createdDate: createdDate,
          dueDate: dueDate,
          status: status,
          priority: priority,
        );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdDate: DateTime.parse(json['createdDate']),
      dueDate: DateTime.parse(json['dueDate']),
      status: json['status'],
      priority: json['priority'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdDate': createdDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'status': status,
      'priority': priority,
    };
  }
}
