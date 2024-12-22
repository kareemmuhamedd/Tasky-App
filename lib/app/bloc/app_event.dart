part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

final class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}

final class CheckOnboardingStatus extends AppEvent {
  const CheckOnboardingStatus();
}

final class CompleteOnboarding extends AppEvent {
  const CompleteOnboarding();
}
