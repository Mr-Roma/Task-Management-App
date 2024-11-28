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

  // Getter for checking if the task is today's task
  bool get isTodayTask {
    final now = DateTime.now();
    return dueDate.year == now.year &&
        dueDate.month == now.month &&
        dueDate.day == now.day;
  }

  // Getter for checking if the task is completed
  bool get isCompleted => status.toLowerCase() == 'completed';

  // Convert to JSON
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

  // Factory constructor for creating TaskEntity from JSON
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

  // CopyWith method for creating modified copies
  TaskEntity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdDate,
    DateTime? dueDate,
    String? status,
    String? priority,
    required bool isTodayTask,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdDate: createdDate ?? this.createdDate,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      priority: priority ?? this.priority,
    );
  }
}
