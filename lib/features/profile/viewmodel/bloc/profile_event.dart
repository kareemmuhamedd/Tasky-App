part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class ProfileDataRequested extends ProfileEvent {
  const ProfileDataRequested();
}
