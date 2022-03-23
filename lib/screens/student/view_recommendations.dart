import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_profile/models/Recommendation.dart';
import 'package:student_profile/models/Student.dart';
import 'package:student_profile/models/Subject.dart';

class ViewRecommendations extends StatefulWidget {
  const ViewRecommendations({Key? key}) : super(key: key);
  static const String routeName = "/studentRecommendations";

  @override
  _ViewRecommendationsState createState() => _ViewRecommendationsState();
}

class _ViewRecommendationsState extends State<ViewRecommendations> {
  String _findRecommendationForSubject(
      List<Recommendation> recommendations, String studentId, String subCode) {
    String recommendation = "";
    recommendations.forEach((stuRec) {
      if (stuRec.studentId == studentId) {
        stuRec.recommendations.forEach((subRec) {
          if (subRec['subject'] == subCode) {
            recommendation = subRec['recommendation'] as String;
          }
        });
      }
    });
    return recommendation;
  }

  @override
  Widget build(BuildContext context) {
    final routeObj =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Subject subject = routeObj['subject'];
    String studentId = routeObj['student'];

    final studentRecommendations = Provider.of<List<Recommendation>>(context);
    String recommendation = _findRecommendationForSubject(
        studentRecommendations, studentId, subject.subCode);

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 70.0,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Center(
                child: Text(
                  'Recommendations for: ${subject.subCode}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25.0),
                      bottomRight: Radius.circular(5.0),
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(25.0)),
                ),
                child: recommendation == ""
                    ? const Center(
                        child: Text(
                        'No recommendations',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w300),
                      ))
                    : Container(
                        margin: const EdgeInsets.all(10.0),
                        child: Text(
                          recommendation,
                          style: const TextStyle(fontSize: 16.0),
                        )))
          ],
        ),
      )),
    );
  }
}
