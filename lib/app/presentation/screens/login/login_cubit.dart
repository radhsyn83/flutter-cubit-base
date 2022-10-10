import 'package:cubit_core/app/cubit/default_state.dart';
import 'package:cubit_core/app/data/models/login_model.dart';
import 'package:cubit_core/app/data/repositories/member_repository.dart';
import 'package:cubit_core/app/utils/error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<DefaultState<LoginModel>> {
  LoginCubit() : super(DefaultState<LoginModel>(isLoading: true));

  Future<void> loadInitialData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final payload = {
        "username": "082272605775",
        "password": "sense324",
      };
      await MemberRepository.login(payload).then((res) {
        emit(state.copyWith(data: res));
      }).catchError((err) {
        throw Exception(parseError(err));
      });
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
    emit(state.copyWith(isLoading: false));
  }
}

String parseError(err) {
  if (err is ErrorModel) {
    return err.msg.toString();
  } else {
    return err.toString();
  }
}
