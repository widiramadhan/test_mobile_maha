class DataState<T> {
  DataState._();

  factory DataState.success({required T data}) = DataStateSuccess<T>;

  factory DataState.error({
    required String message,
    int? code,
    Exception? exception,
    StackTrace? stackTrace,
  }) = DataStateError<T>;

  R when<R>({
    required R Function(T data) success,
    required R Function(String message, int? code, Exception? exception, StackTrace? stackTrace) error,
  }) {
    if (this is DataStateSuccess<T>) {
      return success((this as DataStateSuccess<T>).data);
    } else if (this is DataStateError<T>) {
      final errorState = this as DataStateError<T>;
      return error(errorState.message, errorState.code, errorState.exception, errorState.stackTrace);
    } else {
      throw StateError("Unexpected state: $this");
    }
  }
}

class DataStateSuccess<T> extends DataState<T> {
  final T data;

  DataStateSuccess({required this.data}) : super._();
}

class DataStateError<T> extends DataState<T> {
  final String message;
  final int? code;
  final Exception? exception;
  final StackTrace? stackTrace;

  DataStateError({
    required this.message,
    this.code,
    this.exception,
    this.stackTrace,
  }) : super._();
}