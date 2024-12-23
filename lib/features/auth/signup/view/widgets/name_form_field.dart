import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_app/features/auth/signup/viewmodel/signup_cubit/signup_cubit.dart';

import '../../../../../shared/widgets/custom_text_form_field.dart';

class NameFormField extends StatefulWidget {
  const NameFormField({super.key});

  @override
  State<NameFormField> createState() => _NameFormFieldState();
}

class _NameFormFieldState extends State<NameFormField> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _nameController.addListener(() {
      if (_nameController.text.isNotEmpty) {
        context.read<SignupCubit>().onNameChanged(_nameController.text);
      }
    });

  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: _nameController,
      contentPadding: const EdgeInsets.only(left: 15),
      hintText: 'Name...',
    );
  }
}
