import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';

class AppTextStyle {
  static AppTextStyle? _instance;

  AppTextStyle._();

  static AppTextStyle get instance {
    _instance ??= AppTextStyle._();
    return _instance!;
  }

  // Headline Styles
  TextStyle get headline30BoldRubik => TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'Rubik',
    color: appTheme.colorFFF9F9,
  );

  TextStyle get headline24BrunoAce => TextStyle(
    fontSize: 24.sp,
    fontFamily: 'Bruno Ace',
    color: appTheme.colorFF8900,
  );

  // Title Styles
  TextStyle get title20RegularRoboto => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
  );

  TextStyle get title20BoldDMSans => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'DM Sans',
    color: appTheme.blackCustom,
  );

  TextStyle get   title16BoldDMSans => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'DM Sans',
    color: appTheme.blackCustom,
  );

  // Body Styles
  TextStyle get body14BoldDMSans => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'DM Sans',
    color: appTheme.blackCustom,
  );

  TextStyle get body12BoldDMSans => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'DM Sans',
    color: appTheme.blackCustom,
  );

  TextStyle get body12Poppins => TextStyle(
    fontSize: 12.sp,
    fontFamily: 'Poppins',
  );

  TextStyle get body12MediumDMSans => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    fontFamily: 'DM Sans',
  );

  // Label Styles
  TextStyle get label10MediumDMSans => TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    fontFamily: 'DM Sans',
    color: appTheme.blackCustom,
  );

  // Other Styles
  TextStyle get bodyTextMediumDMSans => TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: 'DM Sans',
  );
}
