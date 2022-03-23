import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_profile/common/constants.dart';
import 'package:student_profile/models/Recommendation.dart';
import 'package:student_profile/models/Results.dart';
import 'package:student_profile/models/Student.dart';
import 'package:student_profile/models/Subject.dart';
import 'package:student_profile/services/recommendation_service.dart';
import 'package:student_profile/services/student_services.dart';

class AddMarkForm extends StatefulWidget {
  const AddMarkForm({Key? key, required this.student, required this.subject})
      : super(key: key);
  final Student student;
  final Subject subject;

  @override
  _AddMarkFormState createState() => _AddMarkFormState();
}

class _AddMarkFormState extends State<AddMarkForm> {
  final _formKey = GlobalKey<FormState>();
  late double _subjectMark;
  late String _recommendation;

  List<Results> createUpdatedResultsList(
      List<Results> results, String subCode) {
    int index = results.indexWhere((result) => result.subject == subCode);
    if (index > -1) {
      results[index].mark = _subjectMark;
    } else {
      results.add(Results(subject: subCode, mark: _subjectMark));
    }
    return results;
  }

  Recommendation createStudentRecommendations(
      List<Recommendation> recommendations, Student student, String subCode) {
    Recommendation recommendation =
        Recommendation(studentId: student.uid, recommendations: [
      {"subject": subCode, "recommendation": _recommendation}
    ]);

    for (var stuRecom in recommendations) {
      if (stuRecom.studentId == student.uid) {
        for (var subjectRecom in stuRecom.recommendations) {
          if (subjectRecom['subject'] == subCode) {
            subjectRecom['recommendation'] = _recommendation;
            recommendation = stuRecom;
          }
        }
      }
    }
    return recommendation;
  }

  String findCurrentRecommendation(
      List<Recommendation> recommendations, Student student, String subCode) {
    String currentRecommendation = '';
    for (var stuRecom in recommendations) {
      if (stuRecom.studentId == student.uid) {
        stuRecom.recommendations.forEach((recommendation) {
          if (recommendation['subject'] == subCode) {
            currentRecommendation = recommendation['recommendation'] as String;
          }
        });
      }
    }
    return currentRecommendation;
  }

  @override
  Widget build(BuildContext context) {
    Student student = widget.student;
    String subCode = widget.subject.subCode;
    final studentRecommendations = Provider.of<List<Recommendation>>(context);

    double currentMark =
        student.results.firstWhere((result) => result.subject == subCode).mark;
    String currentRecommendation =
        findCurrentRecommendation(studentRecommendations, student, subCode);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                student.name,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: currentMark.toString(),
                      decoration:
                          textFieldDecoration.copyWith(hintText: "Enter marks"),
                      validator: (val) => val!.isEmpty ? 'Enter mark' : null,
                      onChanged: (val) => setState(() {
                        _subjectMark =
                            val.isNotEmpty ? double.parse(val) : currentMark;
                      }),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          List<Results> newResults = createUpdatedResultsList(
                              student.results, subCode);
                          await StudentServices()
                              .updateStudentMarks(student.uid, newResults);
                          if (_recommendation != "") {
                            Recommendation recommendation =
                                createStudentRecommendations(
                                    studentRecommendations, student, subCode);
                            await RecommendationService()
                                .addOrUpdateRecommendation(recommendation);
                          }
                        }
                      },
                      child: const Text('Add'))
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                initialValue: currentRecommendation,
                decoration: textFieldDecoration.copyWith(
                    hintText: 'Add recommendations (if any)'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onChanged: (val) => setState(() {
                  _recommendation =
                      val.isNotEmpty ? val : currentRecommendation;
                }),
              )
            ],
          )),
    );
  }
}
