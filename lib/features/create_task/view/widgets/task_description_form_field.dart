import 'package:flutter/material.dart';

import '../../../../shared/widgets/custom_text_form_field.dart';

class TaskDescriptionFormField extends StatelessWidget {
  const TaskDescriptionFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomTextFormField(
      contentPadding: EdgeInsets.only(left: 15, top: 25),
      hintText: 'Enter description here...',
      isMultiLine: true,
    );
  }
}
