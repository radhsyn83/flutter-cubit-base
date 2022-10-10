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
      onViewReady: (cubit) => cubit.loadInitialData(),
      onLoading: const Center(child: CircularProgressIndicator()),
      onSuccess: (cubit, state) => _Body(
        cubit: cubit,
        state: state,
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final LoginCubit cubit;
  final DefaultState<LoginModel> state;
  const _Body({
    Key? key,
    required this.cubit,
    required this.state,
  }) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => widget.cubit.loadInitialData(),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(widget.state.data?.data?.token ?? "Refresh"),
            ),
          ),
        ],
      ),
    );
  }
}
