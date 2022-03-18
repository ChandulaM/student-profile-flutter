import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_profile/models/Results.dart';
import 'package:student_profile/models/Student.dart';
import 'package:student_profile/models/Subject.dart';

class StudentServices {
  final CollectionReference studentCollection =
      FirebaseFirestore.instance.collection('students');

  // <Results>[Results(subject: 'Maths', mark: 84)]

  List<Student> _studentsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      doc.data().toString().contains('subjects');
      return Student(
          uid: doc.reference.id,
          role: doc.data().toString().contains('role') ? doc.get('role') : '',
          name: doc.data().toString().contains('name') ? doc.get('name') : '',
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
              ? doc.get('average')
              : '');
    }).toList();
  }

  Stream<List<Student>> getStudents() {
    return studentCollection
        .orderBy('average')
        .snapshots()
        .map(_studentsFromSnapshot);
  }
}
