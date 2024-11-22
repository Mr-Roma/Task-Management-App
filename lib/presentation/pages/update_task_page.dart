import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/task_entity.dart';
import '../providers/task_provider.dart';

class UpdateTaskPage extends StatefulWidget {
  final String taskId;

  UpdateTaskPage({required this.taskId});

  @override
  _UpdateTaskPageState createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  late TaskEntity task;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    task = Provider.of<TaskProvider>(context, listen: false)
        .getTaskById(widget.taskId)!;
    _titleController = TextEditingController(text: task.title);
    _descriptionController = TextEditingController(text: task.description);
    _dueDate = task.dueDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Task')),
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
                  final updatedTask = TaskEntity(
                    id: task.id,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    createdDate: task.createdDate,
                    dueDate: _dueDate!,
                    status: task.status,
                    priority: task.priority,
                  );

                  Provider.of<TaskProvider>(context, listen: false)
                      .updateTask(task.id, updatedTask);

                  Navigator.pop(context);
                }
              },
              child: Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }
}
