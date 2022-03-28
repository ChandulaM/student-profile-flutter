import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_profile/common/header.dart';
import 'package:student_profile/models/Student.dart';
import 'package:student_profile/screens/student/positions_widget.dart';

class StudentPosition extends StatefulWidget {
  const StudentPosition({Key? key}) : super(key: key);

  @override
  _StudentPositionState createState() => _StudentPositionState();
}

class _StudentPositionState extends State<StudentPosition> {
  @override
  Widget build(BuildContext context) {
    String currentStudent = "3CVWupNZ5zsf0EF2vfzp";
    final students = Provider.of<List<Student>>(context);
    int noOfStudents = students.length;
    int currentPostion =
        students.indexWhere((student) => student.uid == currentStudent);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12.0,
            ),
            const Header(title: "Class Ranking"),
            const SizedBox(
              height: 12.0,
            ),
            Container(
              width: double.infinity,
              height: 70.0,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Center(
                child: Text(
                  'Your class ranking: ${currentPostion + 1}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Flexible(
                child: ListView.builder(
                    itemCount: noOfStudents,
                    itemBuilder: (context, index) {
                      return Position(
                          position: noOfStudents - index,
                          student: students[index]);
                    }))
          ],
        ),
      ),
    );
  }
}
