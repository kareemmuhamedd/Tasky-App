import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/features/auth/signup/view/widgets/signup_form.dart';
import '../../../../../app/bloc/app_bloc.dart';
import '../../../../../app/di/init_dependencies.dart';
import '../../../../../shared/assets/images.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../../../../../shared/typography/app_text_styles.dart';
import '../../../../../shared/utils/snack_bars/custom_snack_bar.dart';
import '../../../../../shared/widgets/app_button.dart';
import '../../../cubit/auth_cubit.dart';
import '../../model/signup_model.dart';
import '../../viewmodel/signup_cubit/signup_cubit.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: serviceLocator<SignupCubit>(),
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
                  BlocConsumer<SignupCubit, SignupState>(
                    listener: (context, state) {
                      if (state.status == SignupSubmissionStatus.success) {
                        context
                            .read<AppBloc>()
                            .add(const DetermineAppStateRequested());
                      }
                      else if(state.status == SignupSubmissionStatus.error){
                        showCustomSnackBar(context, state.message,isError: true);
                      }
                    },
                    builder: (context, state) {
                      final isLoading =
                          state.status == SignupSubmissionStatus.loading;
                      return AppButton(
                        isInProgress: isLoading,
                        onPressed: () {
                          context.read<SignupCubit>().onSubmitted(
                                data: SignupModel(
                                  phone: state.phoneNumber.countryCode +
                                      state.phoneNumber.value,
                                  password: state.password.value,
                                  displayName: state.name.value,
                                  experienceYears: int.tryParse(
                                        state.yearsOfExperience.value,
                                      ) ??
                                      0,
                                  address: state.address.value,
                                  level: state.experienceLevel.value,
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
                                final cubit = context.read<AuthCubit>();
                                cubit.changeAuth(showLogin: true);
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
