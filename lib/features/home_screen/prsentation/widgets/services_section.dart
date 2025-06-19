import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_text_style.dart';
import '../bloc/home_bloc.dart';
import 'service_item_widget.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final services = state.services;
        final isLoading = state.isLoading && services.isEmpty;
        return Padding(
          padding: EdgeInsets.fromLTRB(8.w, 10.h, 8.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Services:',
                style: AppTextStyle.instance.title20BoldDMSans
                    .copyWith(height: 1.35),
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
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                )
              else if (services.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: const Text('No services available'),
                  ),
                )
              else
                SizedBox(
                  height: 135.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: services.length,
                    physics: const BouncingScrollPhysics(),
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
      },
    );
  }
}
