import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:student_profile/models/Recommendation.dart';

class RecommendationService {



  final CollectionReference _recommendationCollection =
      FirebaseFirestore.instance.collection('recommendations');

  final String teacherId = "sBVHTRIkyf5diuDUBULO";

  Recommendation _recommendationFromDoc(QueryDocumentSnapshot doc) {
    return Recommendation(
        studentId: doc.data().toString().contains('studentID') ? doc.get('studentID') : 'N/A',
        subjectCode: doc.data().toString().contains('subjectCode')
            ? doc.get('subjectCode')
            : 'N/A',
        comment: doc.data().toString().contains('comment') ? doc.get('comment') : 'No comment',
        teacherId: doc.data().toString().contains('teacherId') ? doc.get('teacherId') : 'N/A',
        id: doc.id
        );
  }



  Future addNewRecommendation(Recommendation recommendation) async {
    return await _recommendationCollection.add({
      "comment": recommendation.comment,
      "studentID": recommendation.studentId,
      "subjectCode": recommendation.subjectCode,
      "teacherId": teacherId
    });
  }

  Future addMessageCollectionToRecommendation(String id) async {
    return _recommendationCollection.doc(id).collection("messages");
  }

  List<Recommendation> _recommendationsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map(_recommendationFromDoc).toList();
  }

  Future addOrUpdateRecommendation(Recommendation recommendation) async {
    return await _recommendationCollection.doc(recommendation.studentId).set({
      "studentId": recommendation.studentId,
      "message": recommendation.comment,
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

  Future<void> deleteRecommendationById(String id) async {
    return await _recommendationCollection.doc(id).delete();
  }

  Future<void> updateRecommendation(Recommendation recommendation) async {
    return await _recommendationCollection.doc(recommendation.id).set({
      "comment": recommendation.comment,
      "studentID": recommendation.studentId,
      "subjectCode": recommendation.subjectCode,
      "teacherId": teacherId
    });
  }


  Stream<List<Recommendation>> getByStudent(String studentId) {
    return _recommendationCollection
        .where('studentID', isEqualTo: studentId)
        .snapshots()
        .map(_recommendationsFromSnapshot);
  }

  Future<Recommendation> getSingleRecommendationById(String id) async {
    DocumentSnapshot snapshot = await _recommendationCollection.doc(id).get(); 
    return Recommendation(studentId: snapshot.get("studentID"), id: snapshot.id, comment: snapshot.get("comment"), subjectCode: snapshot.get("subjectCode"), teacherId: snapshot.get("teacherId"));
  }

  Future<List<Recommendation>> getSingleRecommendationByStudentAndSubjecId(String studentId, String subjectId) async {
     QuerySnapshot snapshot = await _recommendationCollection.where('studentId', isEqualTo: studentId).where('subjectCode', isEqualTo: subjectId).get();

     return _recommendationsFromSnapshot(snapshot);

  }

  Stream<List<Recommendation>> get recommendations {
    return _recommendationCollection
        .where('teacherId', isEqualTo: teacherId)
        .snapshots()
        .map(_recommendationsFromSnapshot);
  }
}
