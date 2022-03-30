import 'package:flutter/material.dart';
import 'package:student_profile/common/app_page_layout.dart';
import 'package:student_profile/models/Recommendation.dart';
import 'package:student_profile/screens/recomendation/reccomendation_item_widget.dart';
import 'package:student_profile/services/recommendation_service.dart';

class RecommendationScreen extends StatefulWidget {
  static String routeName = "recommendations";
  const RecommendationScreen({Key? key}) : super(key: key);

  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {



  final Stream<List<Recommendation>> recommendations = RecommendationService().recommendations;


  @override
  void initState() {
    super.initState();



  }

  @override
  Widget build(BuildContext context) {
    return AppPageLayout(
        body: StreamBuilder(
          stream: recommendations,
          builder: (BuildContext buildContext,  AsyncSnapshot<List<Recommendation>> snapshot) {
            if(!snapshot.hasData) {
              return const Center(child: Text("No data found"),);
            }else {
              return _buildRecommendationContainer(recommendations: snapshot!.data ?? []);
            }

          },
        ),
      onBackPress: () {
          Navigator.pop(context);
      },
    );
  }



  Widget _buildRecommendationContainer({List<Recommendation>? recommendations}) => ListView.builder(
    itemCount: recommendations!.length,
    itemBuilder: (_, index) {
      return RecommendationItemWidget(recommendation: recommendations[index], onPress: () {});
    }
  );

}
