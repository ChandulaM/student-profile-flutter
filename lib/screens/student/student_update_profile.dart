import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

enum UserTypes { ADMIN, TEACHER, STUDENT }

class StudentProfileUpdate extends StatefulWidget {
  const StudentProfileUpdate({Key? key}) : super(key: key);
  static const String routeName = "/studentprofileupdate";

  @override
  _StudentProfileUpdateState createState() => _StudentProfileUpdateState();
}

class _StudentProfileUpdateState extends State<StudentProfileUpdate> {
  String email = "shihara@gmail.com";
  String name = "shihara";
  String age = "25";
  String mobileNumber = "0750935556";
  String dp = "assets/images/images.png";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Update Profile'),
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
                        dp = "assets/images/mydp.jpg";
                      });
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(dp),
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
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: name,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: email,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: age,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: mobileNumber,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      email = "shihara@gmailupdated.com";
                      name = "shihara updated";
                      age = "24";
                      mobileNumber = "0750935555";
                      dp = "assets/images/mydp.jpg";
                    });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("profile updated succeddfully"),
                    ));
                  },
                  child: const Text('Update Profile'),
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
