import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_profile/models/Recommendation.dart';
import 'package:student_profile/models/Student.dart';
import 'package:student_profile/models/Subject.dart';
import 'package:student_profile/models/Teacher.dart';
import 'package:student_profile/routes.dart';
import 'package:student_profile/screens/admin/admin_home.dart';
import 'package:student_profile/screens/authentication/authenticate.dart';
import 'package:student_profile/screens/authentication/login.dart';
import 'package:student_profile/screens/recomendation/recommendations_screen.dart';
import 'package:student_profile/screens/student/student_home.dart';
import 'package:student_profile/screens/teacher/add_recommendation.dart';
import 'package:student_profile/screens/teacher/recommendation_screen.dart';
import 'package:student_profile/screens/teacher/teacher_home.dart';
import 'package:student_profile/services/recommendation_service.dart';
import 'package:student_profile/services/student_services.dart';
import 'package:student_profile/services/subject_service.dart';
import 'package:student_profile/routes.dart' as router;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  FirebaseFirestore.instanceFor(app: app);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Student>>.value(
          initialData: const [],
          value: StudentServices().getStudents(),
        ),
        StreamProvider<List<Subject>>.value(
          initialData: const [],
          value: SubjectServices().getAllSubjects(),
        ),
        StreamProvider<List<Recommendation>>.value(
            value: RecommendationService().recommendations,
            initialData: const [],
        ),
      ],
      child: MaterialApp(
        title: 'Student Profile',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
        initialRoute: Authenticate.routeName,
        routes: {
          Authenticate.routeName: (context) => const Authenticate(),
          AdminHome.routeName: (context) => const AdminHome(),
          StudentHome.routeName: (context) => const StudentHome(),
          TeacherHome.routeName: (context) => const TeacherHome(),
          AddMarkAndRecommendation.routeName: (context) =>
              const AddMarkAndRecommendation(),
          RecommendationScreen.routeName: (context) => const RecommendationScreen(),
        },
        onGenerateRoute: router.Router.generateRoute,
      ),
    );
  }
}
