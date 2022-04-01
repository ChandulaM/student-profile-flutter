import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_profile/common/header.dart';
import 'package:student_profile/common/loading.dart';
import 'package:student_profile/models/Student.dart';
import 'package:student_profile/models/Subject.dart';

import 'package:student_profile/screens/student/student_list_subjects.dart';
import 'package:student_profile/screens/student/student_marks.dart';

class TabbedScreenMarks extends StatefulWidget {
  const TabbedScreenMarks({Key? key}) : super(key: key);

  @override
  State<TabbedScreenMarks> createState() => _TabbedScreenMarksState();
}

class _TabbedScreenMarksState extends State<TabbedScreenMarks>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController = TabController(length: 2, vsync: this);
    Student? currentStudent = Provider.of<Student?>(context);
    final subjectList = Provider.of<List<Subject>>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 5.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 12.0,
          ),
          const Header(title: 'Student Subjects'),
          const SizedBox(
            height: 12.0,
          ),
          currentStudent == null
              ? const LoadingSpinner()
              : Expanded(
                  child: Column(
                  children: [
                    TabBar(
                        controller: _tabController,
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.grey[400],
                        labelStyle: const TextStyle(
                          fontSize: 16.0,
                          letterSpacing: 0.5,
                        ),
                        tabs: const [
                          Tab(text: 'Enroll'),
                          Tab(
                            text: 'Subject List',
                          )
                        ]),
                    Flexible(
                      child: Container(
                        width: double.maxFinite,
                        child:
                            TabBarView(controller: _tabController, children: [
                          ListAllSubjects(
                              allSubjects: subjectList,
                              student: currentStudent),
                          StudentMarks(
                            subjectList: subjectList,
                            currentStudent: currentStudent,
                          ),
                        ]),
                      ),
                    )
                  ],
                ))
        ]),
      ),
    );
  }
}
