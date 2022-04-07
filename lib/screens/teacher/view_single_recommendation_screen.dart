import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_profile/common/app_colors.dart';
import 'package:student_profile/common/app_page_layout.dart';
import 'package:student_profile/common/text_styles.dart';
import 'package:student_profile/models/Recommendation.dart';
import 'package:student_profile/screens/teacher/view_messages_screen.dart';
import 'package:student_profile/services/recommendation_service.dart';

class ViewSingleRecommendationScreen extends StatefulWidget {

  final String recommendationId;

  static const String routeName = "toSingleRecommendationScreen";

  const ViewSingleRecommendationScreen({Key? key, required this.recommendationId}) : super(key: key);

  @override
  _ViewSingleRecommendationScreenState createState() => _ViewSingleRecommendationScreenState();
}

class _ViewSingleRecommendationScreenState extends State<ViewSingleRecommendationScreen> {

  Recommendation? recommendation;
  final TextEditingController _recommendationController = TextEditingController();

  static const String routeName = "toViewSingleRecommendationScreen";

  final _formKey = GlobalKey<FormState>();

  Future getRecommendation() async {
    recommendation = await RecommendationService().getSingleRecommendationById(widget.recommendationId);
    _recommendationController.text = recommendation!.comment??"";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecommendation();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _recommendationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppPageLayout(
      body: ListView(
        children: [
          const SizedBox(height: 20,),
          _buildAddRecommendationContainer(),
        ],
      ),
      title: "Recommendation",
      onDonePress: () {
        update();
        Fluttertoast.showToast(
            msg: "Recommendation Updated Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.pop(context);
      },
      onBackPress: () {
        Navigator.pop(context);
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onPressView(id: widget.recommendationId, context: context);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Center(child: Icon(Icons.message),)
        ),
      ),
    );
  }

  Future _onPressView({required String id, required BuildContext context}) async {
    await RecommendationService().addMessageCollectionToRecommendation(id);
    Navigator.pushNamed(context, ViewMessagesScreen.routeName, arguments: id);
  }

  Future update() async {
    recommendation!.comment = _recommendationController.text;
    await RecommendationService().updateRecommendation(recommendation!);
  }

  Widget _buildAddRecommendationContainer() => Container(
    height: 200,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(color: AppColors.greyF5, blurRadius: 7, spreadRadius: 5)
      ],
    ),
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          const Text("Add Recommendation Details", style: TextStyles.greyTextStyle15pt,),
          TextFormField(
            controller: _recommendationController,
            validator: (val) => val!.isEmpty ? 'Enter comment' : null,
          ),
          const SizedBox(height: 10,),
        ],
      ),
    ),
  );
}
