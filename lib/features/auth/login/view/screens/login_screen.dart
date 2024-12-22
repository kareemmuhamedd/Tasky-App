import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/app/routes/app_routes.dart';
import 'package:tasky_app/features/auth/login/view/widgets/login_form.dart';
import 'package:tasky_app/shared/theme/app_colors.dart';
import 'package:tasky_app/shared/widgets/app_button.dart';

import '../../../../../shared/assets/images.dart';
import '../../../../../shared/typography/app_text_styles.dart';
import '../../viewmodel/login_cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(AppImages.artImage),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LoginForm(),
                  const SizedBox(
                    height: 24,
                  ),
                  AppButton(
                    onPressed: () {},
                    appButtonWidget: const Text(
                      'Sign in',
                      style: AppTextStyles.font16WeightBold,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: "Did’t have any account? ",
                        style: AppTextStyles.font14WeightRegular,
                        children: [
                          TextSpan(
                            text: "Sign Up here",
                            style: AppTextStyles.font14WeightBold.copyWith(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryColor,
                              decorationThickness: 1.5,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(AppRoutesPaths.kSignupScreen);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
