// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum UserTypes { ADMIN, TEACHER, STUDENT }

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const String routeName = "/login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  String email = "";
  String password = "";
  UserTypes userType = UserTypes.STUDENT;
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

  bool validateEmail() {
    return false;
  }

  bool validatePassword() {
    return false;
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
    } catch (error) {
      print(error);
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
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your name',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your password',
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                              isLoading = true;
                            });
                            Future.delayed(Duration(seconds: 1), (){
                              Navigator.pushNamed(context, '/studentHome');
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
                userType == UserTypes.STUDENT
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
                      userType = UserTypes.TEACHER;
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
                      userType = UserTypes.ADMIN;
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
                userType != UserTypes.STUDENT
                    ? ElevatedButton(
                        onPressed: () {
                          setState(() {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Now you can login as an student"),
                            ));
                            userType = UserTypes.STUDENT;
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
                SizedBox(height: userType == UserTypes.STUDENT ? 10 : 0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
