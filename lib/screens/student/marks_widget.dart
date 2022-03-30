import 'package:flutter/material.dart';
import 'package:student_profile/models/Subject.dart';

class SubjectMarks extends StatelessWidget {
  final Subject subject;
  double marks;
  SubjectMarks(this.subject, {Key? key, this.marks = -1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subject.subject,
          style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.9,
              color: Colors.black),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          marks == -1 ? subject.subCode : marks.toString(),
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w300,
              color: Colors.grey[600]),
        ),
      ],
    );
  }
}
