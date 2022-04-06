import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

enum UserTypes { ADMIN, TEACHER, STUDENT }

class StudentProfile extends StatefulWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
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
                  const TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name : Shihara Dilshan',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email : shihara@gmail.com',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Age',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Mobile Number',
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
