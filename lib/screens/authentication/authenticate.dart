import 'package:flutter/material.dart';
import 'package:student_profile/screens/authentication/login.dart';
import 'package:student_profile/screens/authentication/signup.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);
  static const String routeName = "/authenticate";
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showLogin = true;

  @override
  Widget build(BuildContext context) {
    return showLogin ? Login() : SignUp();
  }
}
