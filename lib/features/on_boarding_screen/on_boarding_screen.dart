import 'package:auvent_flutter_internship_assessment/core/utils/app_assets.dart';
import 'package:auvent_flutter_internship_assessment/core/widgets/custom_button.dart';
import 'package:auvent_flutter_internship_assessment/core/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

import '../../core/routes/app_routes.dart';
import '../../core/routes/navigator_service.dart';
import '../../core/widgets/custom_text_button.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  static Widget builder(BuildContext context) {
    return const OnBoarding();
  }

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding>
    with SingleTickerProviderStateMixin {
  int currentPage = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<Map<String, String>> onboardingData = [
    {
      'title': 'all-in-one delivery',
      'description':
          'Order groceries, medicines, and meals delivered straight to your door',
    },
    {
      'title': 'User-to-User Delivery',
      'description':
          'Send or receive items from other users quickly and easily',
    },
    {
      'title': 'Sales & Discounts',
      'description': 'Discover exclusive sales and deals every day',
    },
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void saveOnboarding() async {
    var settingsBox = await Hive.openBox('settings');
    await settingsBox.put('onboarding', true);
  }

  void _nextPage() async {
    await _controller.forward();

    setState(() {
      if (currentPage < onboardingData.length - 1) {
        currentPage++;
      } else {
        saveOnboarding();
        NavigatorService.pushNamedAndRemoveUntil(AppRoutes.authScreen);
        return;
      }
    });

    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFFFFFFF),
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  CustomImageView(
                    imagePath: AppAssets.onboarding,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 100.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: FadeTransition(
                        opacity: _animation,
                        child: _buildOnBoardingItem(
                          onboardingData[currentPage]['title']!,
                          onboardingData[currentPage]['description']!,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildButton(),
                  SizedBox(height: 10.h),
                  _buildNextButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOnBoardingItem(String title, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return CustomButton(
      text: 'Get Started',
      onPressed: () {
        saveOnboarding();
        NavigatorService.pushNamedAndRemoveUntil(AppRoutes.authScreen);
      },
    );
  }

  Widget _buildNextButton() {
    return CustomTextButton(
      text: 'next',
      onPressed: _nextPage,
    );
  }
}
