part of '../core.dart';

/// Shared result helpers for legacy [Result] values and `Either` data flows.
final class ResultUtils {
  const ResultUtils._();

  /// Executes a remote request and converts every failure to [Failure].
  ///
  /// Remote data sources should use this helper instead of repeating the same
  /// Dio and unexpected-error handling in every method.
  static AsyncEither<T> guardRemote<T>(Future<T> Function() request) async {
    try {
      return right(await request());
    } on Object catch (error) {
      return left(failureFrom(error));
    }
  }

  /// Converts a transport or unexpected exception into the shared failure
  /// type used by repositories and use cases.
  static Failure failureFrom(Object error) {
    if (error is DioException) {
      final message = Result.messageFromDio(error) ?? error.message;
      final normalizedMessage = message?.trim();
      return Failure(
        normalizedMessage == null || normalizedMessage.isEmpty
            ? null
            : normalizedMessage,
        cause: error,
      );
    }

    return Failure(null, cause: error);
  }
}

class Result<T> {
  final T? data;
  final String? error;
  final dynamic errorObject;

  Result({this.data, this.error, this.errorObject});

  Result.success(this.data) : error = null, errorObject = null;

  /// Always stores a non-null [error] so [isError] is true for failure results.
  Result.error(String? message, this.errorObject)
    : data = null,
      error = _normalizeErrorMessage(message);

  bool get isSuccess => error == null;

  bool get isError => error != null;

  /// Non-empty server/user-facing message, or null when absent.
  String? get errorMessage {
    final value = error?.trim();
    if (value == null || value.isEmpty || value.toLowerCase() == 'null') {
      return null;
    }
    return value;
  }

  static String _normalizeErrorMessage(String? message) {
    if (message == null) return '';
    final trimmed = message.trim();
    if (trimmed.isEmpty || trimmed.toLowerCase() == 'null') return '';
    return trimmed;
  }

  /// Reads API error text from Dio response body.
  /// Supports `message` as String/List and fallback `error` field.
  static String? messageFromDio(DioException e) {
    final data = e.response?.data;

    if (data is String) {
      final normalized = _normalizeErrorMessage(data);
      return normalized.isEmpty ? null : normalized;
    }

    if (data is Map) {
      final message = data['message'];
      if (message is String) {
        final normalized = _normalizeErrorMessage(message);
        if (normalized.isNotEmpty) return normalized;
      } else if (message is List && message.isNotEmpty) {
        final joined = message
            .map((item) => item?.toString().trim() ?? '')
            .where((item) => item.isNotEmpty && item.toLowerCase() != 'null')
            .join(', ');
        if (joined.isNotEmpty) return joined;
      }

      final errorField = data['error'];
      if (errorField is String) {
        final normalized = _normalizeErrorMessage(errorField);
        if (normalized.isNotEmpty) return normalized;
      }
    }

    return null;
  }

  static Result<T> guard<T>(T Function() f) {
    try {
      return Result.success(f());
    } catch (e) {
      return Result.error(e.toString(), null);
    }
  }

  static Future<Result<T>> guardAsync<T>(Future<T> Function() f) async {
    try {
      final data = await f();
      return Result.success(data);
    } catch (e) {
      if (e is DioException) {
        final message = messageFromDio(e);
        return Result.error(
          message ?? e.message ?? e.toString(),
          e.response?.data,
        );
      }

      return Result.error(e.toString(), null);
    }
  }

  Future<void> ifSuccess(Function(T? data) f) async {
    await maybeWhen(
      success: (data) async {
        f(data);
      },
    );
  }

  Future<void> ifError(Function(String? error, dynamic errorData) f) async {
    await maybeWhen(
      error: (error, errorData) async {
        f(error, errorData);
      },
    );
  }

  Future<dynamic>? maybeWhen({
    Future Function(T? data)? success,
    Future Function(String? errorMsg, dynamic errorData)? error,
    Null Function()? orElse,
  }) {
    if (isSuccess) {
      return success?.call(data);
    } else if (isError) {
      return error?.call(this.error, errorObject);
    } else {
      return orElse?.call();
    }
  }

  void fold({
    required Future Function(T? data) success,
    required Future Function(String? errorMsg, dynamic errorData) error,
  }) {
    if (isSuccess) {
      success(data);
      return;
    }

    error(this.error, errorObject);
  }
}
