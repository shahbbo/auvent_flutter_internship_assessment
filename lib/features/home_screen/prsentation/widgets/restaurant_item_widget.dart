import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../domain/entities/home_item.dart';

class RestaurantItemWidget extends StatelessWidget {
  final HomeItem restaurant;

  const RestaurantItemWidget({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80.h,
          height: 70.h,
          decoration: BoxDecoration(
            color: appTheme.whiteCustom,
            border: Border.all(color: appTheme.colorFFD9D9),
            borderRadius: BorderRadius.circular(10.h),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.h),
            child: Center(
              child: CustomImageView(
                imagePath: restaurant.image ?? '',
                // height: restaurant.image?.contains('logo637749035515703697') ==
                //         true
                //     ? 54.h
                //     : restaurant.image?.contains('logo4637357125093900864') ==
                //             true
                //         ? 53.h
                //         : restaurant.image?.contains('img_1') == true
                //             ? 55.h
                //             : 70.h,
                // width: restaurant.image?.contains('logo637749035515703697') ==
                //         true
                //     ? 80.h
                //     : restaurant.image?.contains('logo4637357125093900864') ==
                //                 true ||
                //             restaurant.image?.contains('img_1') == true
                //         ? 70.h
                //         : 70.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 84.h,
          child: Text(
            restaurant.name ?? '',
            textAlign: TextAlign.center,
            style: AppTextStyle.instance.body12MediumDMSans.copyWith(
              color: appTheme.blackCustom,
              /*height:
                    restaurant.name?.contains('Falafil') == true ? 1.25 : 1.33*/
            ),
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImageView(
              imagePath: '',
              height: 10.h,
              width: 10.h,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 4.h),
            Text(
              restaurant.overlayText ?? '',
              style: AppTextStyle.instance.label10MediumDMSans
                  .copyWith(color: appTheme.colorFF1E1E, height: 1.4),
            ),
          ],
        ),
      ],
    );
  }
}

Widget buildShimmerRestaurants() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          4,
          (index) => Padding(
            padding: EdgeInsets.only(right: index < 3 ? 16.h : 0),
            child: Column(
              children: [
                Container(
                  width: 80.h,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.h),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: 84.h,
                  height: 14.h,
                  color: Colors.white,
                ),
                SizedBox(height: 2.h),
                // overlayText
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10.h,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4.h),
                    Container(
                      width: 40.h,
                      height: 10.h,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
