import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_profile/common/header.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:student_profile/models/Subject.dart';
import 'package:student_profile/models/Teacher.dart';
import 'package:student_profile/screens/admin/teacher_list.dart';
import 'package:student_profile/services/teacher_service.dart';

class UpdateTeacher extends StatefulWidget {
  const UpdateTeacher({Key? key, required this.teacher}) : super(key: key);
  final Teacher teacher;

  @override
  _UpdateTeacherState createState() => _UpdateTeacherState();
}

class _UpdateTeacherState extends State<UpdateTeacher> {
  static final List<Subject> _subjects = [
    Subject(subCode: 'MA10', subject: "Maths"),
    Subject(subCode: 'SC10', subject: "Science"),
    Subject(subCode: 'GEO11', subject: "Geography"),
    Subject(subCode: 'HSCI10', subject: "Helth Sciense"),
    Subject(subCode: 'ENG11', subject: "English"),
  ];
  final _items = _subjects
      .map((sub) => MultiSelectItem<Subject>(sub, sub.subject))
      .toList();

  late List<Subject> _selectedSubjects;

  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    // _selectedSubjects = _subjects;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style1 = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
    );

    Teacher teacher = widget.teacher;
    String id = teacher.uid;

    final _formKey = GlobalKey<FormState>();

    var name = "";
    var email = "";
    var password = "";

    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    @override
    void dispose() {
      nameController.dispose();
      emailController.dispose();
      passwordController.dispose();
      super.dispose();
    }

    clearText() {
      nameController.text = teacher.name;
      emailController.text = teacher.email;
      passwordController.text = teacher.password;
    }

    assignData() {
      nameController.text = teacher.name;
      emailController.text = teacher.email;
      passwordController.text = teacher.password;
    }

    assignData();

    void showToast(String message) {
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 4, 208, 21),
          textColor: Colors.white,
          fontSize: 16.0);
    }

    void updateTeacher() async {
      Teacher teacher = Teacher(
          uid: id,
          role: 'TEA',
          name: name,
          email: email,
          password: password,
          subjects: _selectedSubjects);
      TeacherService()
          .updateTeacher(teacher)
          .then((value) => showToast("Details updated successfully"))
          .catchError((err) => showToast("Something went wrong!"));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Teacher Details'),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 12.0,
                        ),
                      ]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Update Form",
                  style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  )),
                )
              ],
            ),
            Flexible(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          autofocus: false,
                          decoration: const InputDecoration(
                            labelText: 'Name ',
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                          ),
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          autofocus: false,
                          decoration: const InputDecoration(
                            labelText: 'Email ',
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                          ),
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Email';
                            } else if (!value.contains('@')) {
                              return 'Please Enter Valid Email';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          autofocus: false,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password ',
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                          ),
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Password';
                            } else if (value.length < 6) {
                              return 'Password must have atleast 6 Characters';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 122, 121, 121))),
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: MultiSelectDialogField(
                          items: _items,
                          title: const Text("Subjects"),
                          selectedColor: Colors.blue,
                          validator: (values) {
                            if (values == null || values.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                          buttonIcon: const Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.blue,
                          ),
                          buttonText: const Text(
                            "Subjects",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          onConfirm: (List<Subject> results) {
                            _selectedSubjects = results;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () => {clearText()},
                            child: const Text(
                              'Reset',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  name = nameController.text;
                                  email = emailController.text;
                                  password = passwordController.text;
                                  updateTeacher();
                                });
                              }
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
