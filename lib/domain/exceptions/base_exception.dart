enum BaseExceptionType { unknown, error }

class BaseException<T> implements Exception {
  final T code;
  final bool success;
  final String message;
  final Exception? exception;

  const BaseException(
    String s, {
    required this.message,
    required this.success,
    required this.code,
    this.exception,
  });
}
