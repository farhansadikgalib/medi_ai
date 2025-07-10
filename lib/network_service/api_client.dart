import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getX;

import '../core/config/app_config.dart';
import '../core/connection_manager/connection_manager_controller.dart';
import '../core/helper/app_helper.dart';
import '../core/helper/app_widgets.dart';
import '../core/helper/print_log.dart';
import '../core/helper/shared_value_helper.dart';

class ApiClient {
  static ApiClient? _instance;
  static Dio? _dio;

  final _connectionController =
      getX.Get.find<ConnectionManagerController>().obs;

  factory ApiClient({String customBaseUrl = ''}) {
    _instance ??= ApiClient._internal(customBaseUrl: customBaseUrl);
    return _instance!;
  }

  ApiClient._internal({String customBaseUrl = ''}) {
    _initializeDio(customBaseUrl);
  }

  void _initializeDio(String customBaseUrl) {
    final options = BaseOptions(
      baseUrl: customBaseUrl.isNotEmpty ? customBaseUrl : AppConfig.basePath,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'isApp': true,
      },
    );

    _dio = Dio(options);
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio!.interceptors.clear();

    // Logging interceptor (only in debug mode)
    if (kDebugMode) {
      _dio!.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
          logPrint: (log) => printLog(log.toString()),
        ),
      );
    }

    // Custom interceptor for error handling
    _dio!.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) {
          // Add auth token if available
          final token = accessToken.$;
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          options.headers['language_code'] = 'en';

          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) async {
          await _handleError(error);
          return handler.next(error);
        },
      ),
    );
  }

  Future<void> _handleError(DioException error) async {
    final statusCode = error.response?.statusCode;
    String message = _extractErrorMessage(error);

    switch (statusCode) {
      case 400:
        _showErrorSnackBar('Bad Request', message);
        break;
      case 401:
        _showErrorSnackBar('Unauthorized', 'Please login again');
        await AppHelper().logout();
        break;
      case 403:
        _showErrorSnackBar('Forbidden', 'Access denied');
        break;
      case 404:
        _showErrorSnackBar('Not Found', 'Resource not found');
        break;
      case 408:
        _showErrorSnackBar('Timeout', 'Request timeout. Please try again');
        break;
      case 409:
        _showErrorSnackBar('Conflict', message);
        break;
      case 422:
        _showErrorSnackBar('Validation Error', message);
        break;
      case 429:
        _showErrorSnackBar(
          'Too Many Requests',
          'Please wait before trying again',
        );
        break;
      case 500:
        _showErrorSnackBar('Server Error', 'Internal server error occurred');
        break;
      case 502:
        _showErrorSnackBar('Bad Gateway', 'Service temporarily unavailable');
        break;
      case 503:
        _showErrorSnackBar(
          'Service Unavailable',
          'Service temporarily unavailable',
        );
        break;
      case 504:
        _showErrorSnackBar(
          'Gateway Timeout',
          'Request timeout. Please try again',
        );
        break;
      default:
        if (error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.receiveTimeout ||
            error.type == DioExceptionType.sendTimeout) {
          _showErrorSnackBar(
            'Timeout',
            'Connection timeout. Please check your internet',
          );
        } else if (error.type == DioExceptionType.connectionError) {
          _showErrorSnackBar(
            'Connection Error',
            'Please check your internet connection',
          );
        } else {
          _showErrorSnackBar(
            'Error',
            message.isNotEmpty ? message : 'An unexpected error occurred',
          );
        }
    }
  }

  String _extractErrorMessage(DioException error) {
    try {
      final responseData = error.response?.data;
      if (responseData != null) {
        Map<String, dynamic> data;

        if (responseData is String) {
          data = jsonDecode(responseData);
        } else if (responseData is Map<String, dynamic>) {
          data = responseData;
        } else {
          return error.message ?? 'Unknown error occurred';
        }

        // Try different message fields
        final messageFields = ['message', 'error', 'detail', 'errors'];
        for (final field in messageFields) {
          if (data.containsKey(field)) {
            final fieldValue = data[field];
            if (fieldValue is List && fieldValue.isNotEmpty) {
              return fieldValue.first.toString();
            } else if (fieldValue is String && fieldValue.isNotEmpty) {
              return fieldValue;
            }
          }
        }
      }
    } catch (e) {
      printLog('Error extracting message: $e');
    }
    return error.message ?? 'Unknown error occurred';
  }

  void _showErrorSnackBar(String title, String message) {
    AppWidgets().getSnackBar(title: title, message: message);
  }

  bool get _isConnected =>
      _connectionController.value.isInternetConnected.isTrue;

  Future<Response<T>?> _executeRequest<T>(
    Future<Response<T>> Function() request, {
    bool showLoader = false,
    bool requiresAuth = false,
  }) async {
    if (!_isConnected) {
      _showErrorSnackBar(
        'No Internet',
        'Please check your internet connection',
      );
      return null;
    }

    if (showLoader) {
      AppHelper().showLoader();
    }

    try {
      final response = await request();
      return response;
    } on DioException catch (e) {
      printLog('API Error: ${e.toString()}');
      return e.response as Response<T>?;
    } finally {
      if (showLoader) {
        await AppHelper().hideLoader();
      }
    }
  }

  Future<Response?> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool showLoader = false,
    bool requiresAuth = false,
  }) async {
    return await _executeRequest(
      () async {
        final options = Options(headers: headers);
        return await _dio!.get(
          endpoint,
          queryParameters: queryParameters,
          options: options,
        );
      },
      showLoader: showLoader,
      requiresAuth: requiresAuth,
    );
  }

  Future<Response?> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool showLoader = false,
    bool requiresAuth = false,
    bool isFormData = false,
    bool isFileUpload = false,
  }) async {
    return await _executeRequest(
      () async {
        dynamic requestData = data;

        if (isFormData && data != null) {
          if (data is Map<String, dynamic>) {
            requestData = FormData.fromMap(data);
          } else if (data is FormData) {
            requestData = data;
          }
        }

        final options = Options(
          headers: headers,
          contentType: isFormData ? 'multipart/form-data' : 'application/json',
        );

        return await _dio!.post(
          endpoint,
          data: requestData,
          queryParameters: queryParameters,
          options: options,
        );
      },
      showLoader: showLoader,
      requiresAuth: requiresAuth,
    );
  }

  Future<Response?> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool showLoader = false,
    bool requiresAuth = false,
  }) async {
    return await _executeRequest(
      () async {
        final options = Options(headers: headers);
        return await _dio!.put(
          endpoint,
          data: data,
          queryParameters: queryParameters,
          options: options,
        );
      },
      showLoader: showLoader,
      requiresAuth: requiresAuth,
    );
  }

  Future<Response?> patch(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool showLoader = false,
    bool requiresAuth = false,
  }) async {
    return await _executeRequest(
      () async {
        final options = Options(headers: headers);
        return await _dio!.patch(
          endpoint,
          data: data,
          queryParameters: queryParameters,
          options: options,
        );
      },
      showLoader: showLoader,
      requiresAuth: requiresAuth,
    );
  }

  Future<Response?> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool showLoader = false,
    bool requiresAuth = false,
  }) async {
    return await _executeRequest(
      () async {
        final options = Options(headers: headers);
        return await _dio!.delete(
          endpoint,
          data: data,
          queryParameters: queryParameters,
          options: options,
        );
      },
      showLoader: showLoader,
      requiresAuth: requiresAuth,
    );
  }

  Future<Response?> upload(
    String endpoint,
    List<File> files, {
    Map<String, dynamic>? fields,
    String fileFieldName = 'files',
    bool showLoader = true,
    ProgressCallback? onSendProgress,
  }) async {
    if (!_isConnected) {
      _showErrorSnackBar(
        'No Internet',
        'Please check your internet connection',
      );
      return null;
    }

    final formData = FormData();

    // Add files
    for (final file in files) {
      formData.files.add(
        MapEntry(fileFieldName, await MultipartFile.fromFile(file.path)),
      );
    }

    // Add additional fields
    if (fields != null) {
      fields.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });
    }

    return await _executeRequest(
      () async => await _dio!.post(
        endpoint,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
        onSendProgress: onSendProgress,
      ),
      showLoader: showLoader,
      requiresAuth: true,
    );
  }

  Future<Response?> download(
    String url,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    bool showLoader = true,
  }) async {
    return await _executeRequest(
      () async => await _dio!.download(
        url,
        savePath,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      ),
      showLoader: showLoader,
    );
  }

  void updateBaseUrl(String newBaseUrl) {
    _dio!.options.baseUrl = newBaseUrl;
  }

  void updateTimeout({
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) {
    if (connectTimeout != null) _dio!.options.connectTimeout = connectTimeout;
    if (receiveTimeout != null) _dio!.options.receiveTimeout = receiveTimeout;
    if (sendTimeout != null) _dio!.options.sendTimeout = sendTimeout;
  }

  void clearCache() {
    _dio!.interceptors.clear();
    _setupInterceptors();
  }

  void dispose() {
    _dio?.close();
    _instance = null;
  }
}
