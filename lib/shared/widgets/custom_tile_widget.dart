import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

class CustomTileWidget extends StatelessWidget {
  const CustomTileWidget({
    super.key,
    required this.prefix,
    required this.suffix,
    required this.options,
    this.onOptionSelected,
  });

  final Widget prefix;
  final Widget suffix;
  final List<String> options;
  final ValueChanged<String>? onOptionSelected;

  void _showCustomModalBottomSheet(BuildContext context) {
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
              children: options.map(
                (option) {
                  return ListTile(
                    title: Text(
                      option,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    onTap: () {
                      onOptionSelected != null
                          ? onOptionSelected!(option)
                          : null;
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCustomModalBottomSheet(context),
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
