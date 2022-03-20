import 'package:flutter/material.dart';
import 'package:student_profile/models/Subject.dart';

class AddMarkAndRecommendation extends StatefulWidget {
  const AddMarkAndRecommendation({Key? key}) : super(key: key);
  static const String routeName = '/teacherAddMarks';

  @override
  _AddMarkAndRecommendationState createState() =>
      _AddMarkAndRecommendationState();
}

class _AddMarkAndRecommendationState extends State<AddMarkAndRecommendation> {
  @override
  Widget build(BuildContext context) {
    final subjectObj =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Subject subject = subjectObj['subject'];
    print(subject);
    return const Center(
      child: Text('Navigated'),
    );
  }
}
