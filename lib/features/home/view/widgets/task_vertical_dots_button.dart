import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../shared/assets/icons.dart';
import '../../../../shared/widgets/custom_app_bottom_sheet.dart';
import '../../../create_task/model/task_model.dart';
import '../../viewmodel/utils/home_utils.dart';

class TaskVerticalDotsButton extends StatelessWidget {
  const TaskVerticalDotsButton({
    super.key,
    required this.task,
    required this.cardIndex,
  });

  final TaskModel task;
  final int cardIndex;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 11),
        child: GestureDetector(
          onTap: () {
            showCustomModalBottomSheet(
              context: context,
              options: [
                'Edit',
                'Delete',
              ],
              onOptionSelected: (selected) {
                if (selected == 'Edit') {
                  context.pushNamed(
                    AppRoutesPaths.kUpdateTaskScreen,
                    extra: task,
                  );
                } else {
                  HomeUtils.deleteTaskWithUndoSnackBar(
                    context,
                    cardIndex,
                    task,
                  );
                }
              },
            );
          },
          child: SvgPicture.asset(
            AppIcons.verticalDotIcon,
          ),
        ),
      ),
    );
  }
}
