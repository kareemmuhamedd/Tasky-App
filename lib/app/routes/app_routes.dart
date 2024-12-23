import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/features/auth/login/view/screens/login_screen.dart';
import 'package:tasky_app/features/auth/signup/view/screens/signup_screen.dart';
import 'package:tasky_app/features/home/view/screens/home_screen.dart';
import 'package:tasky_app/features/onboarding/onboarding_screen.dart';

import '../bloc/app_bloc.dart';

abstract class AppRoutesPaths {
  static const String kOnboarding = '/onboarding-screen';
  static const String kLoginScreen = '/login-screen';
  static const String kSignupScreen = '/signup-screen';
  static const String kHomeScreen = '/home-screen';
}

class AppRoutes {
  static GoRouter router(AppBloc appBloc) {
    final notifier = GoRouterNotifier(appBloc);

    return GoRouter(
      initialLocation: AppRoutesPaths.kOnboarding,
      routes: [
        // Onboarding Route
        GoRoute(
          path: AppRoutesPaths.kOnboarding,
          name: AppRoutesPaths.kOnboarding,
          builder: (context, state) => const OnboardingScreen(),
        ),
        // Login Route
        GoRoute(
          path: AppRoutesPaths.kLoginScreen,
          name: AppRoutesPaths.kLoginScreen,
          builder: (context, state) => const LoginScreen(),
        ),
        // Signup Route
        GoRoute(
          path: AppRoutesPaths.kSignupScreen,
          name: AppRoutesPaths.kSignupScreen,
          builder: (context, state) => const SignupScreen(),
        ),
        GoRoute(
          path: AppRoutesPaths.kHomeScreen,
          name: AppRoutesPaths.kHomeScreen,
          builder: (context, state) => const HomeScreen(),
        ),
      ],
      redirect: (context, state) {
        final appStatus = appBloc.state.status;

        if (appStatus == AppStatus.authenticated) {
          return AppRoutesPaths.kHomeScreen;
        }

        final isLoginScreen =
            state.uri.toString() == AppRoutesPaths.kLoginScreen;
        final isSignupScreen =
            state.uri.toString() == AppRoutesPaths.kSignupScreen;

        if (appStatus == AppStatus.unauthenticated &&
            !isLoginScreen &&
            !isSignupScreen) {
          return AppRoutesPaths.kLoginScreen;
        }
        return null;
      },
      refreshListenable: notifier,
    );
  }
}

class GoRouterNotifier extends ChangeNotifier {
  final AppBloc appBloc;

  GoRouterNotifier(this.appBloc) {
    appBloc.stream.listen((_) => notifyListeners());
  }
}
