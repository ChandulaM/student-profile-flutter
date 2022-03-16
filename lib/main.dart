import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_profile/screens/authentication/authenticate.dart';
import 'package:student_profile/screens/authentication/login.dart';
import 'package:student_profile/screens/student/student_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      initialRoute: Authenticate.routeName,
      routes: {
        Authenticate.routeName: (context) => const Authenticate(),
        StudentHome.routeName: (context) => const StudentHome(),
      },
    );
  }
}
