import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:student_profile/common/app_colors.dart';

class TextStyles {
  static _setFontSize(double originalSize,
      {double? sm, double? md, double? lg}) {
    return originalSize;
  }

  static TextStyle mainTitleHeadingStyle = TextStyle(
      fontSize: _setFontSize(34, sm: 32, md: 32),
      fontWeight: FontWeight.bold,
      color: Colors.black);
  static TextStyle subTitleHeadingStyle = TextStyle(
      fontSize: _setFontSize(27, sm: 27, md: 27),
      fontWeight: FontWeight.w800,
      color: Colors.black);
  static TextStyle mainTitleHeadingStyleWhite = TextStyle(
      fontSize: _setFontSize(34, sm: 32, md: 32),
      fontWeight: FontWeight.bold,
      color: Colors.white);
  static TextStyle labelTextStyle = const TextStyle(
      fontSize: 17, color: AppColors.grey7f, fontWeight: FontWeight.normal);
  static TextStyle inputTextStyle = const TextStyle(
      fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600);
  static TextStyle inputTextStyleRegular = const TextStyle(
      fontSize: 17, color: Colors.black, fontWeight: FontWeight.normal);
  static TextStyle normalTextStyle =
  const TextStyle(fontSize: 17, color: AppColors.grey4A);
  static TextStyle regularRedTextStyle =
  const TextStyle(fontSize: 17, color: AppColors.red1D);
  static TextStyle regularGreyTextStyle = const TextStyle(
      fontSize: 17, fontWeight: FontWeight.normal, color: AppColors.grey4A);
  static TextStyle regularWhiteTextStyle = const TextStyle(
      fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white);
  static TextStyle blackTextStyle17pt = const TextStyle(
      fontSize: 17, fontWeight: FontWeight.normal, color: Colors.black);
  static TextStyle buttonTextStyle = const TextStyle(
      fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600);
  static TextStyle buttonTextStyleRed = const TextStyle(
      fontSize: 15, color: AppColors.red19, fontWeight: FontWeight.w600);
  static TextStyle btnBlackTextStyle = const TextStyle(
      fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600);
  static TextStyle mediumBlackTextStyle15pt = const TextStyle(
      fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500);
  static TextStyle blackTextStyle15pt = const TextStyle(
      fontSize: 15, color: Colors.black, fontWeight: FontWeight.normal);
  static TextStyle blackTextStyle15ptSemiBold = const TextStyle(
      fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600);
  static TextStyle blackTextStyle15ptBold = const TextStyle(
      fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold);
  static const TextStyle greyTextStyle15pt = TextStyle(
      fontSize: 15, color: AppColors.grey4A, fontWeight: FontWeight.normal);
  static TextStyle mediumGreyTextStyle15pt = const TextStyle(
      fontSize: 15, color: AppColors.grey4A, fontWeight: FontWeight.w500);
  static TextStyle mediumGreyTextStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.grey4A);
  static TextStyle regularGreyTextStyle14pt = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.grey8C);
  static TextStyle greyTextStyle14ptSemiBold = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.grey7D);
  static TextStyle mediumWhiteTextStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white);
  static TextStyle regularWhiteTextStyle14pt = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white);
  static TextStyle mediumSemiBoldWhiteTextStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white);
  static TextStyle blackTextStyle14pt = const TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal);
  static TextStyle blackTextStyle14ptMedium = const TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500);
  static TextStyle blackTextStyle14ptSemiBold = const TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600);
  static TextStyle blackTextStyle14ptHeavy = const TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.w900);
  static TextStyle whiteTextStyle14ptHeavy = const TextStyle(
      color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900);
  static TextStyle redTextStyle14ptBold = const TextStyle(
      color: AppColors.red16, fontSize: 14, fontWeight: FontWeight.bold);
  static TextStyle blackTextStyle8pt = const TextStyle(
      fontSize: 8, fontWeight: FontWeight.w900, color: Colors.black);
  static TextStyle greyTextStyle8pt = const TextStyle(
      fontSize: 8, fontWeight: FontWeight.w900, color: AppColors.grey70);
  static TextStyle greyTextStyle10pt = const TextStyle(
      fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.grey4A);
  static TextStyle blackTextStyle10pt = const TextStyle(
      fontSize: 10, fontWeight: FontWeight.w500, color: Colors.black);
  static TextStyle whiteTextStyle12pt =
  const TextStyle(color: Colors.white, fontSize: 12);
  static TextStyle greyTextStyle12pt =
  const TextStyle(color: AppColors.grey8C, fontSize: 12);
  static TextStyle greyTextStyle17pt =
  const TextStyle(color: AppColors.grey8C, fontSize: 17);
  static TextStyle greyTextStyle14pt =
  const TextStyle(color: AppColors.grey8C, fontSize: 14);
  static TextStyle darkGreyTextStyle12pt =
  const TextStyle(color: AppColors.grey4A, fontSize: 12);
  static TextStyle darkGreyTextStyle14pt =
  const TextStyle(color: AppColors.grey4A, fontSize: 14);
  static TextStyle blackTextStyle12pt = const TextStyle(
      color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500);
  static TextStyle redHeavyTextStyle12pt = const TextStyle(
      color: AppColors.red19, fontSize: 12, fontWeight: FontWeight.w900);
  static TextStyle mediumRedTextStyle12pt = const TextStyle(
      color: AppColors.red19, fontSize: 12, fontWeight: FontWeight.w500);
  static TextStyle keyPadTextStyle = const TextStyle(
      fontSize: 23, color: Colors.black, fontWeight: FontWeight.w600);
  static TextStyle headerTextStyle27 = TextStyle(
      fontSize: _setFontSize(27, sm: 23, md: 25, lg: 30),
      fontWeight: FontWeight.w600,
      color: Colors.white);
  static TextStyle headerTextStyle34 = TextStyle(
      fontSize: _setFontSize(34, sm: 32, md: 34, lg: 34),
      fontWeight: FontWeight.bold,
      color: Colors.white);
  static TextStyle blackTextStyle19pt = const TextStyle(
      fontSize: 19, fontWeight: FontWeight.normal, color: Colors.black);
  static TextStyle logoTextRed = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.red24);
  static TextStyle logoTextAsh = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.grey8E);
  static TextStyle blackTextStyle20pt = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle mediumBlackTextStyle20pt = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black);
  static TextStyle semiboldBlackTextStyle20pt = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black);
  static TextStyle whiteTextStyle21ptSemiBold = const TextStyle(
      fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600);
  static TextStyle logoInnerTextLite = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 24, color: AppColors.greyE0);
  static TextStyle logoInnerTextDark = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 24, color: AppColors.grey43);
  static TextStyle semiboldWhiteTextStyle27pt = const TextStyle(
      fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white);
  static TextStyle semiboldBlackTextStyle30pt = const TextStyle(
      fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black);
  static TextStyle whiteTextStyle36ptBold = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 36);
  static TextStyle regularRedTextStyle14pt = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.red24);
}
