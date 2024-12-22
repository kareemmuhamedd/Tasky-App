import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_bloc.dart';
import 'app_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final appBloc = AppBloc();
        appBloc.add(const CheckOnboardingStatus());
        return appBloc;
      },
      child: const AppView(),
    );
  }
}

