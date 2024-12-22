part of 'app_bloc.dart';

/// The status of the application. Used to determine which page to show when
/// the application is started.

enum AppStatus {
  /// The user is authenticated. Show `MainPage`.
  authenticated,

  /// The user is not authenticated or the authentication status is unknown.
  /// Show `AuthPage`.
  unauthenticated,

  /// The authentication status is unknown. Show `SplashPage`.
  onboardingRequired,
}

class AppState extends Equatable {
  const AppState({
    required this.status,
    //this.user = User.anonymous,
  });

  // const AppState.authenticated(User user)
  //     : this(status: AppStatus.authenticated, user: user);

  const AppState.onboardingRequired()
      : this(status: AppStatus.onboardingRequired);

  // const AppState.unauthenticated()
  //     : this(
  //         status: AppStatus.unauthenticated,
  //         user: User.anonymous,
  //       );

  final AppStatus status;

  //final User user;

  AppState copyWith({
    // User? user,
    AppStatus? status,
  }) {
    return AppState(
      // user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        status,
        //user,
      ];
}
