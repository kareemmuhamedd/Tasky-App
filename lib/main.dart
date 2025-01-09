import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:tasky_app/shared/utils/local_storage/shared_pref_service.dart';
import 'app/di/init_dependencies.dart';
import 'app/view/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  await SharedPrefHelper.instance.init();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const App(),
    ),
  );
}
