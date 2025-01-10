import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/models/user_model.dart';

class AuthController with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = UserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email!,
        name: userCredential.user!.displayName ?? 'User',
      );
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Failed to sign in.";
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateDisplayName(name);
      _user = UserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email!,
        name: name,
      );
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Failed to sign up.";
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> checkAuthState() async {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        _user = UserModel(
          id: user.uid,
          email: user.email!,
          name: user.displayName ?? 'User',
        );
      } else {
        _user = null;
      }
      notifyListeners();
    });
  }
}
