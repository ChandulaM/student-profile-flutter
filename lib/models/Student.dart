import 'package:cloud_firestore/cloud_firestore.dart';
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
      required String email,
      required String password,
      required this.enrolledSubjects,
      required this.results,
      required this.average})
      : super(
            uid: uid, role: role, name: name, email: email, password: password);

  @override
  String toString() {
    return 'Student{enrolledSubjects: $enrolledSubjects, results: $results, average: $average}';
  }

  factory Student.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Student(
        uid: doc.reference.id,
        role: doc.data().toString().contains('role') ? doc.get('role') : '',
        name: doc.data().toString().contains('name') ? doc.get('name') : '',
        email: doc.data().toString().contains('email') ? doc.get('email') : '',
        password: doc.data().toString().contains('password')
            ? doc.get('password')
            : '',
        enrolledSubjects: doc.data().toString().contains('subjects')
            ? List<Subject>.from(doc.get('subjects').map((sub) {
                return Subject(
                    subject: sub['subject'], subCode: sub['subCode']);
              }))
            : <Subject>[],
        results: doc.data().toString().contains('results')
            ? List<Results>.from(doc.get('results').map((res) {
                return Results(
                    subject: res['subject'],
                    mark: double.parse(res['result'].toString()));
              }))
            : <Results>[],
        average: doc.data().toString().contains('average')
            ? double.parse(doc.get('average').toString())
            : 0.0);
  }
}
