part of 'signup_cubit.dart';

/// [SignupState] submission status, indicating current state of user Signup
/// process.
enum SignupSubmissionStatus {
  /// [SignupSubmissionStatus.idle] indicates that user has not yet submitted
  /// Signup form.
  idle,

  /// [SignupSubmissionStatus.loading] indicates that user has submitted
  /// Signup form and is currently waiting for response from backend.
  loading,

  /// [SignupSubmissionStatus.success] indicates that user has successfully
  /// submitted Signup form and is currently waiting for response from backend.
  success,

  /// [SignUpSubmissionStatus.emailAlreadyRegistered] indicates that email,
  /// provided by user, is occupied by another one in database.
  emailAlreadyRegistered,

  /// [SignupSubmissionStatus.userNotFound] indicates that user with provided
  /// credentials was not found in database.
  userNotFound,

  /// [SignupSubmissionStatus.error] indicates that something unexpected happen.
  error;
}

/// {@template Signup_state}
/// [SignupState] holds all the information related to user Signup process.
/// It is used to determine current state of user Signup process.
/// {@endtemplate}
class SignupState {
  /// {@macro Signup_state}
  const SignupState._({
    required this.status,
    required this.message,
    required this.showPassword,
    required this.phoneNumber,
    required this.password,
    required this.name,
    required this.yearsOfExperience,
    required this.experienceLevel,
    required this.address,
  });

  /// Initial Signup state.
  const SignupState.initial()
      : this._(
          status: SignupSubmissionStatus.idle,
          message: '',
          showPassword: false,
          phoneNumber: '',
          password: '',
          name: '',
          yearsOfExperience: '',
          experienceLevel: '',
          address: '',
        );

  final SignupSubmissionStatus status;
  final String name;
  final String phoneNumber;
  final String yearsOfExperience;
  final String experienceLevel;
  final String address;
  final String password;
  final bool showPassword;
  final String message;

  SignupState copyWith({
    SignupSubmissionStatus? status,
    String? message,
    bool? showPassword,
    String? phoneNumber,
    String? password,
    String? name,
    String? yearsOfExperience,
    String? experienceLevel,
    String? address,
  }) {
    return SignupState._(
      status: status ?? this.status,
      message: message ?? this.message,
      showPassword: showPassword ?? this.showPassword,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      name: name ?? this.name,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      address: address ?? this.address,
    );
  }
}
