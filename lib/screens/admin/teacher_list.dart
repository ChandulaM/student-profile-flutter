import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:student_profile/models/Teacher.dart';
import 'package:student_profile/screens/admin/update_teacher.dart';
import 'package:student_profile/services/teacher_service.dart';

class TeacherList extends StatefulWidget {
  const TeacherList({Key? key, required this.list}) : super(key: key);
  static const String routeName = '/teacherList';
  final List<Teacher> list;
  @override
  _TeacherListState createState() => _TeacherListState();
}

class _TeacherListState extends State<TeacherList> {
  late List<Teacher> teachers;
  List<Teacher>? filteredTeachers = [];
  bool isSearching = false;

  List<Teacher>? search(List<Teacher> list, String query) {
    var filteredList = list
        .where((teacher) =>
            teacher.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    filteredList.forEach((teacher) => print(teacher.name));
    return filteredList;
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
    List<Teacher> allTeachers = Provider.of<List<Teacher>>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: !isSearching
            ? const Text('Registered Teachers')
            : TextField(
                onChanged: (value) {
                  setState(() {
                    filteredTeachers = search(allTeachers, value);
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Type teacher's name here",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      isSearching = false;
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
          child: filteredTeachers!.isNotEmpty
              ? ListView.builder(
                  itemCount: filteredTeachers!.length,
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
                                  filteredTeachers![index].name,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () async {
                                    if (await confirm(context)) {
                                      TeacherService()
                                          .deleteUser(
                                              filteredTeachers![index].uid)
                                          .then((value) => showToast(
                                              "Teacher removed successfully"))
                                          .catchError((err) => showToast(
                                              "Something went wrong!"));
                                    } else {
                                      return print('pressedCancel');
                                    }
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
                                          builder: (context) => UpdateTeacher(
                                              teacher:
                                                  filteredTeachers![index])),
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
              : ListView.builder(
                  itemCount: allTeachers.length,
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
                                  allTeachers[index].name,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () async {
                                    if (await confirm(context)) {
                                      TeacherService()
                                          .deleteUser(allTeachers[index].uid)
                                          .then((value) => showToast(
                                              "Student removed successfully"))
                                          .catchError((err) => showToast(
                                              "Something went wrong!"));
                                    } else {
                                      return print('pressedCancel');
                                    }
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
                                          builder: (context) => UpdateTeacher(
                                              teacher: allTeachers[index])),
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
                  })),
    );
  }
}
