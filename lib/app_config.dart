import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

class AppConfig {
  static initialize({bool isRelease = false}) async {
    //###Hide status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.grey[200],
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.black,
        statusBarColor: Colors.transparent));
    //###Initialize splash screen
    WidgetsFlutterBinding.ensureInitialized();
    // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    //###Initialize env
    await dotenv.load(fileName: isRelease ? ".env" : ".env.development");
    //Initialize local storage
    await GetStorage.init();

    //###Initialize Firebase
    // await Firebase.initializeApp();

    //###Start notification Service
    // NotificationService.instance.start();
  }

  // static Future<void> _firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {
  //   await Firebase.initializeApp();
  // }
}
