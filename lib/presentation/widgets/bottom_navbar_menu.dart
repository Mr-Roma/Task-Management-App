import 'package:flutter/material.dart';
import 'package:task_management_app/domain/usecases/create_task.dart';
import 'package:task_management_app/presentation/pages/home_page.dart';
import 'package:task_management_app/presentation/pages/profile_page.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ProfilePage(),
    ProfilePage(),
  ];

  void _onItemTapped(int selectedIndex) {
    setState(() {
      _pageIndex = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageIndex], // Display the current page based on _pageIndex
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF673AB7), // Green color for selected item
        unselectedItemColor: Colors.grey, // Grey for unselected items
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
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
            label: 'Add', // Add a label here to fix the error
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
