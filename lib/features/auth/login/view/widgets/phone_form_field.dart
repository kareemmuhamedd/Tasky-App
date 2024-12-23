import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/theme/app_colors.dart';
import '../../../../../shared/typography/app_text_styles.dart';
import '../../../../../shared/widgets/custom_text_form_field.dart';
import '../../viewmodel/login_cubit/login_cubit.dart';

class PhoneFormField extends StatefulWidget {
  const PhoneFormField({super.key});

  @override
  State<PhoneFormField> createState() => _PhoneFormFieldState();
}

class _PhoneFormFieldState extends State<PhoneFormField> {
  Country? _selectedCountry;

  bool _isPhoneNumberValid = false;

  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
    _phoneNumberController.addListener(() {
      if (_phoneNumberController.text.isNotEmpty) {
        context.read<LoginCubit>().onPhoneNumberChanged(
              _selectedCountry!.dialCode + _phoneNumberController.text,
            );
      }
    });
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _validatePhoneNumber(String value, String countryCode) async {
    try {
      final isValid = await PhoneService.parsePhoneNumber(value, countryCode);
      _isPhoneNumberValid = isValid ?? false;
    } catch (e) {
      _isPhoneNumberValid = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      onChanged: (value) {
        if (_selectedCountry != null) {
          _validatePhoneNumber(value, _selectedCountry!.code);
        }
      },
      prefixIcon: CountryCodePicker(
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.textGreyColor2,
        ),
        onInit: (Country? country) {
          _selectedCountry = country;
        },
        onChanged: (Country? country) {
          _selectedCountry = country;
        },
        flagDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
        ),
        initialSelection: 'EG',
        padding: const EdgeInsets.only(left: 15, right: 0),
        insetPadding: EdgeInsets.zero,
        textStyle: AppTextStyles.font17WeightBold,
      ),
      controller: _phoneNumberController,
    );
  }
}
