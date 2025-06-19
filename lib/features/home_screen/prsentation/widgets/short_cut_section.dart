import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_text_style.dart';
import '../bloc/home_bloc.dart';
import 'shortcut_item_widget.dart';

class ShortCutSection extends StatelessWidget {
  const ShortCutSection({super.key});

  @override
  Widget build(BuildContext context) {
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
}
