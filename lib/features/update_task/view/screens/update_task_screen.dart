import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_app/features/create_task/model/task_model.dart';
import 'package:tasky_app/features/update_task/models/update_task_request.dart';
import 'package:tasky_app/features/update_task/view/widgets/custom_update_task_field_with_header.dart';
import 'package:tasky_app/features/update_task/view/widgets/custom_update_task_image.dart';
import 'package:tasky_app/features/update_task/view/widgets/update_task_description_form_field.dart';
import 'package:tasky_app/features/update_task/view/widgets/update_task_title_form_field.dart';
import '../../../../shared/networking/dio_factory.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../../../shared/utils/snack_bars/custom_snack_bar.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../create_task/repositories/create_task_repository.dart';
import '../../../task_details/view/widgets/task_priority.dart';
import '../../../task_details/view/widgets/task_progress_status.dart';
import '../../repositories/update_task_remote_repository.dart';
import '../../viewmodel/bloc/update_task_bloc.dart';

class UpdateTaskScreen extends StatelessWidget {
  const UpdateTaskScreen({
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
      child: UpdateTaskBody(
        task: task,
      ),
    );
  }
}

class UpdateTaskBody extends StatelessWidget {
  const UpdateTaskBody({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    String? taskTitle;
    String? taskDescription;
    return Scaffold(
      appBar: const CustomAppBar(
        isHaveActions: false,
        appBarTitle: 'Update Task',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
          child: Column(
            children: [
              CustomUpdateTaskImageWidget(task: task),
              const SizedBox(height: 16),
              CustomUpdateTaskFieldWithHeader(
                header: 'Task Title',
                field: UpdateTaskTitleFormField(
                  onChanged: (value) {
                    taskTitle = value;
                  },
                  initialTitle: task.title,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomUpdateTaskFieldWithHeader(
                header: 'Task Description',
                field: UpdateTaskDescriptionFormField(
                  onChanged: (value) {
                    taskDescription = value;
                  },
                  initialDescription: task.desc,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomUpdateTaskFieldWithHeader(
                header: 'Status',
                field: TaskProgressStatus(
                  taskProgressStatus: task.status,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomUpdateTaskFieldWithHeader(
                header: 'Priority',
                field: TaskPriority(
                  taskPriority: task.priority,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              BlocConsumer<UpdateTaskBloc, UpdateTaskState>(
                listener: (context, state) {
                  if (state.status == UpdateTaskStatus.success) {
                    showCustomSnackBar(
                      context,
                      'Task updated successfully',
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading = state.status == UpdateTaskStatus.loading;
                  return AppButton(
                    isInProgress: isLoading,
                    appButtonWidget: const Text(
                      'Update Task',
                      style: AppTextStyles.font16WeightBold,
                    ),
                    onPressed: () {
                      context.read<UpdateTaskBloc>().add(
                            UpdateTaskRequestedWithImage(
                              taskImage: state.image,
                              data: UpdateTaskRequest(
                                title: taskTitle ?? task.title,
                                desc: taskDescription ?? task.desc,
                                priority:
                                    state.selectedPriority ?? task.priority,
                                status:
                                    state.selectedProgressStatus ?? task.status,
                              ),
                              taskId: task.id,
                            ),
                          );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
