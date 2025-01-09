import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/widgets/custom_text_form_field.dart';
import '../../viewmodel/signup_cubit/signup_cubit.dart';

class YearsOfExperienceFormField extends StatefulWidget {
  const YearsOfExperienceFormField({super.key});

  @override
  State<YearsOfExperienceFormField> createState() =>
      _YearsOfExperienceFormFieldState();
}

class _YearsOfExperienceFormFieldState
    extends State<YearsOfExperienceFormField> {
  late TextEditingController _yearsOfExperienceController;

  @override
  void initState() {
    super.initState();

    _yearsOfExperienceController = TextEditingController();

    _yearsOfExperienceController.addListener(() {
      if (_yearsOfExperienceController.text.isNotEmpty) {
        context
            .read<SignupCubit>()
            .onYearsOfExperienceChanged(_yearsOfExperienceController.text);
      }
    });
  }

  @override
  void dispose() {
    _yearsOfExperienceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final yearsOfExperienceError = context.select(
      (SignupCubit cubit) => cubit.state.yearsOfExperience.errorMessage,
    );
    return CustomTextFormField(
      errorText: yearsOfExperienceError,
      contentPadding: const EdgeInsets.only(left: 15),
      hintText: 'Years of experience...',
      controller: _yearsOfExperienceController,
    );
  }
}
