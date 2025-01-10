import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/controllers/auth_controller.dart'; // Import AuthController
import 'package:task_management_app/views/auth/login_or_register.dart'; // Import LoginOrRegister
import 'package:task_management_app/views/pages/home_page.dart';
import 'package:task_management_app/views/widgets/bottom_navbar_menu.dart'; // Import HomePage

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    // Check if the user is already logged in
    if (authController.user != null) {
      return BottomNavbar();
    } else {
      return LoginOrRegister();
    }
  }
}
