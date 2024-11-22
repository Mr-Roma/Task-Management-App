import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/task_entity.dart';
import '../providers/task_provider.dart';

class CreateTaskPage extends StatefulWidget {
  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _dueDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Task Description'),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(_dueDate != null
                    ? 'Due Date: ${_dueDate.toString()}'
                    : 'Select Due Date'),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    setState(() {
                      _dueDate = pickedDate;
                    });
                  },
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty &&
                    _dueDate != null) {
                  final task = TaskEntity(
                    id: DateTime.now().toString(),
                    title: _titleController.text,
                    description: _descriptionController.text,
                    createdDate: DateTime.now(),
                    dueDate: _dueDate!,
                    status: 'TODO',
                    priority: 'MEDIUM',
                  );

                  Provider.of<TaskProvider>(context, listen: false)
                      .addTask(task);

                  Navigator.pop(context);
                }
              },
              child: Text('Create Task'),
            ),
          ],
        ),
      ),
    );
  }
}
