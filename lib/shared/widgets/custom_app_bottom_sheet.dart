import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

void showCustomModalBottomSheet({
  required BuildContext context,
  List<String>? options,
  ValueChanged<String>? onOptionSelected,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: const BoxDecoration(
            color: AppColors.lightPurpleColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: options!.map(
              (option) {
                return ListTile(
                  title: Text(
                    option,
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  onTap: () {
                    onOptionSelected != null ? onOptionSelected(option) : null;
                    Navigator.pop(context);
                  },
                );
              },
            ).toList(),
          ),
        ),
      );
    },
  );
}
