import 'package:flutter/material.dart';
import 'package:student_profile/screens/authentication/authenticate.dart';
import 'package:student_profile/screens/authentication/login.dart';
import 'package:student_profile/screens/authentication/signup.dart';
import 'package:student_profile/screens/student/student_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      initialRoute: Authenticate.routeName,
      routes: {
        Login.routeName: (context) => const Login(),
        SignUp.routeName: (context) => const SignUp(),
        StudentHome.routeName: (context) => const StudentHome(),
      },
    );
  }
}
