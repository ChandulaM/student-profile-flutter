import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_profile/common/header.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:student_profile/screens/admin/student_list.dart';

class ManageStudent extends StatefulWidget {
  const ManageStudent({Key? key}) : super(key: key);

  @override
  _ManageStudentState createState() => _ManageStudentState();
}

class _ManageStudentState extends State<ManageStudent> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style1 =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

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
      nameController.clear();
      emailController.clear();
      passwordController.clear();
    }

    CollectionReference students =
        FirebaseFirestore.instance.collection('students');

    Future<void> addUser() {
      return students
          .add({'name': name, 'email': email, 'password': password})
          .then((value) => print('User Added'))
          .catchError((error) => print('Failed to Add user: $error'));
    }

    return Scaffold(
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
                        Header(
                          title: "Manage Students",
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                      ]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    style: style1,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StudentList()),
                      );
                    },
                    child: const Text('View Registered List'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Registeration",
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
                            }
                            return null;
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
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  name = nameController.text;
                                  email = emailController.text;
                                  password = passwordController.text;
                                  addUser();
                                  clearText();
                                });
                              }
                            },
                            child: const Text(
                              'Register',
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
