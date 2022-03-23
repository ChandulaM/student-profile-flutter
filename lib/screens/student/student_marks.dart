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
  const StudentMarks({Key? key}) : super(key: key);

  @override
  _StudentMarksState createState() => _StudentMarksState();
}

class _StudentMarksState extends State<StudentMarks> {
  String _currentStudentUid = "SH9ueZknoZbhEhWK5dWR";

  void navigateToNextScreen(Subject subject) {
    Navigator.of(context).pushNamed(ViewRecommendations.routeName,
        arguments: {"subject": subject, "student": _currentStudentUid});
  }

  Subject _findSubject(List<Subject> subjects, String subCode) {
    return subjects.firstWhere((subject) => subject.subCode == subCode);
  }

  @override
  Widget build(BuildContext context) {
    final currentStudent = Provider.of<List<Student>>(context)
        .firstWhere((student) => student.uid == _currentStudentUid);
    final subjectList = Provider.of<List<Subject>>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12.0,
            ),
            const Header(title: 'Enrolled Subjects'),
            const SizedBox(
              height: 12.0,
            ),
            Flexible(
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
                      contentToDisplay: SubjectMarks(currentSubject,
                          marks: currentResult.mark),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
