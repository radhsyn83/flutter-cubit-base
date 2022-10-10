import 'package:cubit_core/app/presentation/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  //Initialize env
  await dotenv.load(fileName: ".env.development");
  runApp(MainApp(
    router: AppPages(),
  ));
}

class MainApp extends StatelessWidget {
  final AppPages router;

  const MainApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: router.generateRoute,
    );
  }
}
