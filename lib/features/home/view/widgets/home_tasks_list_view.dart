import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky_app/app/routes/app_routes.dart';
import 'package:tasky_app/shared/theme/app_colors.dart';
import '../../../../shared/utils/data/dummy_data.dart';
import '../../viewmodel/bloc/home_bloc.dart';
import 'home_list_item_card.dart';

class HomeTasksListView extends StatelessWidget {
  const HomeTasksListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.loading) {
          return SliverFillRemaining(
            child: Skeletonizer(
              effect:  const ShimmerEffect(
                baseColor: AppColors.lightPurpleColor,
                highlightColor: AppColors.lightGreyColor,
                duration: Duration(seconds: 1),
              ),
              child: ListView.builder(
                itemCount: 9,
                itemBuilder: (context, index) {
                  return HomeListItemCard(
                    task: dummyObject,
                    cardIndex: index,
                  );
                },
              ),
            ),
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
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: HomeListItemCard(
                    task: task,
                    cardIndex: index,
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
