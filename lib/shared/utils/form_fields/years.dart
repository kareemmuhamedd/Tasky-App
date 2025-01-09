import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart' show FormzInput;

import 'formz_validation_mixin.dart';

/// {@template Years}
/// Form input for a Years. It extends [FormzInput] and uses
/// [YearsValidationError] for its validation errors.
/// {@endtemplate}
class Years extends FormzInput<String, YearsValidationError>
    with EquatableMixin, FormzValidationMixin {
  /// {@macro Years.pure}
  const Years.pure([super.value = '']) : super.pure();

  /// {@macro Years.dirty}
  const Years.dirty([super.value = '']) : super.dirty();

  @override
  YearsValidationError? validator(String value) {
    final years = int.tryParse(value);
    if (value.isEmpty) {
      return YearsValidationError.empty;
    } else if (years == null) {
      return YearsValidationError.empty;
    }
    else if (years < 0 || years > 100) {
      return YearsValidationError.invalid;
    } else {
      return null;
    }
  }

  @override
  Map<YearsValidationError?, String?> get validationErrorMessage => {
        YearsValidationError.empty: 'This field is required',
        YearsValidationError.invalid: 'Please enter a valid number of years',
        null: null,
      };

  @override
  List<Object?> get props => [value, pure];
}

/// Validation errors for [Years]. It can be empty or invalid.
enum YearsValidationError {
  /// Empty Years.
  empty,

  /// Invalid Years.
  invalid,
}
