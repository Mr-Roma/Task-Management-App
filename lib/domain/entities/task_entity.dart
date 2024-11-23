class TaskEntity {
  final String id; // Firestore Document ID
  final String title;
  final String description;
  final DateTime createdDate;
  final DateTime dueDate;
  final String status; // e.g., "TODO", "In Progress", "Done"
  final String priority; // e.g., "Low", "Medium", "High"

  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdDate,
    required this.dueDate,
    required this.status,
    required this.priority,
  });

  // Convert to JSON for Firestore
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
      id: json['id'] ?? '', // Provide a default empty string for null id
      title: json['title'] ?? 'Untitled Task', // Provide a default title
      description:
          json['description'] ?? 'No description', // Default description
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : DateTime.now(), // Default to current time
      dueDate: json['dueDate'] != null
          ? DateTime.parse(json['dueDate'])
          : DateTime.now(), // Default to current time
      status: json['status'] ?? 'TODO', // Default status
      priority: json['priority'] ?? 'Medium', // Default priority
    );
  }
}
