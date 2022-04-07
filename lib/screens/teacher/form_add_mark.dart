import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_profile/common/constants.dart';
import 'package:student_profile/models/Recommendation.dart';
import 'package:student_profile/models/Results.dart';
import 'package:student_profile/models/Student.dart';
import 'package:student_profile/models/Subject.dart';
import 'package:student_profile/screens/teacher/recommendation_screen.dart';
import 'package:student_profile/services/student_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddMarkForm extends StatefulWidget {
  const AddMarkForm({
    Key? key,
    required this.student,
    required this.subject,
  }) : super(key: key);
  final Student student;
  final Subject subject;

  @override
  _AddMarkFormState createState() => _AddMarkFormState();
}

class _AddMarkFormState extends State<AddMarkForm> {
  final _formKey = GlobalKey<FormState>();
  double _subjectMark = 0.0;

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

  void showToast(String message, bool isError) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: isError ? Colors.red : Colors.blue[300],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  double caculateNewAverage(Student student) {
    double total = 0;
    int subjectCount = 0;
    for (var result in student.results) {
      if (result.mark > 0) {
        subjectCount++;
        total += result.mark;
      }
    }
    double average = total / subjectCount;
    return average;
  }

  List<Results> updatedResults(Student student, String subCode) {
    List<Results> studentResults = student.results;
    for (var result in studentResults) {
      if (subCode == result.subject) {
        result.mark = _subjectMark;
      }
    }
    return studentResults;
  }

  String? markValidation(String? val) {
    if (val!.isEmpty) {
      return "Enter a mark";
    }
    if (int.parse(val) < 0 || int.parse(val) > 100) {
      return "Enter a value between 0 and 100";
    }
  }

  @override
  Widget build(BuildContext context) {
    Student student = widget.student;
    String subCode = widget.subject.subCode;

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
                      initialValue: student.results
                          .firstWhere((result) => result.subject == subCode)
                          .mark
                          .toString(),
                      keyboardType: TextInputType.number,
                      decoration:
                          textFieldDecoration.copyWith(hintText: "Enter marks"),
                      validator: (val) => markValidation(val),
                      onChanged: (val) => setState(() {
                        _subjectMark =
                            val.isNotEmpty ? double.parse(val) : _subjectMark;
                      }),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          List<Results> newResults =
                              updatedResults(student, subCode);
                          double newAverage = caculateNewAverage(student);
                          StudentServices()
                              .updateStudentMarks(
                                  student.uid, newResults, newAverage)
                              .then((value) => showToast(
                                  "Marks updated successfully", false))
                              .catchError((error) => showToast(
                                  "Marks could not be updated!", true));
                        }
                      },
                      child: const Text('Add'))
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              /*TextFormField(
                initialValue: currentRecommendation,
                decoration: textFieldDecoration.copyWith(
                    hintText: 'Add recommendations (if any)'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onChanged: (val) => setState(() {
                  _recommendation =
                      val.isNotEmpty ? val : currentRecommendation;
                }),
              )*/
              InkWell(
                child: const Text("Add recommendation"),
                onTap: () {
                  Map data = {
                    "student_id": widget.student.uid,
                    "subject_id": widget.subject.subCode,
                  };

                  Navigator.pushNamed(
                      context, RecommendationAddScreen.routeName,
                      arguments: data);
                },
              )
            ],
          )),
    );
  }
}
