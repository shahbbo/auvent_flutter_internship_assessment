import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../domain/entities/home_item.dart';

class ServiceItemWidget extends StatelessWidget {
  final HomeItem service;

  const ServiceItemWidget({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 95.w,
          height: 70.h,
          decoration: BoxDecoration(
            color: appTheme.colorFFF5F5,
            borderRadius: BorderRadius.circular(10.h),
          ),
          child: Center(
            child: CustomImageView(
              imagePath: service.image,
              height: 50.h,
              width: 57.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 7.h),
        Container(
          decoration: BoxDecoration(
            color: appTheme.colorFF8900,
            borderRadius: BorderRadius.circular(8.h),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.h),
          child: Text(
            service.overlayText ?? '',
            style: AppTextStyle.instance.body12MediumDMSans
                .copyWith(color: appTheme.whiteCustom, height: 1.33),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          service.name,
          textAlign: TextAlign.center,
          style: AppTextStyle.instance.bodyTextMediumDMSans.copyWith(
            color: appTheme.blackCustom,
          ),
        ),
      ],
    );
  }
}

Widget buildShimmerServices() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          4,
          (index) => Padding(
            padding: EdgeInsets.only(right: index < 3 ? 16.w : 0),
            child: Column(
              children: [
                // Container للصورة
                Container(
                  width: 95.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.h),
                  ),
                ),
                SizedBox(height: 7.h),
                // Container للـ Overlay Text (أوفر)
                Container(
                  height: 20.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.h),
                  ),
                ),
                SizedBox(height: 2.h),
                // Container لاسم الخدمة
                Container(
                  width: 70.w,
                  height: 14.h,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
