import 'package:flutter/material.dart';

import '../../../../shared/widgets/custom_text_form_field.dart';

class UpdateTaskTitleFormField extends StatefulWidget {
  const UpdateTaskTitleFormField({
    super.key,
    required this.onChanged,
    required this.initialTitle, // Add this parameter to pass the initial title
  });

  final ValueChanged<String> onChanged;
  final String initialTitle; // Add this property to hold the initial title

  @override
  State<UpdateTaskTitleFormField> createState() =>
      _UpdateTaskTitleFormFieldState();
}

class _UpdateTaskTitleFormFieldState extends State<UpdateTaskTitleFormField> {
  late TextEditingController _taskTitleController;

  @override
  void initState() {
    _taskTitleController = TextEditingController(text: widget.initialTitle);
    super.initState();
  }

  @override
  void dispose() {
    _taskTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      contentPadding: const EdgeInsets.only(left: 15),
      hintText: 'Enter title here...',
      onChanged: (value) => widget.onChanged(value),
      controller: _taskTitleController,
    );
  }
}
