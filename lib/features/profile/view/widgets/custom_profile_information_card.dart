import 'package:flutter/material.dart';
import 'package:tasky_app/shared/theme/app_colors.dart';
import 'package:tasky_app/shared/typography/app_text_styles.dart';
class CustomProfileInformationCard extends StatelessWidget {
  const CustomProfileInformationCard({
    super.key,
    required this.cardTitle,
    required this.cardContent,
  });

  final String cardTitle;
  final String cardContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightGreyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cardTitle,
            style: AppTextStyles.font12WeightMedium.copyWith(
              color: AppColors.blackColor.withOpacity(0.4),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            cardContent,
            style: AppTextStyles.font18WeightBold.copyWith(
              color: AppColors.blackColor.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
