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
import 'package:tasky_app/shared/utils/extensions/show_dialog_extension.dart';
import 'package:tasky_app/shared/widgets/custom_app_bar.dart';
import 'package:tasky_app/shared/widgets/custom_tile_widget.dart';
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

  bool canPop(BuildContext context) {
    final bloc = context.read<UpdateTaskBloc>();
    print('Selected Priority: ${bloc.state.selectedPriority}');
    print('Task Priority: ${task.priority}');
    print('Selected Status: ${bloc.state.selectedProgressStatus}');
    print('Task Status: ${task.status}');

    if ((bloc.state.selectedPriority != null ||
        bloc.state.selectedProgressStatus != null) &&
        (bloc.state.selectedPriority != task.priority ||
            bloc.state.selectedProgressStatus != task.status)) {
      print('Unsaved changes detected.');
      return true;
    } else {
      print('No unsaved changes.');
      return false;
    }
  }


  void _confirmGoBack(BuildContext context) {
    final bloc = context.read<UpdateTaskBloc>();
    context.confirmAction(
      cancel: () {
        context.pop();
      },
      fn: () {
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
