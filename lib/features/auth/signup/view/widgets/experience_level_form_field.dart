import 'package:flutter/material.dart';

import '../../../../../shared/theme/app_colors.dart';
import '../../../../../shared/typography/app_text_styles.dart';
import '../../../../../shared/widgets/custom_text_form_field.dart';

class ExperienceLevelFormField extends StatefulWidget {
  const ExperienceLevelFormField({super.key});

  @override
  State<ExperienceLevelFormField> createState() =>
      _ExperienceLevelFormFieldState();
}

class _ExperienceLevelFormFieldState extends State<ExperienceLevelFormField> {
  String? _selectedExperienceLevel;

  final List<String> _experienceLevels = [
    'Fresh',
    'Junior',
    'Senior',
  ];

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      onTap: () async {
        final selectedValue = await showModalBottomSheet<String>(
          context: context,
          builder: (context) {
            return ListView(
              shrinkWrap: true,
              children: _experienceLevels
                  .map(
                    (level) => ListTile(
                      title: Text(level),
                      onTap: () => Navigator.of(context).pop(level),
                    ),
                  )
                  .toList(),
            );
          },
        );

        if (selectedValue != null) {
          setState(() {
            _selectedExperienceLevel = selectedValue;
          });
        }
      },
      contentPadding: const EdgeInsets.only(left: 15),
      hintText: _selectedExperienceLevel ?? 'Choose experience level',
      hintStyle: AppTextStyles.font14WeightMedium,
      suffixIcon: const Icon(
        Icons.keyboard_arrow_down_outlined,
        color: AppColors.textGreyColor2,
      ),
      readOnly: true, // Makes it non-editable
    );
  }
}
