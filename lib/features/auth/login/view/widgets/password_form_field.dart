import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/theme/app_colors.dart';
import '../../../../../shared/widgets/custom_text_form_field.dart';
import '../../viewmodel/login_cubit/login_cubit.dart';

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordVisible = context.select(
      (LoginCubit cubit) => cubit.state.showPassword,
    );
    return CustomTextFormField(
      contentPadding: const EdgeInsets.only(left: 15),
      hintText: 'Password...',
      suffixIcon: GestureDetector(
        onTap: () {
          context.read<LoginCubit>().changePasswordVisibility();
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
