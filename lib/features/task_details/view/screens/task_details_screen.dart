import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/features/create_task/model/task_model.dart';
import 'package:tasky_app/features/update_task/viewmodel/bloc/update_task_bloc.dart';
import 'package:tasky_app/shared/assets/icons.dart';
import 'package:tasky_app/shared/typography/app_text_styles.dart';
import 'package:tasky_app/shared/utils/extensions/show_dialog_extension.dart';
import 'package:tasky_app/shared/widgets/custom_app_bar.dart';
import 'package:tasky_app/shared/widgets/custom_tile_widget.dart';
import '../../../../app/di/init_dependencies.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../update_task/models/update_task_request.dart';
import '../widgets/task_priority.dart';
import '../widgets/task_progress_status.dart';
import '../widgets/task_qr_code.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: serviceLocator<UpdateTaskBloc>(),
      child: TaskDetailsBody(
        task: task,
      ),
    );
  }
}

class TaskDetailsBody extends StatelessWidget {
  const TaskDetailsBody({
    super.key,
    required this.task,
  });

  final TaskModel task;

  bool canPop(BuildContext context) {
    final bloc = context.read<UpdateTaskBloc>();

    final hasPriorityChanged = bloc.state.selectedPriority != null &&
        bloc.state.selectedPriority != task.priority;
    final hasStatusChanged = bloc.state.selectedProgressStatus != null &&
        bloc.state.selectedProgressStatus != task.status;

    return hasPriorityChanged || hasStatusChanged;
  }

  void _confirmGoBack(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop(context),
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _confirmGoBack(context);
      },
      child: Scaffold(
        appBar: CustomAppBar(
          appBarTitle: 'Task Details',
          onBack: () => _confirmGoBack(context),
          task: task,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 225.h,
                color: AppColors.lightOrangeColor,
                child: CachedNetworkImage(
                  imageUrl: task.image,
                  errorWidget: (context, url, error) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.warning_rounded,
                        color: AppColors.borderGreyColor,
                        size: 40,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Unable to load image.',
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Please try uploading a new one.',
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 14.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: AppTextStyles.font24WeightBold,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      task.desc,
                      style: AppTextStyles.font14WeightRegular.copyWith(
                        color: AppColors.blackColor.withOpacity(0.6),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomTileWidget(
                      prefix: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'End Date',
                            style: AppTextStyles.font9WeightRegular,
                          ),
                          Text(
                            task.getFormattedCreatedAt(),
                            style: AppTextStyles.font14WeightRegular.copyWith(
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                      suffix: SvgPicture.asset(AppIcons.calendarIcon),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    TaskProgressStatus(
                      taskProgressStatus: task.status,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    TaskPriority(
                      taskPriority: task.priority,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TaskQRCode(taskId: task.id),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
