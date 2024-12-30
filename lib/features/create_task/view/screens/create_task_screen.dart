import 'package:flutter/material.dart';
import 'package:tasky_app/features/create_task/view/widgets/due_date_form_field.dart';
import 'package:tasky_app/features/create_task/view/widgets/priority_form_field.dart';
import 'package:tasky_app/features/create_task/view/widgets/task_title_form_field.dart';

import 'package:tasky_app/shared/widgets/custom_app_bar.dart';

import '../widgets/custom_add_task_field_with_header.dart';
import '../widgets/custom_task_add_image_widget.dart';
import '../widgets/task_description_form_field.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CreateTaskBody();
  }
}

class CreateTaskBody extends StatelessWidget {
  const CreateTaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        isHaveActions: false,
        appBarTitle: 'Add new task',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 24),
          child: Column(
            children: [
              CustomTaskAddImageWidget(),
              SizedBox(height: 16),
              CustomAddTaskFieldWithHeader(
                header: 'Task Title',
                field: TaskTitleFormField(),
              ),
              SizedBox(
                height: 16,
              ),
              CustomAddTaskFieldWithHeader(
                header: 'Task Description',
                field: TaskDescriptionFormField(),
              ),
              SizedBox(
                height: 16,
              ),
              CustomAddTaskFieldWithHeader(
                header: 'Priority',
                field: PriorityFormField(),
              ),
              SizedBox(
                height: 16,
              ),
              CustomAddTaskFieldWithHeader(
                header: 'Due Date',
                field: DueDateFormField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
