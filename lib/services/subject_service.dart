import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_profile/models/Subject.dart';

class SubjectServices {
  final CollectionReference _subjectCollection =
      FirebaseFirestore.instance.collection('subjects');

  List<Subject> _getSubjectsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Subject(
          subject: doc.data().toString().contains('subject')
              ? doc.get('subject')
              : '',
          subCode: doc.data().toString().contains('subCode')
              ? doc.get('subCode')
              : '');
    }).toList();
  }

  Stream<List<Subject>> getAllSubjects() {
    return _subjectCollection.snapshots().map(_getSubjectsFromSnapshot);
  }

  Subject getSubject(DocumentReference subjectRef) {
    DocumentSnapshot subject = subjectRef.get() as DocumentSnapshot<Object?>;

    return Subject.fromFirestore(subject);
  }
}
