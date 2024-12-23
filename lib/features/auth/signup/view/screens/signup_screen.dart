import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/app/routes/app_routes.dart';
import 'package:tasky_app/features/auth/signup/repositories/signup_remote_repository.dart';
import 'package:tasky_app/features/auth/signup/view/widgets/signup_form.dart';
import 'package:tasky_app/shared/networking/dio_factory.dart';

import '../../../../../shared/assets/images.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../../../../../shared/typography/app_text_styles.dart';
import '../../../../../shared/widgets/app_button.dart';
import '../../model/signup_model.dart';
import '../../viewmodel/signup_cubit/signup_cubit.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
        signupRemoteRepository: SignupRemoteRepository(
          dio: DioFactory.getDio(),
        ),
      ),
      child: const SignupView(),
    );
  }
}

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300.h,
              width: double.infinity,
              child: Image.asset(
                AppImages.artImage,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SignupForm(),
                  const SizedBox(
                    height: 24,
                  ),
                  BlocBuilder<SignupCubit, SignupState>(
                    builder: (context, state) {
                      final isLoading =
                          state.status == SignupSubmissionStatus.loading;
                      return AppButton(
                        isInProgress: isLoading,
                        onPressed: () {
                          context.read<SignupCubit>().onSubmitted(
                                data: SignupModel(
                                  phone: state.phoneNumber,
                                  password: state.password,
                                  displayName: state.name,
                                  experienceYears:
                                      int.parse(state.yearsOfExperience),
                                  address: state.address,
                                  level: state.experienceLevel,
                                ),
                              );
                        },
                        appButtonWidget: const Text(
                          'Sign up',
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
                        text: "Already have any account? ",
                        style: AppTextStyles.font14WeightRegular,
                        children: [
                          TextSpan(
                            text: "Sign in",
                            style: AppTextStyles.font14WeightBold.copyWith(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryColor,
                              decorationThickness: 1.5,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(AppRoutesPaths.kLoginScreen);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
