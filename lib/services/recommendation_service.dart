import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_profile/models/Recommendation.dart';

class RecommendationService {
  final CollectionReference _recommendationCollection =
      FirebaseFirestore.instance.collection('recommendations');

  Recommendation _recommendationFromDoc(QueryDocumentSnapshot doc) {
    return Recommendation(
        studentId: doc.data().toString().contains('studentId')
            ? doc.get('studentId')
            : '',
        message: doc.data().toString().contains('studentId')
            ? doc.get('message')
            : '',
        recommendations: doc.data().toString().contains('recommendations')
            ? List<Map<String, String>>.from(
                doc.get('recommendations').map((rec) {
                Map<String, String> obj = {
                  "subject": rec['subject'],
                  "recommendation": rec['recommendation']
                };
                return obj;
              }))
            : <Map<String, String>>[]);
  }

  List<Recommendation> _recommendationsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map(_recommendationFromDoc).toList();
  }

  Future addOrUpdateRecommendation(Recommendation recommendation) async {
    return await _recommendationCollection.doc(recommendation.studentId).set({
      "studentId": recommendation.studentId,
      "recommendations": recommendation.recommendations,
    });
  }

  Stream<List<Recommendation>> get recommendations {
    return _recommendationCollection
        .snapshots()
        .map(_recommendationsFromSnapshot);
  }
}
