import 'package:flutter/material.dart';

import '../../../../../shared/widgets/custom_text_form_field.dart';

class NameFormField extends StatelessWidget {
  const NameFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomTextFormField(
      contentPadding: EdgeInsets.only(left: 15),
      hintText: 'Name...',
    );
  }
}
