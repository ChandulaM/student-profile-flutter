import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_profile/common/header.dart';
import 'package:student_profile/common/loading.dart';
import 'package:student_profile/common/subject_item_card.dart';
import 'package:student_profile/models/Subject.dart';
import 'package:student_profile/models/Teacher.dart';
import 'package:student_profile/screens/student/marks_widget.dart';
import 'package:student_profile/screens/teacher/add_recommendation.dart';
import 'package:student_profile/services/teacher_service.dart';

class AddMarks extends StatefulWidget {
  const AddMarks({Key? key}) : super(key: key);

  @override
  _AddMarksState createState() => _AddMarksState();
}

class _AddMarksState extends State<AddMarks> {
  @override
  Widget build(BuildContext context) {
    void navigateToNextScreen(Subject subject) {
      Navigator.of(context).pushNamed(AddMarkAndRecommendation.routeName,
          arguments: {"subject": subject});
    }

    return StreamBuilder<Teacher>(
        stream: TeacherService().getTeacher,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Teacher? teacher = snapshot.data;
            List<Subject> subjectList = teacher!.subjects;

            return SafeArea(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Header(title: "Subjects"),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Flexible(
                      child: ListView.builder(
                          itemCount: subjectList.length,
                          itemBuilder: (context, index) {
                            Subject subject = subjectList[index];
                            return ItemCard(
                                onPressed: () {
                                  navigateToNextScreen(subject);
                                },
                                contentToDisplay: SubjectMarks(subject));
                          }))
                ],
              ),
            ));
          } else {
            return const Center(
              child: LoadingSpinner(),
            );
          }
        });
  }
}
