import 'package:flutter/material.dart';
import 'package:student_profile/models/Student.dart';

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
                      // onTap: () {
                      //   Navigator.of(context).pushNamed(Country.routeName,
                      //       arguments: filteredStudents[index]);
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
                                  filteredStudents[index].name,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () => {},
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
                )),
    );
  }
}
