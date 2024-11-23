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
