// Create task dialog
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/domain/entities/task_entity.dart';
import 'package:task_management_app/presentation/providers/task_provider.dart';
import 'package:uuid/uuid.dart';

void showCreateTaskDialog(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Create Task',
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
                    final newTask = TaskEntity(
                      id: Uuid().v4(), // Generate a unique ID
                      title: _titleController.text,
                      description: _descriptionController.text,
                      createdDate: DateTime.now(),
                      dueDate: DateTime.now().add(Duration(days: 7)),
                      status: 'pending',
                      priority: 'low',
                    );

                    // Add the task to the provider and close the dialog
                    Provider.of<TaskProvider>(context, listen: false)
                        .addTask(newTask)
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
                  'Create Task',
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
