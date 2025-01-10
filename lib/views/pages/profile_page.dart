import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/views/auth/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void singUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            AuthPage())); // Navigate back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile Header
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 3,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/profile.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Romario Marcal',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '081343568832',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Account Settings Section
                _buildSectionTitle('Account Setting'),
                _buildSettingItem(
                  OnTap: () {},
                  icon: Icons.language,
                  title: 'Choose language',
                  color: Colors.blue.withOpacity(0.1),
                ),
                _buildSettingItem(
                  OnTap: () {},
                  icon: Icons.notifications_none,
                  title: 'Notification',
                  color: Colors.blue.withOpacity(0.1),
                ),
                const SizedBox(height: 24),

                // Other Settings Section
                _buildSectionTitle('Other Settings'),
                _buildSettingItem(
                  OnTap: () {},
                  icon: Icons.headset_mic_outlined,
                  title: 'Call center',
                  color: Colors.blue.withOpacity(0.1),
                ),
                _buildSettingItem(
                  OnTap: () {},
                  icon: Icons.description_outlined,
                  title: 'Terms & Conditions',
                  color: Colors.blue.withOpacity(0.1),
                ),
                _buildSettingItem(
                  OnTap: () {},
                  icon: Icons.star_outline,
                  title: 'Rated',
                  color: Colors.blue.withOpacity(0.1),
                ),
                const SizedBox(height: 24),

                // Logout Section
                _buildSectionTitle('LogOut'),
                _buildSettingItem(
                  OnTap: () {},
                  icon: Icons.delete_outline,
                  title: 'Delete Account',
                  color: Colors.red,
                  titleColor: Colors.red,
                ),
                _buildSettingItem(
                  OnTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            "Alert!",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          content: Text(
                            "Confirm to LogOut?",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                singUserOut(context);
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icons.logout,
                  title: 'Logout',
                  color: Colors.red,
                  titleColor: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required VoidCallback OnTap,
    required IconData icon,
    required String title,
    required Color color,
    Color? titleColor,
  }) {
    return GestureDetector(
      onTap: OnTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
                color: titleColor ?? Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
