import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/app/bloc/app_bloc.dart';
import 'package:tasky_app/features/auth/login/model/login_model.dart';
import 'package:tasky_app/features/auth/login/view/widgets/login_form.dart';
import 'package:tasky_app/shared/theme/app_colors.dart';
import 'package:tasky_app/shared/widgets/app_button.dart';

import '../../../../../shared/assets/images.dart';
import '../../../../../shared/networking/dio_factory.dart';
import '../../../../../shared/typography/app_text_styles.dart';
import '../../../cubit/auth_cubit.dart';
import '../../repositories/login_remote_repository.dart';
import '../../viewmodel/login_cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        loginRemoteRepository: LoginRemoteRepository(
          dio: DioFactory.getDio(),
        ),
      ),
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
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state.status == LogInSubmissionStatus.success) {
                        context
                            .read<AppBloc>()
                            .add(const CheckOnboardingStatus());
                      }
                    },
                    builder: (context, state) {
                      final isLoading =
                          state.status == LogInSubmissionStatus.loading;
                      return AppButton(
                        isInProgress: isLoading,
                        onPressed: () {
                          context.read<LoginCubit>().onSubmitted(
                                data: LoginModel(
                                  phone: state.phoneNumber.countryCode +
                                      state.phoneNumber.value,
                                  password: state.password.value,
                                ),
                              );
                        },
                        appButtonWidget: const Text(
                          'Sign in',
                          style: AppTextStyles.font16WeightBold,
                        ),
                      );
                    },
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
                                final cubit = context.read<AuthCubit>();
                                cubit.changeAuth(showLogin: false);
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
