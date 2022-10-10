import 'package:cubit_core/app/presentation/routes/app_pages.dart';
import 'package:cubit_core/app_config.dart';
import 'package:flutter/material.dart';

import 'app.dart';

Future<void> main() async {
  //router
  final router = AppPages();
  //initialize
  await AppConfig.initialize();
  //Show Main Page
  runApp(App(router: router));
  // Remove the splash screen
  // Future.delayed(
  //     const Duration(seconds: 2), (() => FlutterNativeSplash.remove()));
}
