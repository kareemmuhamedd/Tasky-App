import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/features/create_task/view/screens/create_task_screen.dart';
import 'package:tasky_app/features/home/view/screens/home_screen.dart';
import 'package:tasky_app/features/onboarding/onboarding_screen.dart';
import 'package:tasky_app/features/splash/view/splash_screen.dart';

import '../../features/auth/view/auth_screen.dart';
import '../../features/task_details/view/screens/task_details_screen.dart';
import '../bloc/app_bloc.dart';

abstract class AppRoutesPaths {
  static const String kOnboarding = '/onboarding-screen';
  static const String kAuthScreen = '/auth-screen';
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
        // Auth Route
        GoRoute(
          path: AppRoutesPaths.kAuthScreen,
          name: AppRoutesPaths.kAuthScreen,
          builder: (context, state) => const AuthScreen(),
        ),
        // Home Route
        GoRoute(
          path: AppRoutesPaths.kHomeScreen,
          name: AppRoutesPaths.kHomeScreen,
          builder: (context, state) => const HomeScreen(),
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
        final authenticated = appStatus == AppStatus.authenticated;
        final authenticating =
            state.matchedLocation == AppRoutesPaths.kAuthScreen;
        final isInHome = state.matchedLocation == AppRoutesPaths.kHomeScreen;
        if (isInHome && !authenticated) return AppRoutesPaths.kAuthScreen;
        if (!authenticated) return AppRoutesPaths.kAuthScreen;
        if (authenticated && authenticating) return AppRoutesPaths.kHomeScreen;
        return null;
        //Wait for initialization to complete
        if (appStatus == AppStatus.initial) {
          return AppRoutesPaths.kSplashScreen;
        }

        if (appStatus == AppStatus.authenticated) {
          return AppRoutesPaths.kHomeScreen;
        }

        if (appStatus == AppStatus.unauthenticated &&
            state.uri.toString() != AppRoutesPaths.kAuthScreen) {
          return AppRoutesPaths.kAuthScreen;
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
  late final StreamSubscription<AppState> _subscription;

  GoRouterNotifier(this.appBloc) {
    _subscription = appBloc.stream.listen((state) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
