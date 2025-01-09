import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart' show FormzInput;

import 'formz_validation_mixin.dart';

/// {@template Address}
/// Form input for a Address. It extends [FormzInput] and uses
/// [AddressValidationError] for its validation errors.
/// {@endtemplate}
class Address extends FormzInput<String, AddressValidationError>
    with EquatableMixin, FormzValidationMixin {
  /// {@macro Address.pure}
  const Address.pure([super.value = '']) : super.pure();

  /// {@macro Address.dirty}
  const Address.dirty([super.value = '']) : super.dirty();

  @override
  AddressValidationError? validator(String value) {
    if (value.isEmpty) {
      return AddressValidationError.empty;
    } else if (value.length < 10 || value.length > 200) {
      return AddressValidationError.invalid;
    } else {
      return null;
    }
  }

  @override
  Map<AddressValidationError?, String?> get validationErrorMessage => {
    AddressValidationError.empty: 'This field is required',
    AddressValidationError.invalid: value.length > 200
        ? 'Address should contain at most 200 characters'
        : 'Address should contain at least 10 characters',
    null: null,
  };

  @override
  List<Object?> get props => [value, pure];
}

/// Validation errors for [Address]. It can be empty or invalid.
enum AddressValidationError {
  /// Empty Address.
  empty,

  /// Invalid Address.
  invalid,
}
