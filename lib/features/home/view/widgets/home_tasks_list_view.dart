import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/app/routes/app_routes.dart';
import 'package:tasky_app/shared/theme/app_colors.dart';

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
        if (state.status == HomeStatus.loading) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }
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
                child: SizedBox(
                  height: 96,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(64),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 219.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
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
                                          color:
                                              UiHelper.getTaskStatusTextColor(
                                            task.status,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: -1,
                                  right: -30,
                                  child: InkWell(
                                    onTap: () {
                                      // todo: show bottom sheet
                                    },
                                    child: SvgPicture.asset(
                                      AppIcons.verticalDotIcon,
                                    ),
                                  ),
                                )
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ],
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
