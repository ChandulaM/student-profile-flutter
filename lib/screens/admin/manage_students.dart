import 'package:flutter/material.dart';

class ManageStudent extends StatefulWidget {
  const ManageStudent({Key? key}) : super(key: key);

  @override
  _ManageStudentState createState() => _ManageStudentState();
}

class _ManageStudentState extends State<ManageStudent> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Manage Students'),
    );
  }
}
