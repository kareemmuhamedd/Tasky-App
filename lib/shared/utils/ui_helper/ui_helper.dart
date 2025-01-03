import 'package:flutter/material.dart';
import 'package:tasky_app/shared/theme/app_colors.dart';

abstract class UiHelper {
  // ui_helpers.dart

  static Color getTaskStatusBGColor(String status) {
    switch (status.toLowerCase()) {
      case 'inprogress':
        return AppColors.lightPurpleColor;
      case 'waiting':
        return AppColors.lightOrangeColor;
      case 'completed':
        return AppColors.lightBlueColor;
      default:
        return AppColors.textGreyColor3;
    }
  }

  static Color getTaskStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'inprogress':
        return AppColors.primaryColor;
      case 'waiting':
        return AppColors.orangeColor;
      case 'completed':
        return AppColors.blueColor;
      default:
        return AppColors.textGreyColor;
    }
  }

  static Color getTaskPriorityColor(String status) {
    switch (status.toLowerCase()) {
      case 'low':
        return AppColors.blueColor;
      case 'medium':
        return AppColors.primaryColor;
      case 'high':
        return AppColors.orangeColor;
      default:
        return AppColors.blackColor;
    }
  }
}
