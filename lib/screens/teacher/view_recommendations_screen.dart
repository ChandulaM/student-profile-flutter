import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_profile/common/app_colors.dart';
import 'package:student_profile/common/text_styles.dart';
import 'package:student_profile/models/Recommendation.dart';
import 'package:student_profile/screens/student/view_recommendations.dart';
import 'package:student_profile/screens/teacher/view_messages_screen.dart';
import 'package:student_profile/services/recommendation_service.dart';

class ViewRecommendationsScreen extends StatefulWidget {
  const ViewRecommendationsScreen({Key? key}) : super(key: key);

  @override
  _ViewRecommendationsScreenState createState() => _ViewRecommendationsScreenState();
}

class _ViewRecommendationsScreenState extends State<ViewRecommendationsScreen> {

  final Stream<List<Recommendation>> _recommendationStream = RecommendationService().recommendations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: _buildRecommendationList(context),
      ),
    );
  }

  Future _onPressDelete({required String? id}) async {

  }

  Future _onPressView({required String id, required BuildContext context}) async {
    Navigator.pushNamed(context, ViewMessagesScreen.routeName, arguments: id);
  }

  Widget _buildRecommendationList(BuildContext context) => StreamBuilder<List<Recommendation>>(
    stream: _recommendationStream,
    builder: (_, snapshot) {
      if(snapshot.hasError) {
        return const Text("Something went wrong");
      }

      if(snapshot.connectionState==ConnectionState.waiting) {
        return const Text("Loading...");
      }

      if(snapshot.data!.isNotEmpty) {
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (_,index) => _buildRecommendationListItem(message: snapshot.data![index].message??"", onPressDelete: () {
            _onPressDelete(id: snapshot.data![index].studentId);
          }, onPressView: () {
            _onPressView(id: snapshot.data![index].studentId??"", context: context);
          }),
        );
      } else {
        return const Text("Empty list");
      }

    },
  );

  Widget _buildRecommendationListItem({required String message, required VoidCallback onPressDelete, required VoidCallback onPressView}) => Container(
    padding: const EdgeInsets.all(5),
    height: 100,
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(color: AppColors.greyF5, blurRadius: 7, spreadRadius: 5)
      ],
    ),
    child: Column(
      children: [
         Text(message, style: TextStyles.greyTextStyle14pt,),
        Row(
          children: [
            IconButton(
                onPressed: onPressView,
                icon: const Icon(Icons.more_horiz)
            ),
            IconButton(
                onPressed: onPressDelete,
                icon: const Icon(Icons.delete)
            )
          ],
        )
      ],
    ),
  );

}
