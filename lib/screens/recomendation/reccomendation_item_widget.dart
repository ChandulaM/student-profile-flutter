import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_profile/common/app_colors.dart';
import 'package:student_profile/common/app_theme.dart';
import 'package:student_profile/common/text_styles.dart';
import 'package:student_profile/models/Recommendation.dart';

class RecommendationItemWidget extends StatelessWidget {

  final VoidCallback onPress;
  final Recommendation recommendation;

  const RecommendationItemWidget({Key? key, required this.recommendation, required this.onPress}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Container(
      height: 100,
      margin: const EdgeInsets.all(UI.PADDING),
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: AppColors.greyE0, blurStyle: BlurStyle.normal, blurRadius: 10, offset: Offset(0, 2))
          ],
          color: AppColors.white
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(left: UI.PADDING, top: UI.PADDING_2X, bottom: UI.PADDING_2X),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(recommendation.comment ?? "", style: TextStyles.regularGreyTextStyle14pt,),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ]
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: InkWell(
              onTap: onPress,
            ),
          )
        ],
      ),
    );
  }
}
