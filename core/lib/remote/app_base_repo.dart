part of '../core.dart';

bool noNeedToken(String path, List<String> list) {
  bool isNoNeedToken = false;

  for (var item in list) {
    if (path.contains(item)) {
      isNoNeedToken = true;
      break;
    }
  }

  return isNoNeedToken;
}

void logRequest(RequestOptions options) {
  if (!kDebugMode) return;
  Log.i('### Request Log ###');
  Log.i('URL: ${options.uri}');
  Log.i('Method: ${options.method}');
  Log.i('Headers: ${options.headers}');
  if (options.data is FormData) {
    final formData = options.data as FormData;
    Log.i('Request (FormData):');
    for (var field in formData.fields) {
      Log.i('  Field: ${field.key} = ${field.value}');
    }
    for (var file in formData.files) {
      Log.i('  File: ${file.key}, filename: ${file.value.filename}');
    }
  } else {
    try {
      final requestData = jsonEncode(options.data);
      Log.i(
        'Request: ${requestData.length > 1000 ? '${requestData.substring(0, 1000)}... [truncated]' : requestData}',
      );
    } catch (_) {
      Log.i('Request: ${options.data}');
    }
  }
  Log.i('### End Request Log ###');
}

void logResponse(Response response) {
  if (!kDebugMode) return;
  Log.i('### Response Log ###');
  Log.i('Status Code: ${response.statusCode}');
  Log.i('Status Message: ${response.statusMessage}');
  try {
    if (response.requestOptions.responseType == ResponseType.stream) {
      Log.i('Response: <event-stream>');
    } else {
      final responseData = jsonEncode(response.data);
      Log.i(
        'Response: ${responseData.length > 2000 ? '${responseData.substring(0, 2000)}... [truncated]' : responseData}',
      );
    }
  } catch (_) {
    Log.i('Response: ${response.data}');
  }
  Log.i('### End Response Log ###');
}

/// Shared Dio/transport base used by Retrofit and legacy repository methods.
///
/// The default hooks are suitable for public endpoints. Authenticated modules
/// override [whiteAuthList], [accessToken], and the interceptor hooks without
/// creating another Dio client.
class AppBaseRepo {
  @protected
  late final _DioHelper _helper = _DioHelper.getInstance(
    whiteAuthList: whiteAuthList,
    onRequest: onRequest,
    onResponse: onResponse,
    onError: onError,
    accessToken: accessToken,
  );

  @protected
  Dio get dio => _helper.dio;

  /// Public Dio handle for Retrofit factories.
  Dio get client => dio;

  Future<Response> get({
    required String path,
    data,
    Map<String, dynamic>? queries,
    Options? options,
  }) async {
    return _helper.get(
      path,
      data: data,
      queryParameters: queries,
      options: options,
    );
  }

  Future<Response> post({
    required String path,
    body,
    Map<String, dynamic>? queries,
    Options? options,
    ProgressCallback? onSendProgress,
  }) async {
    return _helper.post(
      path,
      body,
      queryParameters: queries,
      options: options,
      onSendProgress: _mergedSendProgress(onSendProgress),
    );
  }

  Future<Response> put({
    required String path,
    body,
    Map<String, dynamic>? queries,
    Options? options,
    ProgressCallback? onSendProgress,
  }) async {
    return _helper.put(
      path,
      body,
      queryParameters: queries,
      options: options,
      onSendProgress: _mergedSendProgress(onSendProgress),
    );
  }

  Future<Response> delete({
    required String path,
    data,
    Map<String, dynamic>? queries,
    Options? options,
  }) async {
    return _helper.delete(
      path,
      data: data,
      queryParameters: queries,
      options: options,
    );
  }

  Future<Response> patch({
    required String path,
    body,
    Map<String, dynamic>? queries,
    Options? options,
    ProgressCallback? onSendProgress,
  }) async {
    return _helper.patch(
      path,
      body,
      queryParameters: queries,
      options: options,
      onSendProgress: _mergedSendProgress(onSendProgress),
    );
  }

  ProgressCallback _mergedSendProgress(ProgressCallback? onSendProgress) {
    return (count, total) {
      WidgetUtils.onSendProgress(count, total);
      onSendProgress?.call(count, total);
    };
  }

