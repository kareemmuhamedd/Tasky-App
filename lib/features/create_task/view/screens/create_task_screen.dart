import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasky_app/features/create_task/view/widgets/due_date_form_field.dart';
import 'package:tasky_app/features/create_task/view/widgets/priority_form_field.dart';
import 'package:tasky_app/shared/widgets/task_title_form_field.dart';
import 'package:tasky_app/shared/widgets/app_button.dart';
import 'package:tasky_app/shared/widgets/custom_app_bar.dart';
import '../../../../app/di/init_dependencies.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../../../shared/utils/snack_bars/custom_snack_bar.dart';
import '../../model/create_task_request.dart';
import '../../viewmodel/bloc/create_task_bloc.dart';
import '../widgets/custom_add_task_field_with_header.dart';
import '../widgets/custom_task_add_image_widget.dart';
import '../../../../shared/widgets/task_description_form_field.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: serviceLocator<CreateTaskBloc>(),
      child: const CreateTaskBody(),
    );
  }
}

class CreateTaskBody extends StatelessWidget {
  const CreateTaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    String? taskTitle;
    String? taskDescription;
    return Scaffold(
      appBar: const CustomAppBar(
        isHaveActions: false,
        appBarTitle: 'Add new task',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
          child: BlocBuilder<CreateTaskBloc, CreateTaskState>(
            builder: (context, state) {
              final isLoading = state.status == CreateTaskStatus.loading;
              return Column(
                children: [
                  const CustomTaskAddImageWidget(),
                  const SizedBox(height: 16),
                  CustomAddTaskFieldWithHeader(
                    header: 'Task Title',
                    field: TaskTitleFormField(
                      onChanged: (value) {
                        taskTitle = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomAddTaskFieldWithHeader(
                    header: 'Task Description',
                    field: TaskDescriptionFormField(
                      onChanged: (value) {
                        taskDescription = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const CustomAddTaskFieldWithHeader(
                    header: 'Priority',
                    field: PriorityFormField(),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const CustomAddTaskFieldWithHeader(
                    header: 'Due Date',
                    field: DueDateFormField(),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  AppButton(
                    isInProgress: isLoading,
                    appButtonWidget: const Text(
                      'Add Task',
                      style: AppTextStyles.font16WeightBold,
                    ),
                    onPressed: () {
                      if (taskTitle == null || taskDescription == null) {
                        showCustomSnackBar(
                          context,
                          'Please fill all fields',
                          isError: true,
                        );
                        return;
                      } else {
                        context.read<CreateTaskBloc>().add(
                              CreateTaskRequestedWithImage(
                                taskImage: state.image!,
                                data: CreateTaskRequest(
                                  image: '',
                                  title: taskTitle ?? '',
                                  desc: taskDescription ?? '',
                                  priority: state.selectedPriority ?? 'medium',
                                  dueDate: state.selectedDueDate ??
                                      DateFormat('dd/MM/yyyy').format(
                                        DateTime.now().add(
                                          const Duration(days: 2),
                                        ),
                                      ),
                                ),
                              ),
                            );
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
