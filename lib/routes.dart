import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_profile/models/Student.dart';
import 'package:student_profile/screens/teacher/recommendation_screen.dart';
import 'package:student_profile/screens/teacher/view_messages_screen.dart';
import 'package:student_profile/screens/teacher/view_single_recommendation_screen.dart';

class Router  {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case RecommendationAddScreen.routeName:
        Map data = settings.arguments as Map;
        return MaterialPageRoute(builder: (_) => RecommendationAddScreen(data: data));
      case ViewMessagesScreen.routeName:
        String recId = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => ViewMessagesScreen(recommendationId: recId));
      case ViewSingleRecommendationScreen.routeName:
        String recId = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => ViewSingleRecommendationScreen(recommendationId: recId));
    }
  }
}