import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/shared/typography/app_text_styles.dart';

import '../../../../shared/assets/icons.dart';
import '../../features/task_details/view/widgets/custom_drop_down_menu.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.appBarTitle,
    this.isHaveActions = true,
  });

  final bool isHaveActions;
  final String appBarTitle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      leadingWidth: 60.0,
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
        appBarTitle,
        style: AppTextStyles.font16WeightBold.copyWith(
          color: Colors.black,
        ),
      ),
      actions: isHaveActions
          ? const [
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: CustomDropdownMenu(),
              )
            ]
          : null,
    );
  }
}