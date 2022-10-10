import 'package:cubit_core/app/cubit/default_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<DefaultState> {
  // TODO your global parameter here

  MainCubit() : super(const DefaultState(isLoading: true)) {
    onInit();
  }

  void onInit() {
    // TODO your code here
  }
}
