import 'package:flutter/material.dart';
import 'package:student_profile/screens/admin/admin_profile.dart';
import 'package:student_profile/screens/admin/manage_students.dart';
import 'package:student_profile/screens/admin/manage_teachers.dart';
import 'package:student_profile/screens/teacher/teacher_add_marks.dart';
import 'package:student_profile/screens/teacher/teacher_profile.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);
  static const String routeName = '/adminHome';

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _selectedIndex = 0;

  void _onOptionSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _adminScreens = [
    const ManageTeacher(),
    const ManageStudent(),
    const AdminProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _adminScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.post_add), label: 'Manage Teachers'),
          BottomNavigationBarItem(
              icon: Icon(Icons.post_add), label: 'Manage Students'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onOptionSelect,
      ),
    );
  }
}
