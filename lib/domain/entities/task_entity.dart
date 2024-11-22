class TaskEntity {
  final String id;
  final String title;
  final String description;
  final DateTime createdDate;
  final DateTime dueDate;
  final String status;
  final String priority;

  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdDate,
    required this.dueDate,
    required this.status,
    required this.priority,
  });
}
