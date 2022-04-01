import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_profile/common/header.dart';
import 'package:student_profile/common/subject_item_card.dart';
import 'package:student_profile/models/Results.dart';
import 'package:student_profile/models/Student.dart';
import 'package:student_profile/models/Subject.dart';
import 'package:student_profile/screens/student/view_recommendations.dart';
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
  void navigateToNextScreen(Subject subject) {
    Navigator.of(context).pushNamed(ViewRecommendations.routeName,
        arguments: {"subject": subject, "student": widget.currentStudent.uid});
  }

  Results _findResult(List<Results> results, String subCode) {
    return results.firstWhere((result) => result.subject == subCode);
  }

  @override
  Widget build(BuildContext context) {
    final currentStudent = widget.currentStudent;
    final subjectList = currentStudent.enrolledSubjects;

    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: ListView.builder(
          itemCount: subjectList.length,
          itemBuilder: (context, index) {
            Subject currentSubject = subjectList[index];
            Results currentResult =
                _findResult(currentStudent.results, currentSubject.subCode);
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
