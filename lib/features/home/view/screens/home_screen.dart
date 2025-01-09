import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/app/routes/app_routes.dart';
import 'package:tasky_app/shared/theme/app_colors.dart';
import 'package:tasky_app/shared/typography/app_text_styles.dart';
import '../../../../app/di/init_dependencies.dart';
import '../../viewmodel/bloc/home_bloc.dart';
import '../widgets/custom_home_tab_bar.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_tasks_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: serviceLocator<HomeBloc>()
        ..add(
          const AllTasksRequested(),
        ),
      child: const HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: HomeAppBar(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Tasks',
                    style: AppTextStyles.font16WeightBold
                        .copyWith(color: AppColors.blackColor.withOpacity(0.6)),
                  ),
                  const SizedBox(height: 16),
                  const CustomHomeTabBar(),
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),
            const HomeTasksListView(),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'qr_code_button',
            backgroundColor: AppColors.lightPurpleColor2,
            shape: const CircleBorder(),
            elevation: 0,
            mini: true,
            onPressed: () {
              context.pushNamed(AppRoutesPaths.kScanQRCodeScreen);
            },
            child: const Icon(
              Icons.qr_code,
              color: AppColors.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'add_task_button',
            backgroundColor: AppColors.primaryColor,
            shape: const CircleBorder(),
            onPressed: () {
              context.pushNamed(AppRoutesPaths.kCreateTaskScreen);
            },
            child: const Icon(
              Icons.add,
              color: AppColors.whiteColor,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
