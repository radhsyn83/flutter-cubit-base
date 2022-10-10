import 'package:cubit_core/app/cubit/default_state.dart';
import 'package:cubit_core/app/data/models/login_model.dart';
import 'package:cubit_core/app/presentation/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:cubit_core/app/presentation/screens/login/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginCubit, DefaultState<LoginModel>>(
      cubit: LoginCubit(),
      initState: (cubit) => cubit.loadInitialData(),
      onLoading: const Center(child: CircularProgressIndicator()),
      onSuccess: body,
    );
  }

  Widget body(LoginCubit cubit, DefaultState<LoginModel> state) {
    return Center(
      child: GestureDetector(
        onTap: () => cubit.loadInitialData(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(state.data?.data?.token ?? "Refresh"),
        ),
      ),
    );
  }
}
