part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class ProfileDataRequested extends ProfileEvent {
  const ProfileDataRequested();
}

final class LogoutRequested extends ProfileEvent {
  final String? refreshToken;

  const LogoutRequested(this.refreshToken);
}
