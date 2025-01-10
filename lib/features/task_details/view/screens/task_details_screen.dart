import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky_app/features/create_task/model/task_model.dart';
import 'package:tasky_app/features/task_details/viewmodel/utils/task_details_utils.dart';
import 'package:tasky_app/features/update_task/viewmodel/bloc/update_task_bloc.dart';
import 'package:tasky_app/shared/assets/icons.dart';
import 'package:tasky_app/shared/typography/app_text_styles.dart';
import 'package:tasky_app/shared/widgets/custom_app_bar.dart';
import 'package:tasky_app/shared/widgets/custom_tile_widget.dart';
import '../../../../app/di/init_dependencies.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../viewmodel/bloc/task_details_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: serviceLocator<UpdateTaskBloc>(),
        ),
        BlocProvider.value(
          value: serviceLocator<TaskDetailsBloc>(),
        ),
      ],
      child: TaskDetailsBody(task: task),
    );
  }
}

class TaskDetailsBody extends StatelessWidget {
  const TaskDetailsBody({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: TaskDetailsUtils(task: task, context: context).canPop(context),
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        TaskDetailsUtils(task: task, context: context).confirmGoBack(context);
      },
      child: Scaffold(
        appBar: CustomAppBar(
          appBarTitle: 'Task Details',
          onBack: () => TaskDetailsUtils(task: task, context: context)
              .confirmGoBack(context),
          task: task,
          deleteTaskCallBack: () {
            TaskDetailsUtils(task: task, context: context)
                .confirmDeleteTask(context);
          },
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
                    ),
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
