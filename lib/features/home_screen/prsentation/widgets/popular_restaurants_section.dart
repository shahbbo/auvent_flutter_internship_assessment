import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_text_style.dart';
import '../bloc/home_bloc.dart';
import 'restaurant_item_widget.dart';

class PopularRestaurantsSection extends StatelessWidget {
  const PopularRestaurantsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final restaurants = state.restaurants;
        final isLoading = state.isLoading && restaurants.isEmpty;
        return Padding(
          padding: EdgeInsets.fromLTRB(14.h, 0, 14.h, 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Popular restaurants nearby',
                style: AppTextStyle.instance.title16BoldDMSans
                    .copyWith(height: 1.31),
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
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                )
              else if (restaurants.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: const Text('No restaurants available'),
                  ),
                )
              else
                SizedBox(
                  height: 135.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: restaurants.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: index < restaurants.length - 1 ? 20.h : 0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            // Handle restaurant tap
                          },
                          child: RestaurantItemWidget(
                              restaurant: restaurants[index]),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
