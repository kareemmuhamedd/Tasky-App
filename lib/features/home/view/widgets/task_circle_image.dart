import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../create_task/model/task_model.dart';

class TaskCircleImage extends StatelessWidget {
  const TaskCircleImage({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(64),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(64),
        child: CachedNetworkImage(
          imageUrl: task.image,
          placeholder: (context, url) => Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: AppColors.lightPurpleColor,
              shape: BoxShape.circle,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.warning_rounded,
            color: AppColors.borderGreyColor,
            size: 64,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
