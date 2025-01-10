import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/views/auth/login_or_register.dart';
import 'package:task_management_app/views/widgets/bottom_navbar_menu.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //User is Login
            if (snapshot.hasData) {
              return const BottomNavbar();
            }
            //User is not Login
            else {
              return const LoginOrRegister();
            }
          }),
    );
  }
}
