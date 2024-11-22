import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String taskTitle;
  final Widget trailing;

  TaskCard({required this.taskTitle, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(taskTitle),
        trailing: trailing,
      ),
    );
  }
}
