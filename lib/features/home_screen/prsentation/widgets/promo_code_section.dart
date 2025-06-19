import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/custom_image_view.dart';

class PromoCodeSection extends StatelessWidget {
  const PromoCodeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(19.h, 0, 19.h, 11.h),
      child: Container(
        height: 89.h,
        decoration: BoxDecoration(
          color: appTheme.whiteCustom,
          borderRadius: BorderRadius.circular(10.h),
          boxShadow: [
            BoxShadow(
              color: appTheme.blackCustom,
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        padding: EdgeInsets.all(17.h),
        child: Row(
          children: [
            CustomImageView(
              imagePath: AppAssets.coupon,
              height: 54.h,
              width: 76.h,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 6.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Got a code !',
                    style: AppTextStyle.instance.body14BoldDMSans
                        .copyWith(height: 1.36),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'Add your code and save on your\norder',
                    style: AppTextStyle.instance.label10MediumDMSans
                        .copyWith(height: 1.3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
