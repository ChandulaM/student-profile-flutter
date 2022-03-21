import 'package:flutter/material.dart';
import 'package:student_profile/common/constants.dart';
import 'package:student_profile/models/Results.dart';
import 'package:student_profile/models/Student.dart';
import 'package:student_profile/models/Subject.dart';
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

  List<Results> createUpdatedResultsList(
      List<Results> results, String subCode) {
    int index = results.indexWhere((result) => result.subject == subCode);
    if (index > -1) {
      results[index].mark = _subjectMark;
    } else {
      results.add(Results(subject: subCode, mark: _subjectMark));
    }
    print(results);
    return results;
  }

  @override
  Widget build(BuildContext context) {
    Student student = widget.student;
    String subCode = widget.subject.subCode;
    double currentMark =
        student.results.firstWhere((result) => result.subject == subCode).mark;
    print("mark: $currentMark");

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
                        }
                      },
                      child: const Text('Add'))
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                decoration: textFieldDecoration.copyWith(
                    hintText: 'Add recommendations (if any)'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
              )
            ],
          )),
    );
  }
}
