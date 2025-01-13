import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:tasky_app/shared/utils/local_storage/shared_pref_service.dart';
import 'package:window_manager/window_manager.dart';
import 'app/di/init_dependencies.dart';
import 'app/view/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.instance.init();
  await initDependencies();
  // Initialize the window manager
  await windowManager.ensureInitialized();

  // WindowOptions windowOptions = const WindowOptions(
  //   size: Size(800, 600), // Set your desired fixed size
  //   center: true,         // Center the window on the screen
  //   backgroundColor: Colors.transparent,
  //   skipTaskbar: false,
  //   titleBarStyle: TitleBarStyle.normal,
  // );
  //
  // windowManager.waitUntilReadyToShow(windowOptions, () async {
  //   await windowManager.setResizable(false); // Make the window non-resizable
  //   await windowManager.setFullScreen(true); // Set the window to fullscreen
  //   await windowManager.show();
  //   await windowManager.focus();
  // });
  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600), // Initial window size
    minimumSize: Size(800, 600), // Fixed minimum size
    center: true, // Center the window
    backgroundColor: Colors.transparent,
    titleBarStyle: TitleBarStyle.normal, // Use default system title bar with buttons
  );

  // Wait until the window is ready to show
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setResizable(false);
    await windowManager.show(); // Show the window
    await windowManager.focus(); // Focus the window
  });
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const App(),
    ),
  );
}
