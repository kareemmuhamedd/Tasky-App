import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky_app/features/profile/repositories/profile_remote_repository.dart';

import '../../models/user.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required ProfileRemoteRepository profileRemoteRepository})
      : _profileRemoteDataSource = profileRemoteRepository,
        super(const ProfileState.initial()) {
    on<ProfileDataRequested>(_onProfileDataRequested);
  }

  final ProfileRemoteRepository _profileRemoteDataSource;

  void _onProfileDataRequested(
    ProfileDataRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _profileRemoteDataSource.getUserProfile();
    result.fold(
      (failure) {
        emit(state.copyWith(
          status: ProfileStatus.failure,
          message: failure.message,
        ));
      },
      (user) {
        emit(state.copyWith(
          status: ProfileStatus.success,
          user: user,
        ));
      },
    );
  }
}
