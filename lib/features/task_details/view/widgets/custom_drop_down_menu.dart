import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/app/routes/app_routes.dart';
import '../../../../shared/assets/icons.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../../create_task/model/task_model.dart';

class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  final GlobalKey _iconKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  void _showDropdown(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: _removeDropdown,
            behavior: HitTestBehavior.translucent,
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Positioned(
            top: screenHeight - (screenHeight - 80),
            right: screenWidth - (screenWidth - 10),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 82.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blackColor.withOpacity(0.19),
                          blurRadius: 16,
                          spreadRadius: 0,
                          offset: const Offset(1, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _removeDropdown();
                            context.pushNamed(
                              AppRoutesPaths.kUpdateTaskScreen,
                              extra: widget.task,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Edit',
                              style: AppTextStyles.font16WeightRegular
                                  .copyWith(color: AppColors.blackColor),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(
                            height: 1,
                            color: AppColors.borderGreyColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _removeDropdown();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Delete',
                              style: AppTextStyles.font16WeightRegular
                                  .copyWith(color: AppColors.orangeColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  top: -(13 / 2),
                  child: Transform.rotate(
                    angle: 3.14 / 4,
                    child: Container(
                      width: 13.w,
                      height: 13.h,
                      decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _iconKey,
      onTap: () => _showDropdown(context),
      child: SvgPicture.asset(
        AppIcons.verticalDotIcon,
      ),
    );
  }
}
