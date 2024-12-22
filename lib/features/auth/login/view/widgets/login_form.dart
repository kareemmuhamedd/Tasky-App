import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/features/auth/login/view/widgets/password_form_field.dart';
import 'package:tasky_app/features/auth/login/view/widgets/phone_form_field.dart';

import '../../../../../shared/typography/app_text_styles.dart';
import '../../viewmodel/login_cubit/login_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login',
            style: AppTextStyles.font24WeightBold,
          ),
          SizedBox(height: 24.h),
          const PhoneFormField(),
          const SizedBox(
            height: 20,
          ),
          const PasswordFormField(),
        ],
      ),
    );
  }
}
