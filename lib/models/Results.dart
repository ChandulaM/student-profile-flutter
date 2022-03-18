import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_profile/models/Subject.dart';

class Results {
  final DocumentReference subject;
  final double mark;

  Results({required this.subject, required this.mark});

  @override
  String toString() {
    return 'Results{subject: $subject, mark: $mark}';
  }
}
