import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_profile/models/Student.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:student_profile/screens/admin/update_student.dart';
import 'package:student_profile/services/student_services.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key, required this.list}) : super(key: key);
  static const String routeName = '/studentList';
  final List<Student> list;

  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  late List<Student> allStudents;
  late List<Student> students;
  late List<Student> filteredStudents;
  bool isSearching = false;

  @override
  void initState() {
    allStudents = widget.list;
    students = filteredStudents = allStudents;
    super.initState();
  }

  void _filterstudents(value) {
    setState(() {
      filteredStudents = allStudents
          .where((student) =>
              student.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 4, 208, 21),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: !isSearching
            ? const Text('Registered Students')
            : TextField(
                onChanged: (value) {
                  setState(() {
                    _filterstudents(value);
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Type student's name here",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                      filteredStudents = students;
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                )
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: filteredStudents.isNotEmpty
              ? ListView.builder(
                  itemCount: filteredStudents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 8),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(
                                  filteredStudents[index].name,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () async {
                                    if (await confirm(context)) {
                                      StudentServices()
                                          .deleteUser(
                                              filteredStudents[index].uid)
                                          .then((value) => showToast(
                                              "Student removed successfully"))
                                          .catchError((err) => showToast(
                                              "Something went wrong!"));
                                    }
                                    return print('pressedCancel');
                                  },
                                  icon: const Icon(Icons.delete_forever_sharp),
                                  color: Colors.red,
                                  iconSize: 30,
                                ),
                              ),
                              Expanded(
                                flex: 0,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpdateStudent(
                                              student:
                                                  filteredStudents[index])),
                                    );
                                  },
                                  icon: const Icon(Icons.edit_note_rounded),
                                  color: Colors.green,
                                  iconSize: 30,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : const Center(
                  child: Text(
                    "No such name registerd !",
                    style: TextStyle(fontSize: 20),
                  ),
                )),
    );
  }
}
