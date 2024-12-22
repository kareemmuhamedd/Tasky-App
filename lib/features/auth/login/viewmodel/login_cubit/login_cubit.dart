import 'package:bloc/bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState.initial());

  void changePasswordVisibility() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }
}
