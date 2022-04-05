import 'package:student_profile/models/Results.dart';
import 'package:student_profile/models/Subject.dart';
import 'package:student_profile/models/user.dart';

class Student extends User {
  final List<Subject> enrolledSubjects;
  final List<Results> results;
  final int average;

  Student(
      {required String uid,
      required String role,
      required String name,
      required this.enrolledSubjects,
      required this.results,
      required this.average})
      : super(uid: uid, role: role, name: name);

  @override
  String toString() {
    return 'Student{enrolledSubjects: $enrolledSubjects, results: $results, average: $average}';
  }
}
