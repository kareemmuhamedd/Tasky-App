import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/shared/typography/app_text_styles.dart';

import '../../../../shared/assets/icons.dart';
import 'custom_drop_down_menu.dart';
class CustomTaskDetailsScreenAppBar extends StatelessWidget {
  const CustomTaskDetailsScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 45,
      titleSpacing: 0.0,
      leadingWidth: 50.0,
      leading: Center(
        child: Transform.flip(
          flipX: true,
          child: GestureDetector(
            onTap: () => context.pop(),
            child: SvgPicture.asset(
              AppIcons.arrowLeftIcon,
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
      title: Text(
        'Task Details',
        style: AppTextStyles.font16WeightBold.copyWith(
          color: Colors.black,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: CustomDropdownMenu(),
        )
      ],
    );
  }
}
