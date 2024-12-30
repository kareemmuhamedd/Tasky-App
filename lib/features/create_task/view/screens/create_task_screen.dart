import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_app/features/create_task/view/widgets/due_date_form_field.dart';
import 'package:tasky_app/features/create_task/view/widgets/priority_form_field.dart';
import 'package:tasky_app/features/create_task/view/widgets/task_title_form_field.dart';
import 'package:tasky_app/shared/networking/dio_factory.dart';
import 'package:tasky_app/shared/widgets/app_button.dart';

import 'package:tasky_app/shared/widgets/custom_app_bar.dart';

import '../../../../shared/typography/app_text_styles.dart';
import '../../model/create_task_request.dart';
import '../../repositories/create_task_repository.dart';
import '../../viewmodel/bloc/create_task_bloc.dart';
import '../widgets/custom_add_task_field_with_header.dart';
import '../widgets/custom_task_add_image_widget.dart';
import '../widgets/task_description_form_field.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTaskBloc(
        createTaskRepository: CreateTaskRepository(
          dio: DioFactory.getDio(),
        ),
      ),
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
                    field: TaskDescriptionFormField(onChanged: (value){
                      taskDescription = value;
                    },),
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
                      print(taskTitle);
                      print(taskDescription);
                      print(state.selectedDueDate);
                      print(state.selectedPriority);
                      // context.read<CreateTaskBloc>().add(
                      //       CreateTaskRequested(
                      //         CreateTaskRequest(
                      //           image: 'image',
                      //           title: 'title',
                      //           desc: 'description',
                      //           priority: 'high',
                      //           dueDate: '12-10-2012',
                      //         ),
                      //       ),
                      //     );
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
