class DefaultState<T> extends CubitState {
  final T? data;

  DefaultState({required bool isLoading, String? error, this.data})
      : super(isLoading, error);

  DefaultState<T> copyWith({bool? isLoading, String? error, T? data}) {
    return DefaultState(
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
