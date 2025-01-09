import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import 'custom_app_bottom_sheet.dart';

class CustomTileWidget extends StatelessWidget {
  const CustomTileWidget({
    super.key,
    required this.prefix,
    required this.suffix,
    this.options,
    this.onOptionSelected,
  });

  final Widget prefix;
  final Widget suffix;
  final List<String>? options;
  final ValueChanged<String>? onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => options == null
          ? null
          : showCustomModalBottomSheet(
              context: context,
              options: options,
              onOptionSelected: onOptionSelected,
            ),
      child: Container(
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.lightPurpleColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 15,
            top: 7,
            bottom: 7,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              prefix,
              suffix,
            ],
          ),
        ),
      ),
    );
  }
}
