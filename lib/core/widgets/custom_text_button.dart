import 'package:flutter/material.dart';

import '../theme/app_text_style.dart';
import '../theme/app_theme.dart';

class CustomTextButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  const CustomTextButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTextStyle.instance.title20RegularRoboto.copyWith(
          color: appTheme.colorFF677294B,
        ),
      ),
    );
  }
}
