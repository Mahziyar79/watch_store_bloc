import 'package:flutter/material.dart';
import 'package:watch_store/gen/fonts.gen.dart';
import 'package:watch_store/res/colors.dart';

class LightAppTextStyle {
  LightAppTextStyle._();

  static const TextStyle title = TextStyle(
    fontFamily: FontFamily.dana,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.title,
  );

  static const TextStyle hint = TextStyle(
    fontFamily: FontFamily.dana,
    fontWeight: FontWeight.w300,
    fontSize: 13,
    color: AppColors.hint,
  );

  static const TextStyle avatarText = TextStyle(
    fontFamily: FontFamily.dana,
    fontWeight: FontWeight.w400,
    fontSize: 11,
    color: AppColors.title,
  );
  static const TextStyle mainButton = TextStyle(
    fontFamily: FontFamily.dana,
    fontWeight: FontWeight.w500,
    fontSize: 15,
    color: AppColors.mainButtonText,
  );
  static const TextStyle primaryThemeTextStyle = TextStyle(
    fontFamily: FontFamily.dana,
    fontWeight: FontWeight.w500,
    fontSize: 15,
    color: AppColors.primaryColor,
  );
  static const TextStyle btmNavActive = TextStyle(
    fontFamily: FontFamily.dana,
    fontSize: 12,
    color: AppColors.btmNavActiveItem,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle btmInNavActive = TextStyle(
    fontFamily: FontFamily.dana,
    fontSize: 12,
    color: AppColors.btmNavInActiveItem,
    fontWeight: FontWeight.w500,
  );
}
