import 'package:task_management_app/models/taskbase.dart';

class Task extends TaskBase {
  final bool isCompleted;
  final bool isTodayTask;

  Task({
    required String id,
    required String title,
    required String description,
    required this.isCompleted,
    required this.isTodayTask,
  }) : super(id: id, title: title, description: description);

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'task',
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'isTodayTask': isTodayTask,
    };
  }
}
