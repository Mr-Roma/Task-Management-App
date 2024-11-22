import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/presentation/providers/task_provider.dart';
import 'package:task_management_app/presentation/widgets/task_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management'),
      ),
      body: ListView.builder(
        itemCount: 10, // Example
        itemBuilder: (context, index) {
          return TaskCard(
            taskTitle: 'Task $index',
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<TaskProvider>(context, listen: false).deleteTask(
                    index.toString()); // Assuming task.id is index for example
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Task Creation Page
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
