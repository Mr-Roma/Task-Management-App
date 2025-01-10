import 'package:task_management_app/models/taskbase.dart';

class TaskEntity extends TaskBase {
  final DateTime createdDate;
  final DateTime dueDate;
  final String status;
  final String priority;

  TaskEntity({
    required String id,
    required String title,
    required String description,
    required this.createdDate,
    required this.dueDate,
    required this.status,
    required this.priority,
  }) : super(id: id, title: title, description: description);

  @override
  bool get isCompleted => status.toLowerCase() == 'completed';

  @override
  bool get isTodayTask {
    final now = DateTime.now();
    return dueDate.year == now.year &&
        dueDate.month == now.month &&
        dueDate.day == now.day;
  }

  @override
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

  /// Define the `fromJson` method
  factory TaskEntity.fromJson(Map<String, dynamic> json) {
    return TaskEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
      dueDate: DateTime.parse(json['dueDate'] as String),
      status: json['status'] as String,
      priority: json['priority'] as String,
    );
  }
}
