import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/features/auth/login/view/screens/login_screen.dart';
import 'package:tasky_app/features/auth/signup/view/screens/signup_screen.dart';
import 'package:tasky_app/features/create_task/view/screens/create_task_screen.dart';
import 'package:tasky_app/features/home/view/screens/home_screen.dart';
import 'package:tasky_app/features/onboarding/onboarding_screen.dart';
import 'package:tasky_app/features/splash/view/splash_screen.dart';

import '../../features/task_details/view/screens/task_details_screen.dart';
import '../bloc/app_bloc.dart';

abstract class AppRoutesPaths {
  static const String kOnboarding = '/onboarding-screen';
  static const String kLoginScreen = '/login-screen';
  static const String kSignupScreen = '/signup-screen';
  static const String kHomeScreen = '/home-screen';
  static const String kSplashScreen = '/splash-screen';
  static const String kTaskDetailsScreen = '/task-details-screen';
  static const String kCreateTaskScreen = '/create-task-screen';
}

class AppRoutes {
  static GoRouter router(AppBloc appBloc) {
    final notifier = GoRouterNotifier(appBloc);

    return GoRouter(
      initialLocation: AppRoutesPaths.kHomeScreen,
      routes: [
        // Splash Route
        GoRoute(
          path: AppRoutesPaths.kSplashScreen,
          name: AppRoutesPaths.kSplashScreen,
          builder: (context, state) => const SplashScreen(),
        ),
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
        // Home Route
        GoRoute(
          path: AppRoutesPaths.kHomeScreen,
          name: AppRoutesPaths.kHomeScreen,
          builder: (context, state) => const CreateTaskScreen(),
        ),
        // Task Details Route
        GoRoute(
          path: AppRoutesPaths.kTaskDetailsScreen,
          name: AppRoutesPaths.kTaskDetailsScreen,
          builder: (context, state) => const TaskDetailsScreen(),
        ),
        // Create Task Route
        GoRoute(
          path: AppRoutesPaths.kCreateTaskScreen,
          name: AppRoutesPaths.kCreateTaskScreen,
          builder: (context, state) => const CreateTaskScreen(),
        ),
      ],
      redirect: (context, state) {
        final appStatus = appBloc.state.status;

        // Wait for initialization to complete
        if (appStatus == AppStatus.initial) {
          return AppRoutesPaths.kSplashScreen;
        }

        if (appStatus == AppStatus.authenticated) {
          return AppRoutesPaths.kHomeScreen;
        }

        if (appStatus == AppStatus.unauthenticated &&
            state.uri.toString() != AppRoutesPaths.kLoginScreen) {
          return AppRoutesPaths.kLoginScreen;
        }

        if (appStatus == AppStatus.onboardingRequired &&
            state.uri.toString() != AppRoutesPaths.kOnboarding) {
          return AppRoutesPaths.kOnboarding;
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
    appBloc.stream.listen((state) {
      notifyListeners();
    });
  }
}
