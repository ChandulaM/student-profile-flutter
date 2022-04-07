import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_profile/common/header.dart';
import 'package:student_profile/models/Recommendation.dart';
import 'package:student_profile/models/Student.dart';
import 'package:student_profile/models/Subject.dart';
import 'package:student_profile/screens/teacher/form_add_mark.dart';

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

    bool enrolledInSubject(Student student) {
      return student.enrolledSubjects
          .any((sub) => sub.subCode == subject.subCode);
    }

    final students = Provider.of<List<Student>>(context);
    //final studentRecommendations = Provider.of<List<Recommendation>>(context);
    final List<Student> enrolledStudents = [];
    for (var student in students) {
      if (enrolledInSubject(student)) enrolledStudents.add(student);
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Header(
              title: "Add Student Marks",
            ),
            const SizedBox(
              height: 12.0,
            ),
            Flexible(
              child: enrolledStudents.isNotEmpty
                  ? ListView.builder(
                      itemCount: enrolledStudents.length,
                      itemBuilder: ((context, index) => AddMarkForm(
                            student: enrolledStudents[index],
                            subject: subject,
                          )))
                  : const Center(
                      child: Text(
                        "No students have enrolled in this course",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
            )
          ]),
        ),
      ),
    );
  }
}
