// Update task dialog
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/domain/entities/task_entity.dart';
import 'package:task_management_app/presentation/providers/task_provider.dart';

void showUpdateTaskDialog(BuildContext context, TaskEntity task) {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController(text: task.title);
  final _descriptionController = TextEditingController(text: task.description);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Update Task',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Title cannot be empty'
                    : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
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

                    // Update the task in the provider and close the dialog
                    Provider.of<TaskProvider>(context, listen: false)
                        .updateTask(task.id, updatedTask)
                        .then((_) {
                      Navigator.of(context).pop(); // Close the dialog
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $error')),
                      );
                    });
                  }
                },
                child: Text(
                  'Update Task',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
