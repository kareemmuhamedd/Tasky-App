import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../shared/assets/icons.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../../../shared/utils/ui_helper/ui_helper.dart';
import '../../../create_task/model/task_model.dart';

class TaskDescriptionWithDetails extends StatelessWidget {
  const TaskDescriptionWithDetails({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: AppTextStyles.font16WeightBold.copyWith(
                    color: AppColors.blackColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: UiHelper.getTaskStatusBGColor(
                    task.status,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  task.status,
                  style: AppTextStyles.font12WeightMedium.copyWith(
                    color: UiHelper.getTaskStatusTextColor(
                      task.status,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            task.desc,
            style: AppTextStyles.font14WeightRegular,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Skeleton.ignore(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.flagIcon,
                      colorFilter: ColorFilter.mode(
                        UiHelper.getTaskPriorityColor(
                          task.priority,
                        ),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      task.priority,
                      style: AppTextStyles.font12WeightMedium.copyWith(
                        color: UiHelper.getTaskPriorityColor(
                          task.priority,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  task.getFormattedCreatedAt(),
                  style: AppTextStyles.font12WeightRegular.copyWith(
                    color: AppColors.blackColor.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
