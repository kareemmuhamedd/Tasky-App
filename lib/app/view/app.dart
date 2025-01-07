import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/utils/local_storage/shared_pref_service.dart';
import '../bloc/app_bloc.dart';
import 'app_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    bool isAnonymous() {
      final accessToken = SharedPrefHelper.instance.getString('access_token');
      final refreshToken = SharedPrefHelper.instance.getString('refresh_token');
      if (accessToken == null || refreshToken == null) {
        return true;
      }
      return false;
    }

    return BlocProvider(
      create: (context) {
        final appBloc = AppBloc(isAnonymous: isAnonymous());
        appBloc.initialize();
        return appBloc;
      },
      child: const AppView(),
    );
  }
}
