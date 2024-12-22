import 'package:flutter/material.dart';
import 'package:tasky_app/shared/utils/local_storage/shared_pref_service.dart';
import 'app/view/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.instance.init();
  runApp(const App());
}