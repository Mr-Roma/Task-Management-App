import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/controllers/task_controller.dart'; // Import TaskController
import 'package:task_management_app/models/task_entity.dart'; // Import TaskEntity

void showUpdateTaskDialog(BuildContext context, TaskEntity task) {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController(text: task.title);
  final _descriptionController = TextEditingController(text: task.description);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Update Task'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Title cannot be empty'
                    : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedTask = TaskEntity(
                      id: task.id, // Keep the same ID for the task
                      title: _titleController.text,
                      description: _descriptionController.text,
                      createdDate: task.createdDate,
                      dueDate: task.dueDate,
                      status: task.status,
                      priority: task.priority,
                    );

                    // Access TaskController using the correct context
                    final taskController =
                        Provider.of<TaskController>(context, listen: false);
                    taskController.updateTask(updatedTask).then((_) {
                      Navigator.of(context).pop(); // Close the dialog
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $error')),
                      );
                    });
                  }
                },
                child: Text('Update Task'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
