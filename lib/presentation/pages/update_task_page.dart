import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../../domain/entities/task_entity.dart';

class UpdateTaskPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final taskId = ModalRoute.of(context)!.settings.arguments as String;
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final task = taskProvider.tasks.firstWhere((task) => task.id == taskId);

    _titleController.text = task.title;
    _descriptionController.text = task.description;

    return Scaffold(
      appBar: AppBar(title: Text('Update Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value!.isEmpty ? 'Title cannot be empty' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedTask = TaskEntity(
                      id: task.id,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      createdDate: task.createdDate,
                      dueDate: task.dueDate,
                      status: task.status,
                      priority: task.priority,
                    );
                    taskProvider
                        .updateTask(taskId, updatedTask)
                        .then((_) => Navigator.pop(context));
                  }
                },
                child: Text('Update Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
