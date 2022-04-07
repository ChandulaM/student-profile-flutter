import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:async';

enum UserTypes { ADMIN, TEACHER, STUDENT }

class StudentProfile extends StatefulWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  String email = "shihara@gmail.com";
  String name = "shihara";
  String age = "25";
  String mobileNumber = "0750935556";
  String dp = "assets/images/images.png";

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 20),
        () => {
              setState(() {
                email = "shihara@gmailupdated.com";
                name = "shihara updated";
                age = "24";
                mobileNumber = "0750935555";
                dp = "assets/images/mydp.jpg";
              })
            });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Profile'),
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
                  Text(
                    "$name's profile",
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
                              image: DecorationImage(
                                image: AssetImage(dp),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(100)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Class Ranking(3)"),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    ignoreGestures: true,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name :$name',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email : $email',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Age : $age',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Mobile Number : $mobileNumber',
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
                    Navigator.pushNamed(context, '/studentprofileupdate');
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
