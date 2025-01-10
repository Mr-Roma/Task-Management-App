import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/controllers/auth_controller.dart'; // Import AuthController
import 'package:task_management_app/controllers/task_controller.dart'; // Import TaskController
import 'package:task_management_app/models/task_entity.dart'; // Import TaskEntity
import 'package:task_management_app/views/dialogs/update_task.dart'; // Import update_task dialog
import 'package:task_management_app/views/widgets/build_task.dart'; // Import BuildTask widget

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch tasks when the page is initialized
    final taskController = Provider.of<TaskController>(context, listen: false);
    taskController.fetchTasks();
  }

  double calculateProgress(List<TaskEntity> tasks) {
    if (tasks.isEmpty) return 0.0;

    int completedTasks = tasks.where((task) => task.isCompleted).length;
    return completedTasks / tasks.length;
  }

  @override
  Widget build(BuildContext context) {
    final taskController = Provider.of<TaskController>(context);
    final authController = Provider.of<AuthController>(context);
    final tasks = taskController.tasks;

    // Update the tasks and calculate progress dynamically
    final todayTasks = tasks.where((task) => task.isTodayTask).toList();
    final completedTasks =
        todayTasks.where((task) => task.isCompleted).toList();
    double progress = todayTasks.isNotEmpty
        ? (completedTasks.length / todayTasks.length)
        : 0.0;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with profile
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text('RM'),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello!',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                authController.user?.name ?? 'User',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 24),

                      // Progress Card
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.deepPurple,
                              Colors.deepPurple.shade300
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your today's task",
                                  style: TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  'almost done!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text('View Task'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.deepPurple,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: Column(
                                children: [
                                  CircularProgressIndicator(
                                    value: progress,
                                    strokeWidth: 8,
                                    backgroundColor: Colors.white24,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                      '${(progress * 100).toInt()}%',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),

                      // In Progress Section
                      Text(
                        'In Progress',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            buildProgressCard(
                              'Do OOP Final Project',
                              'College Project',
                              Colors.blue,
                              0.7,
                            ),
                            SizedBox(width: 12),
                            buildProgressCard(
                              'Celebrate semproo',
                              'Personal Project',
                              Colors.orange,
                              0.4,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),

                      // Task Groups
                      Text(
                        'Task Lists',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),

                      ...tasks.map((task) => Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Folder icon container
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child:
                                        Icon(Icons.folder, color: Colors.blue),
                                  ),
                                  SizedBox(width: 16),
                                  // Task details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          task.title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          task.description,
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Actions
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          task.isTodayTask
                                              ? Icons.check_circle
                                              : Icons.circle_outlined,
                                          color: task.isTodayTask
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                        onPressed: () {
                                          // taskController.toggleTodayTask(task.id);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.edit,
                                            color: Colors.grey[600]),
                                        onPressed: () =>
                                            showUpdateTaskDialog(context, task),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          taskController.deleteTask(task.id);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
