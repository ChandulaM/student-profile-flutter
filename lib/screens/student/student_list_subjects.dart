import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_profile/models/Results.dart';
import 'package:student_profile/models/Student.dart';
import 'package:student_profile/models/Subject.dart';
import 'package:student_profile/services/student_services.dart';

class ListAllSubjects extends StatefulWidget {
  final List<Subject> allSubjects;
  final Student student;
  const ListAllSubjects(
      {Key? key, required this.allSubjects, required this.student})
      : super(key: key);

  @override
  _ListAllSubjectsState createState() => _ListAllSubjectsState();
}

class _ListAllSubjectsState extends State<ListAllSubjects> {
  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue[300],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void enrollStudentInSubject(String studentId, Subject subject) async {
    StudentServices().updateStudentSubjects(studentId, subject).then((value) {
      showToast("Enrolled in subject successfully");
      StudentServices().updateStudentMarks(
          studentId, Results(subject: subject.subCode, mark: 0.0));
    }).catchError((err) => showToast("Something went wrong!"));
  }

  @override
  Widget build(BuildContext context) {
    final allSubjects = widget.allSubjects;
    final currentStudent = widget.student;

    bool hasStudentEnrolled(Subject currentSubject) {
      List<Subject> studentEnrolledSubjects = currentStudent.enrolledSubjects;

      int index = studentEnrolledSubjects
          .indexWhere((subject) => subject.subCode == currentSubject.subCode);

      return index > -1;
    }

    return ListView.builder(
        itemCount: allSubjects.length,
        itemBuilder: (context, index) => SubjectListItem(
            callback: () {
              enrollStudentInSubject(currentStudent.uid, allSubjects[index]);
            },
            subject: allSubjects[index],
            showButton: !hasStudentEnrolled(allSubjects[index])));
  }
}

class SubjectListItem extends StatelessWidget {
  final Subject subject;
  final bool showButton;
  final Function callback;
  const SubjectListItem(
      {Key? key,
      required this.subject,
      required this.showButton,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: 80.0,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '${subject.subject} [${subject.subCode}]',
                style: const TextStyle(fontSize: 16.0, letterSpacing: 0.6),
              ),
              const SizedBox(height: 6.0),
              Text(subject.subCode,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      letterSpacing: 0.8,
                      color: Colors.grey[400]))
            ]),
            showButton
                ? ElevatedButton(
                    onPressed: () {
                      callback();
                    },
                    child: const Text('ENROLL',
                        style: TextStyle(letterSpacing: 0.5)),
                  )
                : Text(
                    'Already enrolled',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14.0,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
