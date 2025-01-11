import 'package:flutter/material.dart';
import 'package:tasky_app/features/home/view/widgets/task_circle_image.dart';
import 'package:tasky_app/features/home/view/widgets/task_description_with_details.dart';
import 'package:tasky_app/features/home/view/widgets/task_vertical_dots_button.dart';

import '../../../create_task/model/task_model.dart';

class HomeListItemCard extends StatelessWidget {
  const HomeListItemCard({
    super.key,
    required this.task,
    required this.cardIndex,
  });

  final TaskModel task;
  final int cardIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 96,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TaskCircleImage(task: task),
          const SizedBox(width: 12),
          TaskDescriptionWithDetails(task: task),
          const SizedBox(width: 17),
          TaskVerticalDotsButton(task: task, cardIndex: cardIndex),
        ],
      ),
    );
  }
}
