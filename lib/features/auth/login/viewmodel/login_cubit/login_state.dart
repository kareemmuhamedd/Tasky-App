part of 'login_cubit.dart';

/// [LoginState] submission status, indicating current state of user login
/// process.
enum LogInSubmissionStatus {
  /// [LogInSubmissionStatus.idle] indicates that user has not yet submitted
  /// login form.
  idle,

  /// [LogInSubmissionStatus.loading] indicates that user has submitted
  /// login form and is currently waiting for response from backend.
  loading,

  /// [LogInSubmissionStatus.success] indicates that user has successfully
  /// submitted login form and is currently waiting for response from backend.
  success,

  /// [LogInSubmissionStatus.invalidCredentials] indicates that user has
  /// submitted login form with invalid credentials.
  invalidCredentials,

  /// [LogInSubmissionStatus.userNotFound] indicates that user with provided
  /// credentials was not found in database.
  userNotFound,

  /// [LogInSubmissionStatus.error] indicates that something unexpected happen.
  error;
}

/// {@template login_state}
/// [LoginState] holds all the information related to user login process.
/// It is used to determine current state of user login process.
/// {@endtemplate}
class LoginState {
  /// {@macro login_state}
  const LoginState._({
    required this.status,
    required this.message,
    required this.showPassword,
    required this.phoneNumber,
    required this.password,
  });

  /// Initial login state.
  const LoginState.initial()
      : this._(
          status: LogInSubmissionStatus.idle,
          message: '',
          showPassword: false,
          phoneNumber: const Phone.pure(),
          password: const Password.pure(),
        );

  final LogInSubmissionStatus status;
  final Phone phoneNumber;
  final Password password;
  final bool showPassword;
  final String message;

  LoginState copyWith({
    LogInSubmissionStatus? status,
    String? message,
    bool? showPassword,
    Phone? phoneNumber,
    Password? password,
  }) {
    return LoginState._(
      status: status ?? this.status,
      message: message ?? this.message,
      showPassword: showPassword ?? this.showPassword,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }
}
