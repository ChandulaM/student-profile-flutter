import 'package:flutter/material.dart';
import 'package:student_profile/models/Teacher.dart';
import 'package:student_profile/models/user.dart';
import 'package:student_profile/screens/admin/data.dart';

class TeacherList extends StatefulWidget {
  const TeacherList({Key? key}) : super(key: key);
  static const String routeName = '/teacherList';

  @override
  _TeacherListState createState() => _TeacherListState();
}

class _TeacherListState extends State<TeacherList> {
  List<User> allTeachers = allUsers;
  List countries = [];
  List filteredCountries = [];
  bool isSearching = false;

  // getCountries() async {
  //   var response = await Dio().get('https://restcountries.eu/rest/v2/all');
  //   return response.data;
  // }

  getTeachers(List<User> user) {
    Iterable teacher = user.where((e) => e.name == 'tea');
    
  }

  @override
  void initState() {
    setState(() {
      countries = filteredCountries = allTeachers;
    });

    super.initState();
  }

  void _filterCountries(value) {
    setState(() {
      filteredCountries = countries
          .where((country) =>
              country.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
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
                      filteredCountries = countries;
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
        child: filteredCountries.isNotEmpty
            ? ListView.builder(
                itemCount: filteredCountries.length,
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
                                filteredCountries[index].name,
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
              ),
      ),
    );
  }
}
