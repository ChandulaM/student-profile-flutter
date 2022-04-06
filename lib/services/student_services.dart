import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_profile/models/Results.dart';
import 'package:student_profile/models/Student.dart';
import 'package:student_profile/models/Subject.dart';

class StudentServices {
  final CollectionReference studentCollection =
      FirebaseFirestore.instance.collection('students');

  final String _currentStudentId = "AhChICKVgush7by3Glex";

  Student _studentFromDocSnapshot(QueryDocumentSnapshot doc) {
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
                    mark: double.parse(res['mark'].toString()));
              }))
            : <Results>[],
        average: doc.data().toString().contains('average')
            ? double.parse(doc.get('average').toString())
            : 0.0);
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

  Stream<Student> getSingleStudent() {
    return studentCollection
        .doc(_currentStudentId)
        .snapshots()
        .map(Student.fromDocumentSnapshot);
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

  Future removeSubjectFromStudent(List<Subject> subjectList) async {
    List<Map<String, dynamic>> listToUpdate = [];
    for (var subject in subjectList) {
      listToUpdate
          .add({'subCode': subject.subCode, 'subject': subject.subject});
    }
    print(listToUpdate);
    studentCollection
        .doc(_currentStudentId)
        .update({"subjects": listToUpdate}).then(
            (value) => Fluttertoast.showToast(msg: "Unenrolled from course"));
  }

  Future<void> addUser(name, email, password) {
    String docId = studentCollection.doc().id;
    return studentCollection.doc(docId).set({
      'uid': docId,
      'name': name,
      'average': 0.0,
      'email': email,
      'password': password,
      'role': 'STU',
      'results': [],
      'subjects': []
    });
  }

  Future<void> deleteUser(id) {
    return studentCollection
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