  @protected
  List<String> get whiteAuthList => const [];

  @protected
  Future<String> get accessToken async => '';

  @protected
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(options);
  }

  @protected
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    return handler.next(response);
  }

  @protected
  void onError(DioException e, ErrorInterceptorHandler handler) {
    return handler.next(e);
  }
}

class _DioHelper {
  /// Handshake only. Request send/receive have no client limit — the server
  /// signals timeout with HTTP 408.
  static const int _connectTimeout = 60;

  final _dio = Dio(
    BaseOptions(
      baseUrl: Environments.getUrl(),
      connectTimeout: const Duration(seconds: _connectTimeout),
      receiveTimeout: null,
      sendTimeout: null,
    ),
  );
  final List<String> whiteAuthList;
  final void Function(RequestOptions, RequestInterceptorHandler)? onRequest;
  final void Function(Response<dynamic>, ResponseInterceptorHandler)?
  onResponse;
  final void Function(DioException, ErrorInterceptorHandler)? onError;
  final Future<String> accessToken;
  var options = Options(
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  );

  _DioHelper._({
    required this.whiteAuthList,
    required this.accessToken,
    this.onRequest,
    this.onResponse,
    this.onError,
  }) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers.putIfAbsent("Accept", () => "application/json");
          options.headers["Accept-Language"] =
              AppSP.get<String>(AppSP.languageLocale) ?? "vi";
          final token = await accessToken;

          if (!Utils.isNullOrEmpty(token) &&
              !noNeedToken(options.path, whiteAuthList)) {
            options.headers['Authorization'] = "Bearer $token";
          }

          if (options.data is FormData) {
            options.contentType = null;
          }

          logRequest(options);

          if (onRequest != null) {
            return onRequest!(options, handler);
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          logResponse(response);

          if (onResponse != null) {
            return onResponse!(response, handler);
          }

          return handler.next(response);
        },
        onError: (e, handler) async {
          if (e.response != null) {
            logResponse(e.response!);
          }

          if (onError != null) {
            return onError!(e, handler);
          }

          return handler.next(e);
        },
      ),
    );
  }

  factory _DioHelper.getInstance({
    required List<String> whiteAuthList,
    void Function(RequestOptions, RequestInterceptorHandler)? onRequest,
    void Function(Response<dynamic>, ResponseInterceptorHandler)? onResponse,
    void Function(DioException, ErrorInterceptorHandler)? onError,
    required Future<String> accessToken,
  }) => _DioHelper._(
    whiteAuthList: whiteAuthList,
    onRequest: onRequest,
    onResponse: onResponse,
    onError: onError,
    accessToken: accessToken,
  );

  Dio get dio => _dio;

  Future<Response> get(
    String path, {
    Object? data,
    Options? options,
    Map<String, dynamic>? queryParameters,
  }) async {
    final res = await _dio.get(
      path,
      options: options ?? this.options,
      data: data,
      queryParameters: queryParameters,
    );
    return res;
  }

  Future<Response> put(
    String path,
    Object? body, {
    Options? options,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
  }) async {
    final res = await _dio.put(
      path,
      data: body,
      options: options ?? this.options,
      queryParameters: queryParameters,
      onSendProgress: onSendProgress,
    );
    return res;
  }

  Future<Response> post(
    String path,
    Object? body, {
    Options? options,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
  }) async {
    final res = await _dio.post(
      path,
      data: body,
      options: options ?? this.options,
      queryParameters: queryParameters,
      onSendProgress: onSendProgress,
    );
    return res;
  }

  Future<Response> delete(
    String path, {
    Object? data,
    Options? options,
    Map<String, dynamic>? queryParameters,
  }) async {
    final res = await _dio.delete(
      path,
      data: data,
      options: options ?? this.options,
      queryParameters: queryParameters,
    );
    return res;
  }

  Future<Response> patch(
    String path,
    Object? body, {
    Options? options,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
  }) async {
    final res = await _dio.patch(
      path,
      data: body,
      options: options ?? this.options,
      queryParameters: queryParameters,
      onSendProgress: onSendProgress,
    );
    return res;
  }
}
