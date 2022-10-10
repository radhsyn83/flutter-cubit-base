import 'package:cubit_core/app/presentation/routes/app_routes.dart';
import 'package:cubit_core/app/presentation/screens/login/login_cubit.dart';
import 'package:cubit_core/app/presentation/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppPages {
  // AppPages() {}

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.INITIAL:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => LoginCubit(),
            child: const LoginScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
