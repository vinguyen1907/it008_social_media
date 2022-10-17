import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_colors.dart';

class AppStyles {
  // static TextStyle onboardingTitle = GoogleFonts.poppins(
  //     color: Colors.black,
  //     fontSize: 32,
  //     fontWeight: FontWeight.w600,
  //     letterSpacing: 0.5);
  static const TextStyle storyLabel = TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
      color: Colors.black,
      fontSize: 12);
  static const TextStyle searchText = TextStyle(
      fontSize: 12,
      fontFamily: 'Poppins',
      color: AppColors.primaryMainColor,
      height: 1.6);
  static TextStyle searchHintText = TextStyle(
      fontSize: 12,
      fontFamily: 'Poppins',
      color: AppColors.primaryMainColor.withOpacity(0.5),
      height: 1);
  static const TextStyle postUserName = TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontSize: 15);
  static const TextStyle postUploadTime = TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontSize: 12);
  static const TextStyle postReaction = TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w700,
      color: Colors.black,
      fontSize: 10);
  static const TextStyle postDescription = TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
      color: Colors.black,
      fontSize: 10);
}
