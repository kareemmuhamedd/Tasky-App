import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../shared/utils/local_storage/shared_pref_service.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState.initial()) {
    on<CheckOnboardingStatus>(_onCheckOnboardingStatus);
    on<CompleteOnboarding>(_onCompleteOnboarding);
    on<AppLogoutRequested>(_onLogoutRequested);

    // Trigger the initial state resolution
    add(const CheckOnboardingStatus());
  }
  Future<void> initialize() async {
    add(const CheckOnboardingStatus());
  }

  /// Handles the [CheckOnboardingStatus] event.
  Future<void> _onCheckOnboardingStatus(
      CheckOnboardingStatus event,
      Emitter<AppState> emit,
      ) async {
    final accessToken = SharedPrefHelper.instance.getString('access_token');
    final refreshToken = SharedPrefHelper.instance.getString('refresh_token');

    if (accessToken != null && refreshToken != null) {
      emit(state.copyWith(status: AppStatus.authenticated));
    } else {
      final isOnboardingCompleted =
          SharedPrefHelper.instance.getBool('onboarding_completed') ?? false;

      if (isOnboardingCompleted) {
        emit(state.copyWith(status: AppStatus.unauthenticated));
      } else {
        emit(state.copyWith(status: AppStatus.onboardingRequired));
      }
    }
  }


  /// Handles the [CompleteOnboarding] event.
  Future<void> _onCompleteOnboarding(
    CompleteOnboarding event,
    Emitter<AppState> emit,
  ) async {
    await SharedPrefHelper.instance.setBool('onboarding_completed', true);
    emit(state.copyWith(status: AppStatus.unauthenticated));
  }

  /// Handles the [AppLogoutRequested] event.
  void _onLogoutRequested(
    AppLogoutRequested event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(status: AppStatus.unauthenticated));
  }
}
