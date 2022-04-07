import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_profile/models/Subject.dart';
import 'package:student_profile/models/user.dart';

class Teacher extends User {
  final List<Subject> subjects;

  Teacher(
      {required String uid,
      required String role,
      required String name,
      required String email,
      required String password,
      required this.subjects})
      : super(
            uid: uid, role: role, name: name, email: email, password: password);

  @override
  String toString() {
    return 'Teacher{subjects: $subjects}';
  }
}
