import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_profile/common/subject_item_card.dart';

import 'marks_widget.dart';

class StudentMarks extends StatefulWidget {
  const StudentMarks({Key? key}) : super(key: key);

  @override
  _StudentMarksState createState() => _StudentMarksState();
}

class _StudentMarksState extends State<StudentMarks> {
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
            Text(
              'Enrolled Subjects',
              style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5)),
            ),
            const SizedBox(
              height: 12.0,
            ),
            const ItemCard(
              contentToDisplay: SubjectMarks(),
            ),
            const ItemCard(
              contentToDisplay: SubjectMarks(),
            ),
            const ItemCard(
              contentToDisplay: SubjectMarks(),
            ),
          ],
        ),
      ),
    );
  }
}
