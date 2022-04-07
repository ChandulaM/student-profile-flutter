// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:student_profile/services/student_services.dart';
import 'package:student_profile/services/teacher_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const String routeName = "/login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  String email = "";
  String password = "";
  String userType = "Student";
  bool isLoading = false;

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool validateEmail(email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  bool validatePassword(String password) {
    return password.isNotEmpty;
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      Navigator.pushNamed(context, '/studentHome');
    } catch (error) {
      Navigator.pushNamed(context, '/studentHome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  const Text(
                    "Welcome to the Student Profiler",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your name',
                    ),
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your password',
                    ),
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          if (!validateEmail(email)) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Please enter a valid email"),
                            ));
                            return;
                          }
                          if (!validatePassword(password)) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Password cannot be empty"),
                            ));
                            return;
                          }

                          Future.delayed(Duration(seconds: 2), () {
                            userType == "student"
                                ? Navigator.pushNamed(context, '/studentHome')
                                : userType == "admin"
                                    ? Navigator.pushNamed(context, '/adminHome')
                                    : Navigator.pushNamed(
                                        context, '/teacherHome');
                            setState(() {
                              isLoading = false;
                            });
                          });

                          if (userType == "student") {
                            var result = await StudentServices()
                                .loginAsStudent(email, password);
                            if (result != null) {
                              Navigator.pushNamed(context, '/studentHome');
                            }
                          } else if (userType == "teacher") {
                            var result = await TeacherService()
                                .loginAsTeacher(email, password);
                            if (result != null) {
                              Navigator.pushNamed(context, '/teacherHome');
                            }
                          } else if (userType == "admin") {
                            if (email == "admin@gmail.com" &&
                                password == "admin123") {
                              Navigator.pushNamed(context, '/teacherHome');
                            }
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: Text(
                            'Login as a ${userType.toString().replaceFirst("UserTypes.", "")}'),
                      ),
                      ElevatedButton(
                          onPressed: () {
                           Navigator.pushNamed(context, '/signup');
                          },
                          child: const Text('Sign up')),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  isLoading
                      ? CircularProgressIndicator(
                          value: controller.value,
                          semanticsLabel: 'Linear progress indicator',
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                userType == "student"
                    ? SignInButton(
                        Buttons.Google,
                        text: "Sign in with Google",
                        onPressed: () async {
                          await _handleSignIn();
                        },
                      )
                    : SizedBox.shrink(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Now you can login as a teacher"),
                      ));
                      userType = "teacher";
                    });
                  },
                  child: const Text('Teacher Login'),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Now you can login as an admin"),
                      ));
                      userType = "admin";
                    });
                  },
                  child: const Text('Admin Login'),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
                userType != "student"
                    ? ElevatedButton(
                        onPressed: () {
                          setState(() {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Now you can login as an student"),
                            ));
                            userType = "student";
                          });
                        },
                        child: const Text('Student Login'),
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(height: userType == "student" ? 10 : 0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
