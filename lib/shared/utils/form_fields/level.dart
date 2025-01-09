import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart' show FormzInput;

import '../data/expreience_level.dart';
import 'formz_validation_mixin.dart';

/// {@template Level}
/// Form input for a Level. It extends [FormzInput] and uses
/// [LevelValidationError] for its validation errors.
/// {@endtemplate}
class Level extends FormzInput<String, LevelValidationError>
    with EquatableMixin, FormzValidationMixin {
  /// {@macro Level.pure}
  const Level.pure([super.value = '']) : super.pure();

  /// {@macro Level.dirty}
  const Level.dirty([super.value = '']) : super.dirty();

  @override
  LevelValidationError? validator(String value) {
    if (value.isEmpty) {
      return LevelValidationError.empty;
    } else if (!experienceLevels.contains(value)) {
      return LevelValidationError.invalid;
    } else {
      return null;
    }
  }

  @override
  Map<LevelValidationError?, String?> get validationErrorMessage => {
        LevelValidationError.empty: 'This field is required',
        LevelValidationError.invalid: 'Please enter a valid level',
        null: null,
      };

  @override
  List<Object?> get props => [value, pure];
}

/// Validation errors for [Level]. It can be empty or invalid.
enum LevelValidationError {
  /// Empty Level.
  empty,

  /// Invalid Level.
  invalid,
}
