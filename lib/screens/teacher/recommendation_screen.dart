import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_profile/common/alert_utils.dart';
import 'package:student_profile/common/app_colors.dart';
import 'package:student_profile/common/app_page_layout.dart';
import 'package:student_profile/common/text_styles.dart';
import 'package:student_profile/models/Recommendation.dart';
import 'package:student_profile/services/recommendation_service.dart';

class RecommendationAddScreen extends StatefulWidget {

  static const String routeName = "toRecommendationAddScreen";

  final Map data;

  const RecommendationAddScreen({Key? key, required this.data}) : super(key: key);

  @override
  _RecommendationAddScreenState createState() => _RecommendationAddScreenState();
}

class _RecommendationAddScreenState extends State<RecommendationAddScreen> {

  final TextEditingController _recommendationController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  late Recommendation _recommendation;
  int itemId = 100;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commentController.dispose();
    _recommendationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppPageLayout(
      body: ListView(
        children: [
          const SizedBox(height: 20,),
          _buildAddRecommendationContainer(),
          const SizedBox(height: 20,),
          //_buildList()
          //_buildListStream()
        ],
      ),
      title: "Add Recommendations",
      onBackPress: () {
        Navigator.pop(context);
      },
      onDonePress: () {
        _save(context);
      },
    );
  }


  Future _save(BuildContext context) async {

    if(_commentController.text.isEmpty) {
      showMessage(context: context, onPressOk: () {
        Navigator.pop(context);
      }, title: "Error", message: "Please enter some comment");
    }else {
      Recommendation recommendation = Recommendation(studentId: widget.data["student_id"], subjectCode: widget.data["subject_id"], comment: _commentController.text);

      await RecommendationService().addNewRecommendation(recommendation);

      Fluttertoast.showToast(
          msg: "Recommendation Added Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

      //await RecommendationService().addOrUpdateRecommendation(recommendation);
      Navigator.pop(context);
    }


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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10,),
        const Text("Add Recommendation Details", style: TextStyles.greyTextStyle15pt,),
        TextFormField(
          controller: _commentController,
          validator: (val) => val!.isEmpty ? 'Enter comment' : null,
        ),
        const SizedBox(height: 10,),
      ],
    ),
  );
}
