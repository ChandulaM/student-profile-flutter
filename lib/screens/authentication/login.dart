import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  // !! Temporary Layout !! //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Login screen'),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(onPressed: () {}, child: Text('Admin')),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/teacherHome'),
                child: Text('Teacher')),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/studentHome'),
                child: Text('Student'))
          ],
        ),
      ),
    );
  }
}
