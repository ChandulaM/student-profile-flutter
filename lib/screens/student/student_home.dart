import 'package:flutter/material.dart';
import 'package:student_profile/models/Student.dart';
import 'package:student_profile/screens/student/forums.dart';
import 'package:student_profile/screens/student/marks_tabbed_screen.dart';
import 'package:student_profile/screens/student/student_marks.dart';
import 'package:student_profile/screens/student/student_position.dart';
import 'package:student_profile/screens/student/student_profile.dart';
import 'package:student_profile/services/student_services.dart';
import 'package:provider/provider.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);
  static const String routeName = '/studentHome';

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  int _selectedIndex = 0;
  final List _studentScreens = [
    const StudentProfile(),
    const TabbedScreenMarks(),
    const StudentPosition(),
  ];

  void _onOptionSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _studentScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list), label: 'Subjects'),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_numbered), label: 'Position'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onOptionSelect,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
