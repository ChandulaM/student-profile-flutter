import 'package:flutter/material.dart';
import 'package:student_profile/models/Student.dart';

class Position extends StatelessWidget {
  final int position;
  final Student student;
  const Position({Key? key, required this.position, required this.student})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Text('$position ${student.name}'),
            RichText(
              text: TextSpan(
                  text: '$position \t',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text: ' ${student.name}',
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                  ]),
            ),
            Text(
              student.average.toStringAsFixed(2),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.blue[600]),
            )
          ],
        ),
      ),
    );
  }
}
