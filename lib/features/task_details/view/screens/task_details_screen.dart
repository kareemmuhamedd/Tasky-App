import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/features/create_task/model/task_model.dart';
import 'package:tasky_app/features/create_task/repositories/create_task_repository.dart';
import 'package:tasky_app/features/update_task/repositories/update_task_remote_repository.dart';
import 'package:tasky_app/features/update_task/viewmodel/bloc/update_task_bloc.dart';
import 'package:tasky_app/shared/assets/icons.dart';
import 'package:tasky_app/shared/networking/dio_factory.dart';
import 'package:tasky_app/shared/typography/app_text_styles.dart';
import 'package:tasky_app/shared/widgets/custom_app_bar.dart';
import 'package:tasky_app/shared/widgets/custom_tile_widget.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../update_task/models/update_task_request.dart';
import '../widgets/task_priority.dart';
import '../widgets/task_progress_status.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateTaskBloc(
        updateTaskRemoteRepository: UpdateTaskRemoteRepository(
          dio: DioFactory.getDio(),
        ),
        createTaskRepository: CreateTaskRepository(
          dio: DioFactory.getDio(),
        ),
      ),
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

  Future<bool> _handleUnsavedChanges(BuildContext context) async {
    final bloc = context.read<UpdateTaskBloc>();

    if ((bloc.state.selectedPriority != null ||
            bloc.state.selectedProgressStatus != null) &&
        (bloc.state.selectedPriority != task.priority ||
            bloc.state.selectedProgressStatus != task.status)) {
      final shouldLeave = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Unsaved Changes'),
          content:
              const Text('You have unsaved changes. Do you want to save them?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                context.pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                bloc.add(
                  UpdateTaskRequestedWithImage(
                    taskId: task.id,
                    data: UpdateTaskRequest(
                      priority: bloc.state.selectedPriority ?? task.priority,
                      status: bloc.state.selectedProgressStatus ?? task.status,
                    ),
                  ),
                );
                Navigator.of(context).pop(true); // Close the dialog
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      );
      return shouldLeave ?? false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _handleUnsavedChanges(context),
      child: Scaffold(
        appBar: CustomAppBar(
          appBarTitle: 'Task Details',
          onBack: () async {
            final shouldLeave = await _handleUnsavedChanges(context);
            if (shouldLeave) {
              void onBack() => context.pop();
              onBack.call();
            }
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
                    Center(
                      child: Container(
                        height: 326,
                        width: 326,
                        color: AppColors.whiteColor,
                        child: const Center(
                          child: Icon(Icons.qr_code_2_outlined, size: 300),
                        ),
                      ),
                    ),
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
