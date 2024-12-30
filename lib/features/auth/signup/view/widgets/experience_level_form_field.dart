import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/theme/app_colors.dart';
import '../../../../../shared/typography/app_text_styles.dart';
import '../../../../../shared/widgets/custom_text_form_field.dart';
import '../../viewmodel/signup_cubit/signup_cubit.dart';

class ExperienceLevelFormField extends StatefulWidget {
  const ExperienceLevelFormField({super.key});

  @override
  State<ExperienceLevelFormField> createState() =>
      _ExperienceLevelFormFieldState();
}

class _ExperienceLevelFormFieldState extends State<ExperienceLevelFormField> {
  String? _selectedExperienceLevel;
  late TextEditingController _experienceLevelController;

  final List<String> _experienceLevels = [
    'fresh',
    'junior',
    'midLevel',
    'senior',
  ];

  @override
  void initState() {
    super.initState();
    _experienceLevelController = TextEditingController();

    _experienceLevelController.addListener(() {
      if (_experienceLevelController.text.isNotEmpty) {
        context
            .read<SignupCubit>()
            .onExperienceLevelChanged(_experienceLevelController.text);
      }
    });
  }

  @override
  void dispose() {
    _experienceLevelController.dispose();
    super.dispose();
  }

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
            _experienceLevelController.text = selectedValue;
          });
        }
      },
      contentPadding: const EdgeInsets.only(left: 15),
      controller: _experienceLevelController,
      hintText: _selectedExperienceLevel ?? 'Choose experience level',
      hintStyle: AppTextStyles.font14WeightMedium,
      suffixIcon: const Icon(
        Icons.keyboard_arrow_down_outlined,
        color: AppColors.textGreyColor2,
      ),
      readOnly: true,
    );
  }
}
