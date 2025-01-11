import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_app/shared/utils/data/tab_bar_data.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../viewmodel/bloc/home_bloc.dart';

class CustomHomeTabBar extends StatelessWidget {
  const CustomHomeTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return SizedBox(
          height: 42,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tabBarItems.length,
            itemBuilder: (context, index) {
              final isSelected = state.selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  final bloc = context.read<HomeBloc>();
                  bloc.add(HomeFilterChanged(index));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.lightPurpleColor,
                    borderRadius: BorderRadius.circular(42),
                  ),
                  child: Text(
                    tabBarItems[index],
                    style: isSelected
                        ? AppTextStyles.font16WeightBold
                        : AppTextStyles.font16WeightRegular.copyWith(
                            color: AppColors.textGreyColor3,
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
