import 'package:flutter/material.dart';
import 'package:tasky_app/shared/typography/app_text_styles.dart';

import '../../../../shared/theme/app_colors.dart';

class CustomUpdateTaskFieldWithHeader extends StatelessWidget {
  const CustomUpdateTaskFieldWithHeader({
    super.key,
    required this.header,
    required this.field,
  });

  final String header;
  final Widget field;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: AppTextStyles.font12WeightRegular.copyWith(
            color: AppColors.textGreyColor,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        field,
      ],
    );
  }
}
