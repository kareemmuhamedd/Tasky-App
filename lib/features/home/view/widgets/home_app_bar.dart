import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky_app/shared/assets/icons.dart';
import 'package:tasky_app/shared/typography/app_text_styles.dart';
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(left: 22.w),
        child: const Text(
          'Logo',
          style: AppTextStyles.font24WeightBold,
        ),
      ),
      titleSpacing: 0,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 22.w),
          child: SizedBox(
            width: 68.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // todo: handel the functionality of navigating to user profile
                  },
                  child: SvgPicture.asset(AppIcons.circleUserIcon),
                ),
                GestureDetector(
                  onTap: () {
                    // todo: handel the functionality of logging out
                  },
                  child: SvgPicture.asset(AppIcons.logoutIcon),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}