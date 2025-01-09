import 'package:bloc/bloc.dart';
import 'package:tasky_app/features/auth/signup/repositories/signup_remote_repository.dart';
import 'package:tasky_app/shared/utils/form_fields/address.dart';
import 'package:tasky_app/shared/utils/form_fields/formz_valid.dart';
import 'package:tasky_app/shared/utils/form_fields/level.dart';
import 'package:tasky_app/shared/utils/form_fields/name.dart';
import 'package:tasky_app/shared/utils/form_fields/password.dart';
import 'package:tasky_app/shared/utils/form_fields/phone_plus.dart';
import 'package:tasky_app/shared/utils/form_fields/years.dart';

import '../../../../../shared/utils/local_storage/shared_pref_service.dart';
import '../../model/signup_model.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({required SignupRemoteRepository signupRemoteRepository})
      : _signupRemoteRepository = signupRemoteRepository,
        super(const SignupState.initial());
  final SignupRemoteRepository _signupRemoteRepository;

  void changePasswordVisibility() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  void onNameChanged(String name) {
    final previousScreenState = state;
    final previousNameState = previousScreenState.name;
    final shouldValidate = previousNameState.invalid;
    final newNameState = shouldValidate
        ? Name.dirty(
            name,
          )
        : Name.pure(
            name,
          );
    final newScreenState = state.copyWith(
      name: newNameState,
    );
    emit(newScreenState);
  }

  void onPhoneNumberChanged(String phoneNumber, String countryCode) {
    final previousScreenState = state;
    final previousPhoneNumberState = previousScreenState.phoneNumber;
    final shouldValidate = previousPhoneNumberState.invalid;
    final newPhoneNumberState = shouldValidate
        ? Phone.dirty(countryCode, phoneNumber)
        : Phone.pure(countryCode, phoneNumber);

    final newScreenState = state.copyWith(
      phoneNumber: newPhoneNumberState,
    );

    emit(newScreenState);
  }

  void onPasswordChanged(String password) {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final shouldValidate = previousPasswordState.invalid;
    final newPasswordState = shouldValidate
        ? Password.dirty(
            password,
          )
        : Password.pure(
            password,
          );
    final newScreenState = state.copyWith(
      password: newPasswordState,
    );
    emit(newScreenState);
  }

  void onYearsOfExperienceChanged(String yearsOfExperience) {
    final previousScreenState = state;
    final previousYearsOfExperienceState =
        previousScreenState.yearsOfExperience;
    final shouldValidate = previousYearsOfExperienceState.invalid;
    final newYearsOfExperienceState = shouldValidate
        ? Years.dirty(
            yearsOfExperience,
          )
        : Years.pure(
            yearsOfExperience,
          );
    final newScreenState = state.copyWith(
      yearsOfExperience: newYearsOfExperienceState,
    );
    emit(newScreenState);
  }

  void onExperienceLevelChanged(String experienceLevel) {
    final previousScreenState = state;
    final previousExperienceLevelState = previousScreenState.experienceLevel;
    final shouldValidate = previousExperienceLevelState.invalid;
    final newExperienceLevelState = shouldValidate
        ? Level.dirty(
            experienceLevel,
          )
        : Level.pure(
            experienceLevel,
          );
    final newScreenState = state.copyWith(
      experienceLevel: newExperienceLevelState,
    );
    emit(newScreenState);
  }

  void onAddressChanged(String address) {
    final previousScreenState = state;
    final previousAddressState = previousScreenState.address;
    final shouldValidate = previousAddressState.invalid;
    final newAddressState = shouldValidate
        ? Address.dirty(
            address,
          )
        : Address.pure(
            address,
          );
    final newScreenState = state.copyWith(
      address: newAddressState,
    );
    emit(newScreenState);
  }

  void onSubmitted({required SignupModel data}) async {
    final name = Name.dirty(state.name.value);
    final phone = Phone.dirty(
      state.phoneNumber.countryCode,
      state.phoneNumber.value,
    );
    final password = Password.dirty(state.password.value);
    final years = Years.dirty(state.yearsOfExperience.value);
    final level = Level.dirty(state.experienceLevel.value);
    final address = Address.dirty(state.address.value);

    final isFormValid =
        FormzValid([name, phone, password, years, level, address]).isFormValid;
    final newState = state.copyWith(
      name: name,
      phoneNumber: phone,
      password: password,
      yearsOfExperience: years,
      experienceLevel: level,
      address: address,
      status: isFormValid ? SignupSubmissionStatus.loading : null,
    );
    emit(newState);
    if (!isFormValid) return;

    final res = await _signupRemoteRepository.signup(data: data);
    res.fold(
      (failure) {
        emit(state.copyWith(
          status: SignupSubmissionStatus.error,
          message: 'This phone number is already registered with another user',
        ));
        emit(state.copyWith(status: SignupSubmissionStatus.idle));
      },
      (response) async {
        await SharedPrefHelper.instance
            .setString('access_token', response.access_token);
        await SharedPrefHelper.instance
            .setString('refresh_token', response.refresh_token);
        emit(state.copyWith(
          status: SignupSubmissionStatus.success,
        ));
        emit(state.copyWith(status: SignupSubmissionStatus.idle));
      },
    );
  }
}
