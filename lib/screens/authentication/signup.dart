// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
                    "Create a new accounts",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final ImagePicker _picker = ImagePicker();
                      // Pick an image
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/images/images.png"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        const Positioned.fill(
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Icon(
                                Icons.image_search,
                                color: Colors.blue,
                                size: 30.0,
                              )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
