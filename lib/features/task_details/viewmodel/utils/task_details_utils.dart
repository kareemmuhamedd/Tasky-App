import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/features/create_task/model/task_model.dart';
import 'package:tasky_app/shared/utils/extensions/show_dialog_extension.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../../update_task/models/update_task_request.dart';
import '../../../update_task/viewmodel/bloc/update_task_bloc.dart';
import '../bloc/task_details_bloc.dart';

class TaskDetailsUtils {
  TaskDetailsUtils({
    required this.task,
    required this.context,
  });

  final TaskModel task;
  final BuildContext context;

  /// This function will check if the user has made any changes to the task
  /// If the user has made any changes, we will show a dialog to confirm if the user wants to go back
  /// If the user has not made any changes, we will just pop the context
  bool canPop(BuildContext context) {
    final bloc = context.read<UpdateTaskBloc>();

    final hasPriorityChanged = bloc.state.selectedPriority != null &&
        bloc.state.selectedPriority != task.priority;
    final hasStatusChanged = bloc.state.selectedProgressStatus != null &&
        bloc.state.selectedProgressStatus != task.status;

    return hasPriorityChanged || hasStatusChanged;
  }

  void confirmGoBack(BuildContext context) {
    final bloc = context.read<UpdateTaskBloc>();
    if (canPop(context)) {
      context.confirmAction(
        cancel: () {
          /// here if user clicks on cancel, we will pop the dialog without updating the task
          context.pop();
        },
        fn: () {
          /// here if the user clicks on yes, we will update the task and navigate back
          bloc.add(
            UpdateTaskRequestedWithImage(
              taskId: task.id,
              data: UpdateTaskRequest(
                priority: bloc.state.selectedPriority ?? task.priority,
                status: bloc.state.selectedProgressStatus ?? task.status,
              ),
            ),
          );
          context.pop();
        },
        title: 'You have unsaved changes. Do you want to save them?',
        content: 'Save changes and go back?',
        noText: 'No',
        yesText: 'Yes',
        yesTextStyle: AppTextStyles.font14WeightRegular.copyWith(
          color: AppColors.primaryColor,
        ),
        noTextStyle: AppTextStyles.font14WeightRegular.copyWith(
          color: AppColors.errorRedColor,
        ),
      );
    } else {
      /// if the user has not made any changes, we will just pop the context
      context.pop();
    }
  }

  void confirmDeleteTask(BuildContext context) {
    context.confirmAction(
      fn: () {
        context.read<TaskDetailsBloc>().add(DeleteTaskRequested(task.id));
        context.pop();
        context.pop();
      },
      title: 'Are you sure you want to delete this task?',
      content: 'The task will be deleted permanently.',
      noText: 'No',
      yesText: 'Yes',
      yesTextStyle: AppTextStyles.font14WeightRegular.copyWith(
        color: AppColors.primaryColor,
      ),
      noTextStyle: AppTextStyles.font14WeightRegular.copyWith(
        color: AppColors.errorRedColor,
      ),
    );
  }
}
