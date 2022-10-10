import 'package:cubit_core/app/cubit/main_cubit.dart';
import 'package:cubit_core/app/presentation/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  final AppPages router;

  final bool isRelease;
  const App({Key? key, this.isRelease = false, required this.router})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        onGenerateRoute: router.generateRoute,
      ),
    );
  }
}
