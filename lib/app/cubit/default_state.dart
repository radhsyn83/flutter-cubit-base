import 'package:equatable/equatable.dart';

class DefaultState<T> extends CubitState {
  final T? data;

  const DefaultState({required bool isLoading, String? error, this.data})
      : super(isLoading, error);

  DefaultState<T> copyWith({bool? isLoading, String? error, T? data}) {
    return DefaultState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, data];
}

abstract class CubitState extends Equatable {
  final bool isLoading;
  final String? error;

  const CubitState(this.isLoading, this.error);
}
