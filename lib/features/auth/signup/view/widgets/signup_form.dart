import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/features/auth/signup/view/widgets/password_form_field.dart';
import 'package:tasky_app/features/auth/signup/view/widgets/phone_form_field.dart';
import 'package:tasky_app/features/auth/signup/view/widgets/years_of_experience_form_field.dart';
import 'package:tasky_app/features/auth/signup/viewmodel/signup_cubit/signup_cubit.dart';

import '../../../../../shared/typography/app_text_styles.dart';
import 'address_form_field.dart';
import 'experience_level_form_field.dart';
import 'name_form_field.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sign up',
            style: AppTextStyles.font24WeightBold,
          ),
          SizedBox(height: 24.h),
          const NameFormField(),
          const SizedBox(height: 20),
          const PhoneFormField(),
          const SizedBox(height: 20),
          const YearsOfExperienceFormField(),
          const SizedBox(height: 20),
          const ExperienceLevelFormField(),
          const SizedBox(height: 20),
          const AddressFromField(),
          const SizedBox(height: 20),
          const PasswordFormField(),
        ],
      ),
    );
  }
}
