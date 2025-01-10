import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/models/user_model.dart';

class ProfileController with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> updateProfile(String name) async {
    try {
      await _auth.currentUser!.updateDisplayName(name);
      _user = UserModel(
        id: _auth.currentUser!.uid,
        email: _auth.currentUser!.email!,
        name: name,
      );
      notifyListeners();
    } catch (e) {
      throw "Failed to update profile.";
    }
  }

  Future<void> fetchUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      _user = UserModel(
        id: user.uid,
        email: user.email!,
        name: user.displayName ?? 'User',
      );
      notifyListeners();
    }
  }
}
