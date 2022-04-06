// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  bool isAccepted = false;
  String _selectedType = 'male';
  String _image = "assets/images/images.png";


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
                          setState(() {
                            _image = image!.path;
                          });
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              image:  DecorationImage(
                                image: AssetImage(_image),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(100),),
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
                  // Column(
                  //   children: [
                  //     RadioListTile(
                  //       title: const Text("I am a student"),
                  //       value: UserTypes,
                  //       groupValue: UserTypes,
                  //       onChanged: (v) {},
                  //     ),
                  //     RadioListTile(
                  //       title: const Text("I am a Teacher"),
                  //       value: UserTypes,
                  //       groupValue: UserTypes,
                  //       onChanged: (v) {},
                  //     ),
                  //   ],
                  // )
                  Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Please choose your role:'),
              ListTile(
                leading: Radio<String>(
                  value: 'student',
                  groupValue: _selectedType,
                  onChanged: (value) {
                    setState(() {
                      _selectedType = "student";
                    });
                  },
                ),
                title: const Text('I am a student'),
              ),
              ListTile(
                leading: Radio<String>(
                  value: 'teacher',
                  groupValue: _selectedType,
                  onChanged: (value) {
                    setState(() {
                      _selectedType = "teacher";
                    });
                  },
                ),
                title: const Text('I am a teacher'),
              ),
              const SizedBox(height: 25),
            ],
          )),
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
                      Checkbox(value: isAccepted, onChanged: (isSet) {
                        setState(() {
                          isAccepted = !isAccepted;
                        });
                      }),
                      const Text("I Accept terms and conditions")
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                _selectedType =="student"
                    ? SignInButton(
                        Buttons.Google,
                        text: "Sign in with Google",
                        onPressed: () async {
                          await _handleSignIn();
                        },
                      )
                    : SizedBox.shrink(),
                const SizedBox(
                  height: 10,
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
