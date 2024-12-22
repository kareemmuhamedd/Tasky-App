import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_app/features/auth/signup/viewmodel/signup_cubit/signup_cubit.dart';

import '../../../../../shared/theme/app_colors.dart';
import '../../../../../shared/widgets/custom_text_form_field.dart';

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordVisible = context.select(
      (SignupCubit cubit) => cubit.state.showPassword,
    );
    return CustomTextFormField(
      contentPadding: const EdgeInsets.only(left: 15),
      hintText: 'Password...',
      suffixIcon: GestureDetector(
        onTap: () {
          context.read<SignupCubit>().changePasswordVisibility();
        },
        child: Icon(
          passwordVisible ? Icons.visibility : Icons.visibility_off,
          color: AppColors.borderGreyColor,
        ),
      ),
      obscureText: !passwordVisible,
    );
  }
}
