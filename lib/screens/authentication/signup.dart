// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum UserTypes { ADMIN, TEACHER, STUDENT }

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const String routeName = "/signup";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "";
  String password = "";
  UserTypes userType = UserTypes.STUDENT;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Column(
                children: [
                  const Text(
                    "Create a new account",
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
                    children: [
                      RadioListTile(
                        title: const Text("I am a student"),
                        value: UserTypes,
                        groupValue: UserTypes,
                        onChanged: (v) {},
                      ),
                      RadioListTile(
                        title: const Text("I am a Teacher"),
                        value: UserTypes,
                        groupValue: UserTypes,
                        onChanged: (v) {},
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: const Color.fromARGB(255, 194, 238, 240),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Checkbox(value: true, onChanged: (isSet) {}),
                      const Text("I Accept terms and conditions")
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 10)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
