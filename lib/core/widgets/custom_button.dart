import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_text_style.dart';
import '../theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      clipBehavior: Clip.antiAlias,
      style: ElevatedButton.styleFrom(
        backgroundColor: appTheme.colorFF8900,
        minimumSize: Size(330.w, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Text(text,
          style: AppTextStyle.instance.title16BoldDMSans.copyWith(
            color: Colors.white,
          )),
    );
  }
}
