import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/task_provider.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/create_task_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: TaskManagementApp(),
    ),
  );
}

class TaskManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/create': (context) => CreateTaskPage(),
      },
    );
  }
}
