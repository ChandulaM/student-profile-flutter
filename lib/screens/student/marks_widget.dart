import 'package:flutter/material.dart';

class SubjectMarks extends StatelessWidget {
  const SubjectMarks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Maths',
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
              color: Colors.black),
        ),
        const SizedBox(
          height: 4.0,
        ),
        Text(
          '75.0',
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600]),
        ),
      ],
    );
  }
}
