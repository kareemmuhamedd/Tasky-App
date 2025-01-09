import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/app/routes/app_routes.dart';
import 'package:tasky_app/shared/theme/app_colors.dart';
import 'package:tasky_app/shared/widgets/custom_app_bottom_sheet.dart';

import '../../../../shared/assets/icons.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../../../shared/utils/ui_helper/ui_helper.dart';
import '../../viewmodel/bloc/home_bloc.dart';

class HomeTasksListView extends StatelessWidget {
  const HomeTasksListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        // if (state.status == HomeStatus.loading) {
        //   return const SliverFillRemaining(
        //     child: Center(child: CircularProgressIndicator()),
        //   );
        // }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: state.tasks.length,
            (context, index) {
              final task = state.tasks[index];
              return GestureDetector(
                onTap: () {
                  context.pushNamed(
                    AppRoutesPaths.kTaskDetailsScreen,
                    extra: task,
                  );
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 96,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 64,
                          width: 64,
                          decoration: BoxDecoration(
                            color: AppColors.lightOrangeColor,
                            borderRadius: BorderRadius.circular(64),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(64),
                            child: CachedNetworkImage(
                              imageUrl: task.image,
                              errorWidget: (context, url, error) => const Icon(
                                Icons.warning_rounded,
                                color: AppColors.borderGreyColor,
                                size: 30,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 200.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      task.title,
                                      style: AppTextStyles.font16WeightBold
                                          .copyWith(
                                        color: AppColors.blackColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: UiHelper.getTaskStatusBGColor(
                                        task.status,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      task.status,
                                      style: AppTextStyles.font12WeightMedium
                                          .copyWith(
                                        color: UiHelper.getTaskStatusTextColor(
                                          task.status,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                task.desc,
                                style: AppTextStyles.font14WeightRegular,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppIcons.flagIcon,
                                        colorFilter: ColorFilter.mode(
                                          UiHelper.getTaskPriorityColor(
                                            task.priority,
                                          ),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        task.priority,
                                        style: AppTextStyles.font12WeightMedium
                                            .copyWith(
                                          color: UiHelper.getTaskPriorityColor(
                                            task.priority,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    task.getFormattedCreatedAt(),
                                    style: AppTextStyles.font12WeightRegular
                                        .copyWith(
                                      color:
                                          AppColors.blackColor.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 17),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 9),
                            child: GestureDetector(
                              onTap: () {
                                showCustomModalBottomSheet(
                                    context: context,
                                    options: [
                                      'Edit',
                                      'Delete',
                                    ],
                                    onOptionSelected: (selected) {
                                      if (selected == 'Edit') {
                                        context.pushNamed(
                                          AppRoutesPaths.kUpdateTaskScreen,
                                          extra: task,
                                        );
                                      } else {
                                        // todo Handle delete action
                                      }
                                    });
                              },
                              child: SvgPicture.asset(AppIcons.verticalDotIcon),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
