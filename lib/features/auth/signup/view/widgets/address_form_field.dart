import 'package:flutter/material.dart';
import '../../../../../shared/widgets/custom_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewmodel/signup_cubit/signup_cubit.dart';

class AddressFromField extends StatefulWidget {
  const AddressFromField({super.key});

  @override
  State<AddressFromField> createState() => _AddressFromFieldState();
}

class _AddressFromFieldState extends State<AddressFromField> {
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
    _addressController.addListener(() {
      if (_addressController.text.isNotEmpty) {
        context.read<SignupCubit>().onAddressChanged(_addressController.text);
      }
    });
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addressError = context.select(
      (SignupCubit cubit) => cubit.state.address.errorMessage,
    );
    return CustomTextFormField(
      errorText: addressError,
      contentPadding: const EdgeInsets.only(left: 15),
      hintText: 'Address...',
      controller: _addressController,
    );
  }
}
