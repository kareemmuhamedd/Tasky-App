import 'package:flutter/material.dart';

import '../../../../shared/widgets/custom_text_form_field.dart';

class TaskTitleFormField extends StatelessWidget {
  const TaskTitleFormField({
    super.key,
    required this.onChanged,
  });

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      contentPadding: const EdgeInsets.only(left: 15),
      hintText: 'Enter title here...',
      onChanged: (value) => onChanged(value),
    );
  }
}
