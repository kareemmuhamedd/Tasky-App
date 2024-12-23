import 'package:bloc/bloc.dart';
import 'package:tasky_app/features/auth/login/model/login_model.dart';
import 'package:tasky_app/features/auth/login/repositories/login_remote_repository.dart';

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
    emit(state.copyWith(password: password));
  }

  void onPhoneNumberChanged(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void onSubmitted({required LoginModel data}) async {
    emit(state.copyWith(status: LogInSubmissionStatus.loading));
    final res = await _loginRemoteRepository.login(data: data);
    res.fold(
      (failure) {
        emit(state.copyWith(
          status: LogInSubmissionStatus.error,
          message: failure.message,
        ));
      },
      (response) async {
        await SharedPrefHelper.instance
            .setString('access_token', response.access_token);
        await SharedPrefHelper.instance
            .setString('refresh_token', response.refresh_token);
        emit(state.copyWith(
          status: LogInSubmissionStatus.success,
        ));
      },
    );
  }
}
