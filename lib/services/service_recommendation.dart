import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_profile/models/Recommendation.dart';

abstract class RecommendationRepo {
  Future addOrUpdateRecommendation(Recommendation recommendation);
}

class ServiceRecommendation extends RecommendationRepo {

  final CollectionReference _recommendationCollection =
  FirebaseFirestore.instance.collection('recommendations');

  @override
  Future addOrUpdateRecommendation(Recommendation recommendation) async {
    // TODO: implement addOrUpdateRecommendation
    return await _recommendationCollection.doc(recommendation.studentId).set({
      "studentId": recommendation.studentId,
      "recommendations": recommendation.recommendations,
    });
  }





}