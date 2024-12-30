import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/assets/icons.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../../task_details/view/screens/task_details_screen.dart';
class PriorityFormField extends StatelessWidget {
  const PriorityFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTileWidget(
      prefix: Row(
        children: [
          SvgPicture.asset(
            AppIcons.flagIcon,
            height: 24,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            'Medium Priority',
            style: AppTextStyles.font16WeightBold.copyWith(
              color: AppColors.primaryColor,
            ),
          )
        ],
      ),
      suffix: Padding(
        padding: const EdgeInsets.only(right: 4),
        child: SvgPicture.asset(AppIcons.roundedDownArrowIcon),
      ),
    );
  }
}
