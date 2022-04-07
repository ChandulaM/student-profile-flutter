import 'package:flutter/material.dart';
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
  late Recommendation _recommendation;
  int itemId = 100;


  late Stream<List<Recommendation>> _recommendationItemsStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recommendationItemsStream = RecommendationService().getByStudent(widget.data["student_id"]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
          _buildListStream()
        ],
      ),
      title: "Add Recommendations",
      onBackPress: () {
        Navigator.pop(context);
      },
      onDonePress: () {

      },
    );
  }


  Future _save(BuildContext context) async {
    Recommendation recommendation = Recommendation(studentId: widget.data["student_id"], recommendations: []);
    await RecommendationService().addOrUpdateRecommendation(recommendation);
    Navigator.pop(context);
  }

  Future _addRecommendation({required String recommendation}) async {
    final List<Map<String, dynamic>> _recommendationList = [];
    Map<String, dynamic> map = {
      "subject": widget.data["subject_id"] as String,
      "recommendation": recommendation,
      "id": itemId.toString()
    };

    _recommendationList.add(map);

    Recommendation rec = Recommendation(studentId: widget.data["student_id"], recommendations: _recommendationList);

    await RecommendationService().addRecommendation(rec);

  }

  Future _removeItem({required int id}) async {
    await  RecommendationService().removeRecommendationItemFromArray(_recommendation, id);
  }

  Widget _buildListStream() {
    return StreamBuilder(
      stream: _recommendationItemsStream,
      builder: (BuildContext context, AsyncSnapshot<List<Recommendation>> snapshot) {
        if(snapshot.hasError) {
          return Text("Something went wrong");
        }
        if(snapshot.connectionState==ConnectionState.waiting) {
          return Text("Loading");
        }

        //Map<String, dynamic> json = snapshot.data
        
        Recommendation recommendation = snapshot.data![0];
        _recommendation = snapshot.data![0];

        if(recommendation.recommendations.isNotEmpty) {

          itemId = recommendation.recommendations.length + 100;

          return Column(
            children: [
              for(Map<String, dynamic> json in recommendation.recommendations) _buildListItem(subject: json["subject"], recommendation: json["recommendation"], index: 0, onPressRemove: () {
                //_removeItem(id: int.parse(json["id"]));
              })
            ]
          );
        }else {
          return Column(
            children: [

            ],
          );
        }


      },
    );
  }
/*
  Widget _buildList() => Column(
    children: [
      for(Map item in _recommendationList) _buildListItem(subject: item["subject"], recommendation: item["recommendation"], index: 0)
    ],
  );

 */


  Widget _buildListItem({required String subject, required String recommendation, required int index, required VoidCallback onPressRemove}) => Container(
    padding: const EdgeInsets.all(5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(subject, style: TextStyles.blackTextStyle14pt,),
        Text(recommendation, style: TextStyles.greyTextStyle14pt,),
        IconButton(
            onPressed: onPressRemove,
            icon: const Icon(Icons.done, color: Colors.green,))
      ],
    ),
  );

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
        const Text("Add Recommendations", style: TextStyles.greyTextStyle15pt,),
        TextFormField(
          controller: _recommendationController,
          validator: (val) => val!.isEmpty ? 'Enter recommendation' : null,
        ),
        const SizedBox(height: 10,),
        ElevatedButton(
          child: const Text("Add"),
          onPressed: () {
            _addRecommendation(recommendation: _recommendationController.text);
          },
        )
      ],
    ),
  );
}
