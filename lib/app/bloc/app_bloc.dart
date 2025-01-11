import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../shared/utils/local_storage/shared_pref_service.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AppState initialState}) : super(initialState) {
    on<DetermineAppStateRequested>(_onDetermineAppStateRequested);
    on<CompleteOnboarding>(_onCompleteOnboarding);
    on<AppRedirectAfterLoggedOut>(_onAppRedirectAfterLoggedOut);

    add(const DetermineAppStateRequested());
  }

  Future<void> initialize() async {
    add(const DetermineAppStateRequested());
  }

  /// Handles the [DetermineAppStateRequested] event.
  Future<void> _onDetermineAppStateRequested(
    DetermineAppStateRequested event,
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

  /// Handles the [AppRedirectAfterLoggedOut] event.
  void _onAppRedirectAfterLoggedOut(
    AppRedirectAfterLoggedOut event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(status: AppStatus.unauthenticated));
  }
}
