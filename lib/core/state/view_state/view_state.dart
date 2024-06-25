class ViewState<T> {
  ViewState._();

  factory ViewState.initial() = ViewStateInitial;
  factory ViewState.loading() = ViewStateLoading;
  factory ViewState.success({required T data}) = ViewStateSuccess<T>;
  factory ViewState.error({
    required String message,
  }) = ViewStateError<T>;

  R maybeWhen<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String message) error,
  }) {
    if (this is ViewStateInitial) {
      return initial();
    } else if (this is ViewStateLoading) {
        return loading();
    } else if (this is ViewStateSuccess<T>) {
      return success((this as ViewStateSuccess<T>).data);
    } else if (this is ViewStateError<T>) {
      final errorState = this as ViewStateError<T>;
      return error(errorState.message);
    } else {
      throw StateError("Unexpected state: $this");
    }
  }
}

class ViewStateInitial<T> extends ViewState<T> {
  ViewStateInitial() : super._();
}

class ViewStateLoading<T> extends ViewState<T> {
  ViewStateLoading() : super._();
}

class ViewStateSuccess<T> extends ViewState<T> {
  final T data;

  ViewStateSuccess({required this.data}) : super._();
}

class ViewStateError<T> extends ViewState<T> {
  final String message;

  ViewStateError({
    required this.message,
  }) : super._();
}