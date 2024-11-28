class Task {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final bool isTodayTask;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.isTodayTask,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      isTodayTask: json['isTodayTask'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'isTodayTask': isTodayTask,
    };
  }
}
