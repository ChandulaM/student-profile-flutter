import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_profile/common/header.dart';
import 'package:student_profile/common/subject_item_card.dart';
import 'package:student_profile/models/Results.dart';
import 'package:student_profile/models/Student.dart';
import 'package:student_profile/models/Subject.dart';
import 'package:student_profile/screens/teacher/add_recommendation.dart';

import 'marks_widget.dart';

class StudentMarks extends StatefulWidget {
  final Student currentStudent;
  final List<Subject> subjectList;
  const StudentMarks(
      {Key? key, required this.currentStudent, required this.subjectList})
      : super(key: key);

  @override
  _StudentMarksState createState() => _StudentMarksState();
}

class _StudentMarksState extends State<StudentMarks> {
  String _currentStudentUid = "SH9ueZknoZbhEhWK5dWR";

  void navigateToNextScreen(Subject subject) {
  }

  Subject _findSubject(List<Subject> subjects, String subCode) {
    return subjects.firstWhere((subject) => subject.subCode == subCode);
  }

  @override
  Widget build(BuildContext context) {
    final currentStudent = widget.currentStudent;
    final subjectList = widget.subjectList;

    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: ListView.builder(
          itemCount: currentStudent.results.length,
          itemBuilder: (context, index) {
            Results currentResult = currentStudent.results[index];
            Subject currentSubject =
            _findSubject(subjectList, currentResult.subject);
            return ItemCard(
              onPressed: () {
                navigateToNextScreen(currentSubject);
              },
              contentToDisplay:
              SubjectMarks(currentSubject, marks: currentResult.mark),
            );
          }),
    );
  }
}