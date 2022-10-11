import 'package:cubit_core/app/cubit/default_state.dart';
import 'package:cubit_core/app/data/models/login_model.dart';
import 'package:cubit_core/app/presentation/screens/base_screen_v2.dart';
import 'package:cubit_core/app/presentation/screens/login/login_cubit.dart';
import 'package:flutter/material.dart';

// class Example extends BaseScreen<LoginCubit, DefaultState<LoginModel>> {
//   Example({super.key});

//   final controller = LoginCubit();

//   @override
//   LoginCubit get cubit => controller;

//   @override
//   AppBar? get appBar => AppBar(
//         title: const Text("Example"),
//       );

//   @override
//   void onInit() {
//     super.onInit();
//     cubit.loadInitialData();
//   }

//   @override
//   Widget onLoading(BuildContext context, DefaultState<LoginModel> state) {
//     return super.onLoading(context, state);
//   }

//   @override
//   Widget body(BuildContext context, DefaultState<LoginModel> state) {
//     return super.body(context, state);
//   }

//   @override
//   void onClose() {
//     super.onClose();
//     print("close");
//   }
// }

class Example
    extends BaseScreenLifecycle<LoginCubit, DefaultState<LoginModel>> {
  Example({super.key});

  final controller = LoginCubit();

  @override
  LoginCubit get cubit => controller;

  @override
  AppBar? get appBar => AppBar(
        title: const Text("Example"),
      );

  @override
  void onInit() {
    super.onInit();
    cubit.loadInitialData();
  }
}
