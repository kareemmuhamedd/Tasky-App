import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/shared/assets/icons.dart';
import 'package:tasky_app/shared/typography/app_text_styles.dart';

import '../../../../shared/theme/app_colors.dart';
import '../widgets/custom_drop_down_menu.dart';
import '../widgets/custom_task_details_Screen_app_bar.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const TaskDetailsBody();
  }
}

class TaskDetailsBody extends StatelessWidget {
  const TaskDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: CustomTaskDetailsScreenAppBar(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 225.h,
                color: AppColors.lightOrangeColor,
                child: const Text('your image here'),
              ),
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Grocery Shopping App',
                      style: AppTextStyles.font24WeightBold,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      'here you can put your string and i will get this job i will fight i am playing valor and i am a pro player are you think that you are player than me lol i am a main cypher and please dont smoke on b site please clove i hate all smokers and the best smoker in the valor ant is the omen i have a good line ups with this agent man you cant',
                      style: AppTextStyles.font14WeightRegular.copyWith(
                        color: AppColors.blackColor.withOpacity(0.6),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomTileWidget(
                      prefix: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'End Date',
                            style: AppTextStyles.font9WeightRegular,
                          ),
                          Text(
                            '30 july 2021',
                            style: AppTextStyles.font14WeightRegular.copyWith(
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                      suffix: SvgPicture.asset(AppIcons.calendarIcon),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    CustomTileWidget(
                      prefix: Text(
                        'Inprogress',
                        style: AppTextStyles.font16WeightBold.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      suffix: Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: SvgPicture.asset(AppIcons.roundedDownArrowIcon),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    CustomTileWidget(
                      prefix: Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.flagIcon,
                            height: 24,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            'Medium Priority',
                            style: AppTextStyles.font16WeightBold.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          )
                        ],
                      ),
                      suffix: Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: SvgPicture.asset(AppIcons.roundedDownArrowIcon),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Center(
                      child: Container(
                        height: 326,
                        width: 326,
                        color: AppColors.whiteColor,
                        child: const Center(
                          child: Icon(Icons.qr_code_2_outlined, size: 300),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class CustomTileWidget extends StatelessWidget {
  const CustomTileWidget({
    super.key,
    required this.prefix,
    required this.suffix,
  });

  final Widget prefix;
  final Widget suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightPurpleColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 15,
          top: 7,
          bottom: 7,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            prefix,
            suffix,
          ],
        ),
      ),
    );
  }
}
