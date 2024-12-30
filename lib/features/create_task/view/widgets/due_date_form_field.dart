import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky_app/shared/assets/icons.dart';
import 'package:tasky_app/shared/widgets/custom_text_form_field.dart';

class DueDateFormField extends StatelessWidget {
  const DueDateFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      contentPadding: const EdgeInsets.only(left: 15),
      hintText: 'Choose due date...',
      readOnly: true,
      onTap: () {
        // todo: implement the date picker functionality
      },
      suffixIcon: SizedBox(
        width: 24,
        height: 24,
        child: Center(
          child: SvgPicture.asset(
            AppIcons.calendarIcon,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
