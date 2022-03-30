import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_profile/models/Results.dart';
import 'package:student_profile/models/Student.dart';
import 'package:student_profile/models/Subject.dart';

class StudentServices {
  final CollectionReference studentCollection =
      FirebaseFirestore.instance.collection('students');

  Student _studentFromDocSnapshot(QueryDocumentSnapshot doc) {
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
  }

  List<Student> _studentsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map(_studentFromDocSnapshot).toList();
  }

  Student _studentFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map(_studentFromDocSnapshot).first;
  }

  Stream<List<Student>> getStudents() {
    return studentCollection
        .orderBy('average')
        .snapshots()
        .map(_studentsFromSnapshot);
  }

  Future<dynamic> updateStudentMarks(String uid, Results result,
      {double? newAverage}) async {
    List<Map<String, dynamic>> updatedResult = [
      {"result": result.mark, "subject": result.subject}
    ];

    return await studentCollection.doc(uid).update(newAverage == null
        ? {"results": FieldValue.arrayUnion(updatedResult)}
        : {
            "average": newAverage,
            "results": FieldValue.arrayUnion(updatedResult)
          });
  }

  Future updateStudentSubjects(String uid, Subject subject) async {
    List<Map<String, dynamic>> subjectToAdd = [
      {"subject": subject.subject, "subCode": subject.subCode}
    ];

    return await studentCollection
        .doc(uid)
        .update({"subjects": FieldValue.arrayUnion(subjectToAdd)});
  }
}
