import 'package:cloud_firestore/cloud_firestore.dart';

class Subject {
  final String subCode;
  final String subject;

  Subject({required this.subject, required this.subCode});

  @override
  String toString() {
    return 'Subject{subCode: $subCode, subject: $subject}';
  }

  factory Subject.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Subject(
        subject:
            doc.data().toString().contains('subject') ? doc.get('subject') : '',
        subCode: doc.data().toString().contains('subCode')
            ? doc.get('subCode')
            : '');
  }
}
