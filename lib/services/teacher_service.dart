import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_profile/models/Subject.dart';
import 'package:student_profile/models/Teacher.dart';

class TeacherService {
  final CollectionReference _teacherCollectionRef =
      FirebaseFirestore.instance.collection('teachers');

  final String _currentTeacherId = 'YmUYgt6k5dJ4KzkJgsLq';

  Teacher _teacherFromSnapshot(DocumentSnapshot snapshot) {
    return Teacher(
        uid: _currentTeacherId,
        role: snapshot.get('role'),
        name: snapshot.get('name'),
        email: snapshot.get('email'),
        password: snapshot.get('password'),
        subjects: List<Subject>.from(snapshot.get('subjects').map((sub) {
          return Subject(subject: sub['subject'], subCode: sub['subCode']);
        })));
  }

  Stream<Teacher> get getTeacher {
    return _teacherCollectionRef
        .doc(_currentTeacherId)
        .snapshots()
        .map(_teacherFromSnapshot);
  }
}
