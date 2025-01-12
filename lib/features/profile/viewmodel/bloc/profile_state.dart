part of 'profile_bloc.dart';

enum ProfileStatus {
  initial,
  loading,
  success,
  failure,
  loggedOut
}

class ProfileState extends Equatable {
  const ProfileState._({
    required this.status,
    required this.message,
    this.user,
  });

  const ProfileState.initial()
      : this._(
          status: ProfileStatus.initial,
          message: '',
        );

  final ProfileStatus status;
  final String message;
  final UserModel? user;

  ProfileState copyWith({
    ProfileStatus? status,
    String? message,
    UserModel? user,
  }) {
    return ProfileState._(
      status: status ?? this.status,
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, message, user];
}
