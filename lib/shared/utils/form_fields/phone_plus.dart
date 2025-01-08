import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart' show FormzInput;

import '../data/countries.dart';
import 'formz_validation_mixin.dart';

/// {@template phone_number}
/// Form input for a phone number. It extends [FormzInput] and uses
/// [PhoneNumberValidationError] for its validation errors.
/// {@endtemplate}
class Phone extends FormzInput<String, PhoneNumberValidationError>
    with EquatableMixin, FormzValidationMixin {
  /// Country code used for validation (e.g., "US", "EG").
  final String countryCode;

  /// {@macro phone_number.pure}
  const Phone.pure([this.countryCode = 'EG', super.value = '']) : super.pure();

  /// {@macro phone_number.dirty}
  const Phone.dirty([this.countryCode = 'EG', super.value = ''])
      : super.dirty();

  @override
  PhoneNumberValidationError? validator(String value) {
    if (value.isEmpty) {
      return PhoneNumberValidationError.empty;
    }

    // Find the matching country by dial code
    final country = countries.firstWhere(
      (c) => c.dialCode == countryCode.replaceFirst('+', ''),
      orElse: () => const Country(
        name: '',
        flag: '',
        code: '',
        dialCode: '',
        nameTranslations: {},
        minLength: 0,
        maxLength: 0,
      ),
    );

    if (country.dialCode.isEmpty) {
      return PhoneNumberValidationError.unsupportedCountry;
    }

    // Check for invalid characters (only digits allowed)
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return PhoneNumberValidationError.invalidCharacters;
    }

    // Validate the length of the phone number
    if (value.length < country.minLength || value.length > country.maxLength) {
      return PhoneNumberValidationError.invalidLength;
    }

    return null;
  }

  @override
  Map<PhoneNumberValidationError?, String?> get validationErrorMessage => {
        PhoneNumberValidationError.empty: 'This field is requiredkk',
        PhoneNumberValidationError.unsupportedCountry:
            'Country code is not supported',
        PhoneNumberValidationError.invalidLength:
            'Invalid phone number length for the selected country',
        PhoneNumberValidationError.invalidCharacters:
            'Phone number contains invalid characters',
        null: null,
      };

  @override
  List<Object?> get props => [
        value,
        pure,
        // countryCode,
      ];
}

/// Validation errors for [Phone].
enum PhoneNumberValidationError {
  /// Empty phone number.
  empty,

  /// Unsupported country code.
  unsupportedCountry,

  /// Invalid phone number length.
  invalidLength,

  /// Invalid characters in phone number.
  invalidCharacters,
}
