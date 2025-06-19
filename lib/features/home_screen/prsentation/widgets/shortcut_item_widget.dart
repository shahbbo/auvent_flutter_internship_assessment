import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../domain/entities/home_item.dart';

class ShortcutItemWidget extends StatelessWidget {
  final HomeItem shortcut;

  const ShortcutItemWidget({
    super.key,
    required this.shortcut,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 65.w,
          height: 65.w,
          decoration: BoxDecoration(
            color: appTheme.colorFFFFEE,
            borderRadius: BorderRadius.circular(10.h),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomImageView(
                imagePath: shortcut.image ?? '',
                /*height: shortcut.image?.contains('security_vault') == true ||
                        shortcut.image?.contains('group_34') == true
                    ? 49.h
                    : 40.h,
                width: shortcut.image?.contains('security_vault') == true
                    ? 50.h
                    : shortcut.image?.contains('group_34') == true
                        ? 39.h
                        : 40.h,*/
                fit: BoxFit.contain,
              ),
              /* if (shortcut.hasOverlay ?? false)
                Positioned(
                  top: shortcut.image?.contains('group_34') == true
                      ? 17.h
                      : 16.h,
                  left: shortcut.image?.contains('group_34') == true
                      ? 21.h
                      : 20.h,
                  child: Text(
                    shortcut.overlayText ?? '',
                    style: AppTextStyle.instance.headline24BrunoAce
                        .copyWith(height: 1.21),
                  ),
                ),*/
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          shortcut.name ?? '',
          textAlign: TextAlign.center,
          style: AppTextStyle.instance.body12MediumDMSans.copyWith(
            color: appTheme.blackCustom,
            /*height: shortcut.title?.contains('Must-tries') == true ||
                      shortcut.title?.contains('Give Back') == true
                  ? 1.33
                  : 1.25*/
          ),
        ),
      ],
    );
  }
}
