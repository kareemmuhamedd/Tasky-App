import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/utils/local_storage/shared_pref_service.dart';
import '../bloc/app_bloc.dart';
import 'app_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final isOnboardingCompleted =
        SharedPrefHelper.instance.getBool('onboarding_completed') ?? false;
    final accessToken = SharedPrefHelper.instance.getString('access_token');
    final refreshToken = SharedPrefHelper.instance.getString('refresh_token');

    final AppState initialState;
    if (!isOnboardingCompleted) {
      initialState = const AppState.onboardingRequired();
    } else if (accessToken != null && refreshToken != null) {
      initialState = const AppState.authenticated();
    } else {
      initialState = const AppState.unauthenticated();
    }

    return BlocProvider(
      create: (context) {
        final appBloc = AppBloc(initialState: initialState);
        appBloc.initialize();
        return appBloc;
      },
      child: const AppView(),
    );
  }
}
