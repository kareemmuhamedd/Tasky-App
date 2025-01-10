import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../bloc/home_bloc.dart';

class HomeUtils {
  static void deleteTaskWithUndoSnackBar(BuildContext context, index, task) {
    final homeBloc = context.read<HomeBloc>();
    final taskIndex = index; // Track the task's index before removing it

    /// Temporarily remove the task from the UI
    homeBloc.add(RemoveTaskFromUI(task.id));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Task deleted. Undo?',
          style:
              AppTextStyles.font14WeightRegular.copyWith(color: Colors.white),
        ),
        duration: const Duration(seconds: 6),
        action: SnackBarAction(
          label: 'Undo',
          textColor: AppColors.lightOrangeColor,
          onPressed: () {
            /// Dispatch event to undo deletion and restore the task to its original position
            homeBloc.add(
              UndoTaskDeletion(
                task,
                taskIndex,
              ),
            );
          },
        ),
        backgroundColor: AppColors.blackColor,
      ),
    );

    /// Wait 6 seconds and permanently delete the task if undo is not pressed
    Future.delayed(const Duration(seconds: 6), () {
      final currentState = homeBloc.state;
      final isTaskStillDeleted =
          !currentState.tasks.any((t) => t.id == task.id);

      if (isTaskStillDeleted) {
        homeBloc.add(DeleteTaskRequested(task.id));
      }
    });
  }
}
