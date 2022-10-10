import 'package:cubit_core/app/data/models/login_model.dart';

class LoginState extends CubitState {
  final LoginModel? data;

  LoginState({required bool isLoading, String? error, this.data})
      : super(isLoading, error);

  LoginState copyWith({bool? isLoading, String? error, LoginModel? data}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

abstract class CubitState {
  final bool isLoading;
  final String? error;

  CubitState(this.isLoading, this.error);
}
