import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/di/injections.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/custom_image_view.dart';

import '../bloc/home_bloc.dart';
import '../widgets/restaurant_item_widget.dart';
import '../widgets/service_item_widget.dart';
import '../widgets/shortcut_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => sl<HomeBloc>()..add(HomeInitialEvent()),
      child: const HomeScreen(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        // Always show the content but with shimmer for loading parts
        return Scaffold(
          bottomNavigationBar: _buildBottomNavigationBar(context, state),
          backgroundColor: appTheme.whiteCustom,
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(LoadHomeDataEvent());
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  _buildHeaderSection(context, state),
                  _buildServicesSection(context, state),
                  _buildPromoCodeSection(context),
                  _buildShortcutsSection(context, state),
                  _buildAdsSlider(context, state),
                  _buildAdsIndicator(context, state),
                  _buildPopularRestaurantsSection(context, state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Header section
  Widget _buildHeaderSection(BuildContext context, HomeState state) {
    return Container(
      height: 156.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
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

  // Services section
  Widget _buildServicesSection(BuildContext context, HomeState state) {
    final services = state.services;
    final isLoading = state.isLoading && services.isEmpty;

    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 10.h, 8.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services:',
            style:
                AppTextStyle.instance.title20BoldDMSans.copyWith(height: 1.35),
          ),
          SizedBox(height: 10.h),
          if (isLoading)
            buildShimmerServices()
          else if (services.isEmpty && state.error.isNotEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  children: [
                    Text(state.error),
                    TextButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(GetServicesEvent());
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          else if (services.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Text('No services available'),
              ),
            )
          else
            SizedBox(
              height: 135.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: services.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index < services.length - 1 ? 20.h : 0,
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: ServiceItemWidget(service: services[index]),
                    ),
                  );
                },
              ),
            ),
          SizedBox(height: 19.h),
        ],
      ),
    );
  }

  // Promo code section
  Widget _buildPromoCodeSection(BuildContext context) {
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
              offset: Offset(2, 2),
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

  // Shortcuts section
  Widget _buildShortcutsSection(BuildContext context, HomeState state) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    final shortcuts = homeBloc.shortcutsList;

    return Padding(
      padding: EdgeInsets.fromLTRB(10.h, 0, 10.h, 37.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shortcuts:',
            style:
                AppTextStyle.instance.title20BoldDMSans.copyWith(height: 1.35),
          ),
          SizedBox(height: 23.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              shortcuts.length,
              (index) => ShortcutItemWidget(shortcut: shortcuts[index]),
            ),
          ),
        ],
      ),
    );
  }

  // Ads slider section
  Widget _buildAdsSlider(BuildContext context, HomeState state) {
    final ads = state.ads;
    final isLoading = state.isLoading && ads.isEmpty;

    return Padding(
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
    );
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

  Widget _buildAdsIndicator(BuildContext context, HomeState state) {
    final ads = state.ads;

    if (ads.isEmpty) return const SizedBox.shrink();

    return Padding(
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
    );
  }

  //popular restaurants section
  Widget _buildPopularRestaurantsSection(
      BuildContext context, HomeState state) {
    final restaurants = state.restaurants;
    final isLoading = state.isLoading && restaurants.isEmpty;

    return Padding(
      padding: EdgeInsets.fromLTRB(14.h, 0, 14.h, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular restaurants nearby',
            style:
                AppTextStyle.instance.title16BoldDMSans.copyWith(height: 1.31),
          ),
          SizedBox(height: 16.h),
          if (isLoading)
            buildShimmerRestaurants()
          else if (restaurants.isEmpty && state.error.isNotEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  children: [
                    Text(state.error),
                    TextButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(GetRestaurantsEvent());
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          else if (restaurants.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Text('No restaurants available'),
              ),
            )
          else
            SizedBox(
              height: 135.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: restaurants.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index < restaurants.length - 1 ? 20.h : 0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // Handle restaurant tap
                      },
                      child:
                          RestaurantItemWidget(restaurant: restaurants[index]),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  //bottom navigation bar
  Widget _buildBottomNavigationBar(BuildContext context, HomeState state) {
    final items = [
      {'icon': AppAssets.nawelNavBar, 'label': 'Home'},
      {'icon': AppAssets.categoriesNavBar, 'label': 'Categories'},
      {'icon': AppAssets.deliverNavBar, 'label': 'Deliver'},
      {'icon': AppAssets.cartNavBar, 'label': 'Cart'},
      {'icon': AppAssets.profileNavBar, 'label': 'Profile'},
    ];

    return Container(
      constraints: BoxConstraints(maxWidth: 375.h),
      child: Container(
        height: 70.w,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.h),
            topRight: Radius.circular(24.h),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(items.length, (index) {
              final item = items[index];
              return GestureDetector(
                onTap: () {
                  BlocProvider.of<HomeBloc>(context)
                      .add(BottomNavTappedEvent(index));
                },
                child: _buildBottomNavItem(
                  context,
                  item['icon']!,
                  item['label']!,
                  state.selectedIndex == index,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
      BuildContext context, String iconPath, String label, bool isActive) {
    return Column(
      children: [
        isActive
            ? Container(
                width: 51.h,
                height: 6.h,
                decoration: BoxDecoration(
                  color: appTheme.colorFF8900,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5.h),
                    bottomRight: Radius.circular(5.h),
                  ),
                ),
              )
            : SizedBox(
                width: 51.h,
                height: 6.h,
              ),
        CustomImageView(
          imagePath: iconPath,
          height: 24.h,
          width: 24.h,
          fit: BoxFit.contain,
        ),
        SizedBox(height: isActive ? 4.h : 1.h),
        Text(
          label,
          style: AppTextStyle.instance.body12Poppins.copyWith(
              color: isActive ? Color(0xFF8900FE) : appTheme.colorFF474B,
              height: 1.5),
        ),
      ],
    );
  }
}
