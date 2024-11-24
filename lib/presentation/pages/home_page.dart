import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/domain/usecases/create_task.dart';
import 'package:task_management_app/domain/usecases/update_task.dart';
import 'package:task_management_app/presentation/widgets/build_task.dart';
import '../providers/task_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TaskProvider>(context).tasks;
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
                                'Romario Marcal',
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
                              child: Stack(
                                children: [
                                  CircularProgressIndicator(
                                    value: 0.85,
                                    strokeWidth: 8,
                                    backgroundColor: Colors.white24,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                  Center(
                                    child: Text(
                                      '85%',
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
                      // Changed this part to use Column instead of nested ListView
                      // Replace the tasks.map section with this:
                      ...tasks
                          .map((task) => Padding(
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Icon(Icons.folder,
                                            color: Colors.blue),
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
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            padding: EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.blue.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: IconButton(
                                              icon: Icon(Icons.edit,
                                                  color: Colors.grey[600]),
                                              onPressed: () =>
                                                  showUpdateTaskDialog(
                                                      context, task),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Container(
                                            width: 40,
                                            height: 40,
                                            padding: EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.blue.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: IconButton(
                                              icon: Icon(Icons.delete,
                                                  color: Colors.red),
                                              onPressed: () {
                                                Provider.of<TaskProvider>(
                                                        context,
                                                        listen: false)
                                                    .deleteTask(task.id);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: InkWell(
              child: GestureDetector(
                onTap: () {
                  showCreateTaskDialog(context);
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF7E57C2),
                        Color(0xFF673AB7),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF673AB7).withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 32),
                ),
              ),
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // Your existing _buildProgressCard and _buildTaskGroup methods remain the same
}
