import 'package:flutter/material.dart';
import 'package:student_profile/common/header.dart';
import 'package:student_profile/common/subject_item_card.dart';
import 'package:student_profile/models/Subject.dart';

import 'marks_widget.dart';

class StudentMarks extends StatefulWidget {
  const StudentMarks({Key? key}) : super(key: key);

  @override
  _StudentMarksState createState() => _StudentMarksState();
}

class _StudentMarksState extends State<StudentMarks> {
  void onTap() {
    print('tapped');
  }

  @override
  Widget build(BuildContext context) {
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
            ItemCard(
              onPressed: onTap,
              contentToDisplay: SubjectMarks(
                  Subject(subCode: 'MA001', subject: 'Maths'),
                  marks: 75.0),
            ),
            ItemCard(
                onPressed: onTap,
                contentToDisplay: SubjectMarks(
                    Subject(subCode: 'MA001', subject: 'Maths'),
                    marks: 75.0)),
            ItemCard(
                onPressed: onTap,
                contentToDisplay: SubjectMarks(
                    Subject(subCode: 'MA001', subject: 'Maths'),
                    marks: 75.0)),
          ],
        ),
      ),
    );
  }
}
