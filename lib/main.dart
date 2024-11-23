import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_management_app/presentation/pages/create_task_page.dart';
import 'package:task_management_app/presentation/pages/update_task_page.dart';
import 'presentation/providers/task_provider.dart';
import 'presentation/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        '/update': (context) => UpdateTaskPage(),
      },
    );
  }
}
