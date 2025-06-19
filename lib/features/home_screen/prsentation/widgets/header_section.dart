import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/custom_image_view.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 156.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF8900FE), Color(0xFFFFDE59)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.h),
          bottomRight: Radius.circular(20.h),
        ),
      ),
      padding: EdgeInsets.fromLTRB(34.h, 35.h, 34.h, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivering to',
            style:
                AppTextStyle.instance.body12BoldDMSans.copyWith(height: 1.33),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Al Satwa, 81A Street',
                      style: AppTextStyle.instance.title16BoldDMSans
                          .copyWith(height: 1.31),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Hi hepa!',
                      style: AppTextStyle.instance.headline30BoldRubik
                          .copyWith(height: 1.2),
                    ),
                  ],
                ),
              ),
              CustomImageView(
                imagePath: AppAssets.profilePicture,
                height: 60.h,
                width: 60.h,
                fit: BoxFit.cover,
                radius: BorderRadius.circular(30.h),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
