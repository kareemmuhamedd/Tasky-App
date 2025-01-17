import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/shared/theme/app_colors.dart';

/// The signature for the callback that uses the [BuildContext].
typedef BuildContextCallback = void Function(BuildContext context);

/// {@template show_dialog_extension}
/// Dialog extension that shows dialog with optional `title`,
/// `content` and `actions`.
/// you can also show a confirmation dialog with `confirmAction` method.
/// loadingDialog method shows a dialog with a loading indicator.
/// {@endtemplate}
extension DialogExtension on BuildContext {
  Future<void> loadingDialog() async {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primaryColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> confirmAction({
    required void Function() fn,
    required String title,
    required String noText,
    required String yesText,
    void Function()? cancel,
    String? content,
    TextStyle? yesTextStyle,
    TextStyle? noTextStyle,
    BuildContextCallback? noAction,
  }) async {
    final isConfirmed = await showConfirmationDialog(
      title: title,
      content: content,
      noText: noText,
      yesText: yesText,
      yesTextStyle: yesTextStyle,
      noTextStyle: noTextStyle,
      noAction: noAction,
    );
    if (isConfirmed == null || !isConfirmed) {
      cancel?.call();
      return;
    }
    fn.call();
  }

  /// Shows a dialog that alerts user that they are about to do destructive
  /// action.
  Future<bool?> showConfirmationDialog({
    required String title,
    required String noText,
    required String yesText,
    String? content,
    BuildContextCallback? noAction,
    BuildContextCallback? yesAction,
    TextStyle? noTextStyle,
    TextStyle? yesTextStyle,
    bool destructiveAction = true,
    bool barrierDismissible = true,
  }) =>
      showAdaptiveDialog<bool?>(
        title: title,
        content: content,
        barrierDismissible: barrierDismissible,
        actions: [
          TextButton(
            onPressed: () {
              if (noAction != null) {
                noAction.call(this);
              }
              pop(false);
            },
            child: Text(noText, style: noTextStyle),
          ),
          TextButton(
            onPressed: () {
              if (yesAction != null) {
                yesAction.call(this);
              }
              pop(true);
            },
            child: Text(yesText, style: yesTextStyle),
          ),
        ],
      );

  /// Shows adaptive dialog with provided `title`, `content` and `actions`
  /// (if provided). If `barrierDismissible` is `true` (default), dialog can't
  /// be dismissed by tapping outside of the dialog.
  Future<T?> showAdaptiveDialog<T>({
    String? content,
    String? title,
    List<Widget> actions = const [],
    bool barrierDismissible = true,
    Widget Function(BuildContext)? builder,
    TextStyle? titleTextStyle,
  }) =>
      showDialog<T>(
        context: this,
        barrierDismissible: barrierDismissible,
        builder: builder ??
            (context) {
              return AlertDialog.adaptive(
                actionsAlignment: MainAxisAlignment.end,
                title: Text(title ?? '', style: titleTextStyle),
                content: content == null ? null : Text(content),
                actions: actions,
              );
            },
      );
}
