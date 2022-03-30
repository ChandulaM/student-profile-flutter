import 'package:flutter/material.dart';
import 'package:student_profile/screens/teacher/teacher_add_marks.dart';
import 'package:student_profile/screens/teacher/teacher_profile.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({Key? key}) : super(key: key);
  static const String routeName = '/teacherHome';

  @override
  _TeacherHomeState createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  int _selectedIndex = 0;

  void _onOptionSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _teacherScreens = [
    TeacherProfile(),
    AddMarks(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _teacherScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.post_add), label: 'Add Marks'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onOptionSelect,
      ),
    );
  }
}
