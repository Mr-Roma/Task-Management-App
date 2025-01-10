import 'package:task_management_app/models/task_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<TaskEntity>> getTasks() async {
    final snapshot = await _firestore.collection('tasks').get();
    return snapshot.docs.map((doc) => TaskEntity.fromJson(doc.data())).toList();
  }

  Future<void> addTask(TaskEntity task) async {
    await _firestore.collection('tasks').doc(task.id).set(task.toJson());
  }

  Future<void> updateTask(TaskEntity task) async {
    await _firestore.collection('tasks').doc(task.id).update(task.toJson());
  }

  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
  }
}
