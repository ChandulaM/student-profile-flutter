import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_profile/models/Teacher.dart';
import 'package:student_profile/services/teacher_service.dart';

class TeacherList extends StatefulWidget {
  const TeacherList({Key? key, required this.list}) : super(key: key);
  static const String routeName = '/teacherList';
  final List<Teacher> list;
  @override
  _TeacherListState createState() => _TeacherListState();
}

class _TeacherListState extends State<TeacherList> {
  late List<Teacher> allteachers;
  late List<Teacher> teachers;
  late List<Teacher> filteredTeachers;
  bool isSearching = false;

  @override
  void initState() {
    allteachers = widget.list;
    teachers = filteredTeachers = allteachers;
    super.initState();
  }

  void _filterCountries(value) {
    setState(() {
      filteredTeachers = teachers
          .where((country) =>
              country.name.toLowerCase().contains(value.toLowerCase()))
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
            ? const Text('Registered Teachers')
            : TextField(
                onChanged: (value) {
                  _filterCountries(value);
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
                      filteredTeachers = teachers;
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
        child: filteredTeachers.isNotEmpty
            ? ListView.builder(
                itemCount: filteredTeachers.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    // onTap: () {
                    //   Navigator.of(context).pushNamed(Country.routeName,
                    //       arguments: filteredCountries[index]);
                    // },
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
                                filteredTeachers[index].name,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: () async {
                                  if (await confirm(context)) {
                                    TeacherService()
                                        .deleteUser(filteredTeachers[index].uid)
                                        .then((value) => showToast(
                                            "Student removed successfully"))
                                        .catchError((err) =>
                                            showToast("Something went wrong!"));
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
                                onPressed: () => {},
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
                //child: CircularProgressIndicator(),
                child: Text(
                  "No such name registerd !",
                  style: TextStyle(fontSize: 20),
                ),
              ),
      ),
    );
  }
}
