import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../shared/assets/icons.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../../../shared/widgets/custom_tile_widget.dart';
import '../../../update_task/viewmodel/bloc/update_task_bloc.dart';

class TaskProgressStatus extends StatelessWidget {
  const TaskProgressStatus({
    super.key, required this.taskProgressStatus,
  });
  final String taskProgressStatus;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateTaskBloc, UpdateTaskState>(
      builder: (context, state) {
        final selectedStatus = state.selectedProgressStatus ?? taskProgressStatus;
        return CustomTileWidget(
          prefix: Text(
            toBeginningOfSentenceCase(selectedStatus),
            style: AppTextStyles.font16WeightBold.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          suffix: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: SvgPicture.asset(AppIcons.roundedDownArrowIcon),
          ),
          options: const ['Waiting', 'Inprogress', 'Finished'],
          onOptionSelected: (selected) {
            context.read<UpdateTaskBloc>().add(
                  TaskProgressStatusUpdated(
                    selected.toLowerCase(),
                  ),
                );
          },
        );
      },
    );
  }
}
