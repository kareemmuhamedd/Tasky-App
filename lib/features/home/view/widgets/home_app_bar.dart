import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/app/bloc/app_bloc.dart';
import 'package:tasky_app/app/routes/app_routes.dart';
import 'package:tasky_app/shared/assets/icons.dart';
import 'package:tasky_app/shared/theme/app_colors.dart';
import 'package:tasky_app/shared/typography/app_text_styles.dart';
import 'package:tasky_app/shared/utils/extensions/show_dialog_extension.dart';
import 'package:tasky_app/shared/utils/local_storage/shared_pref_service.dart';
import 'package:tasky_app/shared/widgets/custom_app_bottom_sheet.dart';

import '../../../profile/viewmodel/bloc/profile_bloc.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(left: 22.w),
        child: const Text(
          'Logo',
          style: AppTextStyles.font24WeightBold,
        ),
      ),
      titleSpacing: 0,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 22.w),
          child: SizedBox(
            width: 68.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pushNamed(AppRoutesPaths.kProfileScreen);
                  },
                  child: SvgPicture.asset(AppIcons.circleUserIcon),
                ),
                BlocListener<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state.status == ProfileStatus.loading) {
                      context.loadingDialog();
                    } else if (state.status == ProfileStatus.loggedOut) {
                      Navigator.of(context, rootNavigator: true).pop();
                      context
                          .read<AppBloc>()
                          .add(const AppRedirectAfterLoggedOut());
                      context
                          .read<AppBloc>()
                          .add(const DetermineAppStateRequested());
                    }
                  },
                  child: GestureDetector(
                    onTap: () {
                      showCustomModalBottomSheet(
                        context: context,
                        textColor: AppColors.errorRedColor,
                        options: ['Logout'],
                        onOptionSelected: (selected) {
                          if (selected == 'Logout') {
                            final refreshToken = SharedPrefHelper.instance
                                .getString('refresh_token');
                            context
                                .read<ProfileBloc>()
                                .add(LogoutRequested(refreshToken));
                          }
                        },
                      );
                    },
                    child: SvgPicture.asset(AppIcons.logoutIcon),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
