import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../bloc/home_bloc.dart';

class AdsSlider extends StatefulWidget {
  const AdsSlider({super.key});

  @override
  State<AdsSlider> createState() => _AdsSliderState();
}

class _AdsSliderState extends State<AdsSlider> {
  final PageController _adsPageController = PageController();
  final ValueNotifier<int> _currentAdsPage = ValueNotifier<int>(0);

  @override
  void dispose() {
    _adsPageController.dispose();
    _currentAdsPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final ads = state.ads;
        final isLoading = state.isLoading && ads.isEmpty;
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(14.h, 0, 14.h, 8.h),
              child: Container(
                width: 343.h,
                height: 180.h,
                decoration: BoxDecoration(
                  color: appTheme.colorFFD9D9,
                  borderRadius: BorderRadius.circular(10.h),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.h),
                  child: isLoading
                      ? _buildAdsShimmer()
                      : ads.isEmpty
                          ? const SizedBox.shrink()
                          : PageView.builder(
                              controller: _adsPageController,
                              itemCount: ads.length,
                              onPageChanged: (index) {
                                _currentAdsPage.value = index;
                              },
                              itemBuilder: (context, index) {
                                return CustomImageView(
                                  imagePath: ads[index].image,
                                  height: 180.h,
                                  width: 343.h,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                ),
              ),
            ),
            ads.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.only(bottom: 34.h),
                    child: ValueListenableBuilder<int>(
                      valueListenable: _currentAdsPage,
                      builder: (context, currentPage, _) {
                        return AnimatedSmoothIndicator(
                          activeIndex: currentPage,
                          count: ads.length,
                          effect: WormEffect(
                            dotHeight: 8.h,
                            dotWidth: 8.h,
                            spacing: 8.h,
                            radius: 4.h,
                            dotColor: appTheme.colorFFD9D9,
                            activeDotColor: const Color(0xFF8900FE),
                          ),
                        );
                      },
                    ),
                  )
          ],
        );
      },
    );
  }
}

Widget _buildAdsShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      width: 343.h,
      height: 180.h,
      color: Colors.white,
    ),
  );
}
