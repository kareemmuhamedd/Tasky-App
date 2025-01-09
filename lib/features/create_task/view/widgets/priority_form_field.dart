import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../shared/assets/icons.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../../../shared/widgets/custom_tile_widget.dart';
import '../../viewmodel/bloc/create_task_bloc.dart';

class PriorityFormField extends StatelessWidget {
  const PriorityFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTaskBloc, CreateTaskState>(
      builder: (context, state) {
        final selectedPriority = state.selectedPriority ?? 'Medium';

        return CustomTileWidget(
          prefix: Row(
            children: [
              SvgPicture.asset(
                AppIcons.flagIcon,
                height: 24,
              ),
              SizedBox(width: 10.w),
              Text(
                '$selectedPriority Priority',
                style: AppTextStyles.font16WeightBold.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          suffix: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: SvgPicture.asset(AppIcons.roundedDownArrowIcon),
          ),
          options: const ['Low', 'Medium', 'High'],
          onOptionSelected: (selected) {
            context.read<CreateTaskBloc>().add(
                  PriorityChanged(
                    selected.toLowerCase(),
                  ),
                );
          },
        );
      },
    );
  }
}
