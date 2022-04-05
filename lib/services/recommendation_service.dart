import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_profile/models/Recommendation.dart';

class RecommendationService {



  final CollectionReference _recommendationCollection =
      FirebaseFirestore.instance.collection('recommendations');

  Recommendation _recommendationFromDoc(QueryDocumentSnapshot doc) {
    return Recommendation(
        id: doc.get("studentId"),
        studentId: doc.data().toString().contains('studentId')
            ? doc.get('studentId')
            : '',
        message: doc.data().toString().contains('studentId')
            ? doc.get('message')
            : '',
        recommendations: doc.data().toString().contains('recommendations')
            ? List<Map<String, dynamic>>.from(
                doc.get('recommendations').map((rec) {
                Map<String, String> obj = {
                  "subject": rec['subject'],
                  "recommendation": rec['recommendation'],
                  "id": rec["id"],
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
      "message": "",
    });
  }

  Future addRecommendation(Recommendation recommendation) async {
    return await _recommendationCollection.doc(recommendation.studentId).update({
      "recommendations": FieldValue.arrayUnion(recommendation.recommendations),
    });
  }

  Future removeRecommendationItemFromArray(Recommendation recommendation, int id) async {
    await _recommendationCollection.doc(recommendation.studentId).update({
      "recommendations": FieldValue.arrayUnion(recommendation.recommendations.where((element) => element["id"]==id.toString()).toList()),
    });
  }


/*
  Map<String, dynamic> _recme(QueryDocumentSnapshot q) {
    Map<String, dynamic> jaon = {
      "recommendation": q.get("recommendations")
    }
  }

 */



/*
  Future insertRecommendation(Map<String, String> rec, String studentId) async {
    return await _recommendationCollection.doc(studentId).set({
      "studentId": studentId,
      "recommendations":
    })
  }


 */

  Future removeRecommendation(String id) async {
    return _recommendationCollection.doc(id).delete();
  }

  Stream<List<Recommendation>> getByStudent(String studentId) {
    return _recommendationCollection
        .where('studentId', isEqualTo: studentId)
        .snapshots()
        .map(_recommendationsFromSnapshot);
  }

  Stream<List<Recommendation>> get recommendations {
    return _recommendationCollection
        .snapshots()
        .map(_recommendationsFromSnapshot);
  }
}
