import 'package:bloc/bloc.dart';
import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:tasky_app/features/auth/login/model/login_model.dart';
import 'package:tasky_app/features/auth/login/repositories/login_remote_repository.dart';
import 'package:tasky_app/shared/utils/form_fields/formz_valid.dart';
import 'package:tasky_app/shared/utils/form_fields/password.dart';
import 'package:tasky_app/shared/utils/form_fields/phone_plus.dart';

import '../../../../../shared/utils/local_storage/shared_pref_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required LoginRemoteRepository loginRemoteRepository})
      : _loginRemoteRepository = loginRemoteRepository,
        super(const LoginState.initial());
  final LoginRemoteRepository _loginRemoteRepository;

  void changePasswordVisibility() {
    emit(state.copyWith(showPassword: !state.showPassword));
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

  void onSubmitted({required LoginModel data}) async {
    final password = Password.dirty(state.password.value);
    final phoneNumber = Phone.dirty(
      state.phoneNumber.countryCode,
      state.phoneNumber.value,
    );
    final isFormValid = FormzValid([password, phoneNumber]).isFormValid;
    final newState = state.copyWith(
      password: password,
      phoneNumber: phoneNumber,
      status: isFormValid ? LogInSubmissionStatus.loading : null,
    );
    emit(newState);
    if (!isFormValid) return;
    final res = await _loginRemoteRepository.login(data: data);
    res.fold(
      (failure) {
        emit(state.copyWith(
          status: LogInSubmissionStatus.error,
          message: failure.message,
        ));
        emit(state.copyWith(status: LogInSubmissionStatus.idle));
      },
      (response) async {
        await SharedPrefHelper.instance
            .setString('access_token', response.access_token);
        await SharedPrefHelper.instance
            .setString('refresh_token', response.refresh_token);

        emit(state.copyWith(
          status: LogInSubmissionStatus.success,
        ));
        emit(state.copyWith(status: LogInSubmissionStatus.idle));
      },
    );
  }
}
