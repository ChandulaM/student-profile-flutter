import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_profile/models/Subject.dart';
import 'package:student_profile/models/Teacher.dart';

class TeacherService {
  final CollectionReference _teacherCollectionRef =
      FirebaseFirestore.instance.collection('teachers');

  final String _currentTeacherId = 'YmUYgt6k5dJ4KzkJgsLq';

  Teacher _teacherFromSnapshot(DocumentSnapshot snapshot) {
    return Teacher(
      uid: snapshot.id,
      role: snapshot.data().toString().contains('uid')
          ? snapshot.get('role')
          : '',
      name: snapshot.data().toString().contains('name')
          ? snapshot.get('name')
          : '',
      email: snapshot.data().toString().contains('email')
          ? snapshot.get('email')
          : '',
      password: snapshot.data().toString().contains('password')
          ? snapshot.get('password')
          : '',
      subjects: snapshot.data().toString().contains('subjects')
          ? List<Subject>.from(snapshot.get('subjects').map((sub) {
              return Subject(subject: sub['subject'], subCode: sub['subCode']);
            }))
          : <Subject>[],
    );
  }

  Stream<Teacher> get getTeacher {
    return _teacherCollectionRef
        .doc(_currentTeacherId)
        .snapshots()
        .map(_teacherFromSnapshot);
  }

  List<Teacher> _teachersFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map(_teacherFromSnapshot).toList();
  }

  Stream<List<Teacher>> getTeachers() {
    return _teacherCollectionRef.snapshots().map(_teachersFromSnapshot);
  }

  Future registerTeacher(Teacher teacher) async {
    String docId = _teacherCollectionRef.doc().id;
    final teacherSubjects = teacher.subjects
        .map((e) => {"subject": e.subject, "subCode": e.subCode})
        .toList();
    Map<String, dynamic> teacherToAdd = {
      'uid': docId,
      'name': teacher.name,
      'email': teacher.email,
      'password': teacher.password,
      'role': teacher.role,
      'subjects': teacherSubjects
    };
    return await _teacherCollectionRef.doc(docId).set(teacherToAdd);
  }

  Future<void> deleteUser(id) {
    return _teacherCollectionRef
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> updateTeacher(Teacher teacher) async {
    final teacherSubjects = teacher.subjects
        .map((e) => {"subject": e.subject, "subCode": e.subCode})
        .toList();
    return await _teacherCollectionRef.doc(teacher.uid).update({
      'name': teacher.name,
      'email': teacher.email,
      'password': teacher.password,
      'subjects': teacherSubjects
    });
  }
}
