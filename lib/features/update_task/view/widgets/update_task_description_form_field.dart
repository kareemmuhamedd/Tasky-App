import 'package:flutter/material.dart';

import '../../../../shared/widgets/custom_text_form_field.dart';

class UpdateTaskDescriptionFormField extends StatefulWidget {
  const UpdateTaskDescriptionFormField({
    super.key,
    required this.onChanged,
    required this.initialDescription,
  });

  final ValueChanged<String> onChanged;
  final String initialDescription;

  @override
  State<UpdateTaskDescriptionFormField> createState() =>
      _UpdateTaskDescriptionFormFieldState();
}

class _UpdateTaskDescriptionFormFieldState extends State<UpdateTaskDescriptionFormField> {
  late TextEditingController _taskDescriptionController;

  @override
  void initState() {
    _taskDescriptionController = TextEditingController(text: widget.initialDescription);
    super.initState();
  }

  @override
  void dispose() {
    _taskDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      onChanged: widget.onChanged,
      contentPadding: const EdgeInsets.only(left: 15, top: 25),
      hintText: 'Enter description here...',
      isMultiLine: true,
      controller: _taskDescriptionController,
    );
  }
}
