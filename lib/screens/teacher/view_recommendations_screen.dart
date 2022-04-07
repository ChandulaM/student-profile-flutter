import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_profile/common/alert_utils.dart';
import 'package:student_profile/common/app_colors.dart';
import 'package:student_profile/common/header.dart';
import 'package:student_profile/common/text_styles.dart';
import 'package:student_profile/models/Recommendation.dart';
import 'package:student_profile/screens/teacher/view_messages_screen.dart';
import 'package:student_profile/screens/teacher/view_single_recommendation_screen.dart';
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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              const Header(title: "Recommendations"),
              const SizedBox(height: 20,),
              Flexible(child: _buildRecommendationList(context)),
            ],
          ),
        ),
      ),
    );
  }

  Future _onPressDelete({required String? id}) async {
    await RecommendationService().deleteRecommendationById(id??"");
    showMessage(context: context, onPressOk: () {Navigator.pop(context);}, title: "Deleted!", message: "Recommendation has been deleted");
  }

  Future _onPressView({required String id, required BuildContext context}) async {
    await RecommendationService().addMessageCollectionToRecommendation(id);
    Navigator.pushNamed(context, ViewSingleRecommendationScreen.routeName, arguments: id);
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
          itemBuilder: (_,index) => _buildRecommendationListItem(message: snapshot.data![index].comment??"", onPressDelete: () {
            _onPressDelete(id: snapshot.data![index].id);
          }, onPressView: () {
            _onPressView(id: snapshot.data![index].id??"", context: context);
          }),
        );
      } else {
        return const Text("Empty list");
      }

    },
  );

  Widget _buildRecommendationListItem({required String message, required VoidCallback onPressDelete, required VoidCallback onPressView}) => Container(
    padding: const EdgeInsets.all(10),
    height: 100,
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(color: AppColors.greyF5, blurRadius: 7, spreadRadius: 5)
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        )
      ],
    ),
  );

}
