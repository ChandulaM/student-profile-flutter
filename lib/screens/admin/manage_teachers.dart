import 'package:flutter/material.dart';

class ManageTeacher extends StatefulWidget {
  const ManageTeacher({Key? key}) : super(key: key);

  @override
  _ManageTeacherState createState() => _ManageTeacherState();
}

class _ManageTeacherState extends State<ManageTeacher> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Manage Teachers'),
    );
  }
}
