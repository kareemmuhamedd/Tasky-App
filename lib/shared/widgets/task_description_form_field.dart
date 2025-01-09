import 'package:flutter/material.dart';

import 'custom_text_form_field.dart';

class TaskDescriptionFormField extends StatelessWidget {
  const TaskDescriptionFormField({
    super.key,
    required this.onChanged,
  });

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      onChanged: onChanged,
      contentPadding: const EdgeInsets.only(left: 15, top: 25),
      hintText: 'Enter description here...',
      isMultiLine: true,
    );
  }
}
