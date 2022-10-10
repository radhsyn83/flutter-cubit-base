import 'package:cubit_core/app/cubit/default_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<DefaultState> {
  // TODO your global parameter here

  var title = "Akira";

  MainCubit() : super(DefaultState(isLoading: true)) {
    onInit();
  }

  void onInit() {
    // TODO your code here
  }
}
