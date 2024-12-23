import 'package:bloc/bloc.dart';
import 'package:tasky_app/features/auth/signup/repositories/signup_remote_repository.dart';

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
    emit(state.copyWith(name: name));
  }

  void onPhoneChanged(String phone) {
    emit(state.copyWith(phoneNumber: phone));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void onYearsOfExperienceChanged(String yearsOfExperience) {
    emit(state.copyWith(yearsOfExperience: yearsOfExperience));
  }

  void onExperienceLevelChanged(String experienceLevel) {
    emit(state.copyWith(experienceLevel: experienceLevel));
  }

  void onAddressChanged(String address) {
    emit(state.copyWith(address: address));
  }

  void onSubmitted({required SignupModel data}) async {
    emit(state.copyWith(status: SignupSubmissionStatus.loading));
    final res = await _signupRemoteRepository.signup(data: data);
    res.fold(
      (failure) {
        emit(state.copyWith(
          status: SignupSubmissionStatus.error,
          message: failure.message,
        ));
      },
      (response) async {
        await SharedPrefHelper.instance
            .setString('access_token', response.access_token);
        await SharedPrefHelper.instance
            .setString('refresh_token', response.refresh_token);
        emit(state.copyWith(
          status: SignupSubmissionStatus.success,
        ));
      },
    );
  }
}
