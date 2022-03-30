import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_profile/models/Recommendation.dart';
import 'package:student_profile/models/Student.dart';
import 'package:student_profile/models/Subject.dart';
import 'package:student_profile/services/recommendation_service.dart';

class ViewRecommendations extends StatefulWidget {
  const ViewRecommendations({Key? key}) : super(key: key);
  static const String routeName = "/studentRecommendations";

  @override
  _ViewRecommendationsState createState() => _ViewRecommendationsState();
}

class _ViewRecommendationsState extends State<ViewRecommendations> {
  bool _selectedFlag = false;

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

  Recommendation _removeRecommendation(
      List<Recommendation> studentRecommendations,
      String studentId,
      String subCode) {
    Recommendation recommendation =
        Recommendation(studentId: studentId, recommendations: [{}]);
    studentRecommendations.forEach((stuRec) {
      if (stuRec.studentId == studentId) {
        recommendation = stuRec;
        stuRec.recommendations
            .removeWhere((subRec) => subRec['subject'] == subCode);
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
            recommendation == ""
                ? const Center(
                    child: Text(
                    'No recommendations',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300),
                  ))
                : Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onLongPress: () => setState(() {
                            _selectedFlag = true;
                          }),
                          onTap: () => setState(() {
                            _selectedFlag = false;
                          }),
                          child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                  color: _selectedFlag
                                      ? Colors.blue[200]
                                      : Colors.blue[100],
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(25.0),
                                    bottomRight: Radius.circular(5.0),
                                    topLeft: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(25.0),
                                  ),
                                  border: _selectedFlag
                                      ? Border.all(
                                          color: Colors.blue, width: 2.0)
                                      : null),
                              child: Container(
                                  margin: const EdgeInsets.all(10.0),
                                  child: Text(
                                    recommendation,
                                    style: const TextStyle(fontSize: 16.0),
                                  ))),
                        ),
                      ),
                      _selectedFlag
                          ? IconButton(
                              onPressed: () async {
                                Recommendation recommendationToDelete =
                                    _removeRecommendation(
                                        studentRecommendations,
                                        studentId,
                                        subject.subCode);
                                showAlertDialogBox(
                                    context,
                                    RecommendationService()
                                        .addOrUpdateRecommendation,
                                    recommendationToDelete);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                          : const SizedBox(
                              width: 2.0,
                            ),
                    ],
                  ),
          ],
        ),
      )),
    );
  }
}

showAlertDialogBox(
    BuildContext context, Function callback, Recommendation recommendation) {
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Delete"),
    onPressed: () async {
      await callback(recommendation);
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Delete Recommendation"),
    content: const Text(
        "Are you sure you want to delete the selected recommendedation?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
