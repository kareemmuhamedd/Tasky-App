import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky_app/app/bloc/app_bloc.dart';
import 'package:tasky_app/shared/assets/icons.dart';
import 'package:tasky_app/shared/assets/images.dart';
import 'package:tasky_app/shared/widgets/app_button.dart';

import '../../shared/typography/app_text_styles.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(AppImages.artImage),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Task Management &\nTo-Do List',
            style: AppTextStyles.font24WeightBold,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'This productive tool is designed to help\nyou better manage your task\nproject-wise conveniently!',
            style: AppTextStyles.font14WeightRegular,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 35.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: AppButton(
              appButtonWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Let\'s Start',
                    style: AppTextStyles.font19WeightBold,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SvgPicture.asset(AppIcons.arrowLeftIcon),
                ],
              ),
              onPressed: () {
                context.read<AppBloc>().add(const CompleteOnboarding());
              },
            ),
          )
        ],
      ),
    );
  }
}
