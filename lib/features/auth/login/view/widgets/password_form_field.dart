import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/theme/app_colors.dart';
import '../../../../../shared/widgets/custom_text_form_field.dart';
import '../../viewmodel/login_cubit/login_cubit.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({super.key});

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _passwordController.addListener(() {
      if (_passwordController.text.isNotEmpty) {
        context.read<LoginCubit>().onPasswordChanged(_passwordController.text);
      }
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

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
      controller: _passwordController,
    );
  }
}
