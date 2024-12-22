import 'package:bloc/bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(const SignupState.initial());

  void changePasswordVisibility() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }
}
