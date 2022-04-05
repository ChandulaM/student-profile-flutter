import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_profile/common/constants.dart';
import 'package:student_profile/models/Recommendation.dart';
import 'package:student_profile/models/Results.dart';
import 'package:student_profile/models/Student.dart';
import 'package:student_profile/models/Subject.dart';
import 'package:student_profile/screens/teacher/recommendation_screen.dart';
import 'package:student_profile/services/recommendation_service.dart';
import 'package:student_profile/services/student_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddMarkForm extends StatefulWidget {
  const AddMarkForm(
      {Key? key,
      required this.student,
      required this.subject,
      })
      : super(key: key);
  final Student student;
  final Subject subject;

  @override
  _AddMarkFormState createState() => _AddMarkFormState();
}

class _AddMarkFormState extends State<AddMarkForm> {
  final _formKey = GlobalKey<FormState>();
  late double _subjectMark;

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


  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue[300],
        textColor: Colors.white,
        fontSize: 16.0);
  }


  double caculateNewAverage(Student student) {
    double total = 0;
    for (var result in student.results) {
      total += result.mark;
    }
    double average = total / student.results.length;
    return average;
  }

  @override
  Widget build(BuildContext context) {
    Student student = widget.student;
    String subCode = widget.subject.subCode;

    double currentMark =
        student.results.firstWhere((result) => result.subject == subCode).mark;


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
                      keyboardType: TextInputType.number,
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
                          Results newResult =
                              Results(subject: subCode, mark: _subjectMark);
                          double newAverage = caculateNewAverage(student);
                          StudentServices()
                              .updateStudentMarks(student.uid, newResult,
                                  newAverage: newAverage)
                              .then((value) =>
                                  showToast("Marks updated successfully"))
                              .catchError((error) => print(error));
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

                  Navigator.pushNamed(context, RecommendationAddScreen.routeName, arguments: data);
                },
              )
            ],
          )),
    );
  }
}
