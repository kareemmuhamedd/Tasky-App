import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/app/routes/app_routes.dart';
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

