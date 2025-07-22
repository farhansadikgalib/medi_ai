/*
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getX;
import '../core/config/app_config.dart';
import '../core/connection_manager/connection_manager_controller.dart';
import '../core/helper/app_helper.dart';
import '../core/helper/app_widgets.dart';
import '../core/helper/auth_helper.dart';
import '../core/helper/print_log.dart';
import '../core/helper/shared_value_helper.dart';

class ApiClient {
  final Dio _dio;
  final _connectionController = getX.Get.find<ConnectionManagerController>();
  final String _accessToken = accessToken.$;

  ApiClient({String customBaseUrl = ''})
      : _dio = Dio(
          BaseOptions(
            baseUrl: customBaseUrl.isNotEmpty ? customBaseUrl : AppConfig.basePath,
            connectTimeout: const Duration(seconds: 100),
            receiveTimeout: const Duration(seconds: 30),
            responseType: ResponseType.plain,
          ),
        ) {
    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) {
          printLog("On request working");
          handler.next(options);
        },
        onResponse: (response, handler) {
          printLog("On response working");
          handler.next(response);
        },
        onError: (err, handler) async {
          _handleError(err, handler);
        },
      ),
    );
  }

  Future<Response?> get(
    String url,
    dynamic retry, {
    Map<String, dynamic>? queryParameters,
    bool isLoaderRequired = false,
    bool isHeaderRequired = false,
  }) async {
    if (!_isConnected()) return null;
    _setHeaders(isHeaderRequired);
    _showLoader(isLoaderRequired);

    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      _handleException(e);
      return e.response;
    } finally {
      _hideLoader(isLoaderRequired);
    }
  }

  Future<Response?> post(
    String url,
    dynamic data,
    dynamic retry, {
    Map<String, dynamic>? queryParameters,
    bool isHeaderRequired = false,
    bool isLoaderRequired = false,
    bool isFormData = false,
    bool isJsonEncodeRequired = true,
    bool isMultipart = false,
  }) async {
    if (!_isConnected()) return null;
    _setHeaders(isHeaderRequired, isMultipart: isMultipart);
    _showLoader(isLoaderRequired);

    try {
      dynamic payload = data;
      if (isFormData) {
        payload = FormData.fromMap(data);
      } else if (isJsonEncodeRequired && data != null) {
        payload = jsonEncode(data);
      }
      final response = await _dio.post(url, data: payload, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      _handleException(e);
      return e.response;
    } finally {
      _hideLoader(isLoaderRequired);
    }
  }

  Future<Response?> put(
    String url,
    dynamic data,
    dynamic retry, {
    Map<String, dynamic>? queryParameters,
    bool isHeaderRequired = true,
    bool isLoaderRequired = false,
  }) async {
    if (!_isConnected()) return null;
    _setHeaders(isHeaderRequired);
    _showLoader(isLoaderRequired);

    try {
      final response = await _dio.put(url, data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      _handleException(e);
      return e.response;
    } finally {
      _hideLoader(isLoaderRequired);
    }
  }

  Future<Response?> delete(
    String url,
    dynamic data,
    dynamic retry, {
    Map<String, dynamic>? queryParameters,
    bool isHeaderRequired = false,
    bool isLoaderRequired = false,
    bool isFormData = false,
    bool isJsonEncodeRequired = true,
  }) async {
    if (!_isConnected()) return null;
    _setHeaders(isHeaderRequired);
    _showLoader(isLoaderRequired);

    try {
      dynamic payload = data;
      if (isFormData) {
        payload = FormData.fromMap(data);
      } else if (isJsonEncodeRequired && data != null) {
        payload = jsonEncode(data);
      }
      final response = await _dio.delete(url, data: payload, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      _handleException(e);
      return e.response;
    } finally {
      _hideLoader(isLoaderRequired);
    }
  }

  void _setHeaders(bool isHeaderRequired, {bool isMultipart = false}) {
    _dio.options.headers["isApp"] = true;
    if (isHeaderRequired) {
      _dio.options.headers["Authorization"] = _accessToken;
      _dio.options.headers["Content-Type"] = isMultipart ? "multipart/form-data" : "application/json";
    }
  }

  bool _isConnected() {
    if (_connectionController.isInternetConnected.isTrue) return true;
    AppWidgets().getSnackBar(title: "Info", message: "No internet connection.");
    return false;
  }

  void _showLoader(bool isLoaderRequired) {
    if (isLoaderRequired) AppHelper().showLoader();
  }

  void _hideLoader(bool isLoaderRequired) {
    if (isLoaderRequired) AppHelper().hideLoader();
  }

  void _handleError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      AuthHelper().clearUserData();
    }
    AppWidgets().getSnackBar(
      title: "Error",
      message: err.response?.data != null
          ? jsonDecode(err.response.toString())["message"] ?? "Unauthorized"
          : err.message ?? "Unknown error",
    );
    handler.next(err);
  }

  void _handleException(DioException e) {
    printLog('DioException: ${e.message}');
    AppHelper().hideLoader();
  }
}*/



import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getX;
import '../core/config/app_config.dart';
import '../core/connection_manager/connection_manager_controller.dart';
import '../core/helper/app_helper.dart';
import '../core/helper/app_widgets.dart';
import '../core/helper/auth_helper.dart';
import '../core/helper/print_log.dart';
import '../core/helper/shared_value_helper.dart';

class ApiClient {
  final Dio _dio;
  final _connectionController = getX.Get.find<ConnectionManagerController>();
  final String _accessToken = accessToken.$;

  ApiClient({String customBaseUrl = ''})
      : _dio = Dio(
          BaseOptions(
            baseUrl: customBaseUrl.isNotEmpty ? customBaseUrl : AppConfig.basePath,
            connectTimeout: const Duration(seconds: 100),
            receiveTimeout: const Duration(seconds: 30),
            responseType: ResponseType.plain,
          ),
        ) {
    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) {
          printLog("On request working");
          handler.next(options);
        },
        onResponse: (response, handler) {
          printLog("On response working");
          handler.next(response);
        },
        onError: (err, handler) async {
          _handleError(err, handler);
        },
      ),
    );
  }

  Future<dynamic> get(
    String url,
    dynamic retry, {
    Map<String, dynamic>? queryParameters,
    bool isLoaderRequired = false,
    bool isHeaderRequired = false,
  }) async {
    if (!_isConnected()) return null;
    _setHeaders(isHeaderRequired);
    _showLoader(isLoaderRequired);

    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return _parseResponse(response);
    } on DioException catch (e) {
      _handleException(e);
      return _parseResponse(e.response);
    } finally {
      _hideLoader(isLoaderRequired);
    }
  }

  Future<dynamic> post(
    String url,
    dynamic data,
    dynamic retry, {
    Map<String, dynamic>? queryParameters,
    bool isHeaderRequired = false,
    bool isLoaderRequired = false,
    bool isFormData = false,
    bool isJsonEncodeRequired = true,
    bool isMultipart = false,
  }) async {
    if (!_isConnected()) return null;
    _setHeaders(isHeaderRequired, isMultipart: isMultipart);
    _showLoader(isLoaderRequired);

    try {
      dynamic payload = data;
      if (isFormData) {
        payload = FormData.fromMap(data);
      } else if (isJsonEncodeRequired && data != null) {
        payload = jsonEncode(data);
      }
      final response = await _dio.post(url, data: payload, queryParameters: queryParameters);
      return _parseResponse(response);
    } on DioException catch (e) {
      _handleException(e);
      return _parseResponse(e.response);
    } finally {
      _hideLoader(isLoaderRequired);
    }
  }

  Future<dynamic> put(
    String url,
    dynamic data,
    dynamic retry, {
    Map<String, dynamic>? queryParameters,
    bool isHeaderRequired = true,
    bool isLoaderRequired = false,
  }) async {
    if (!_isConnected()) return null;
    _setHeaders(isHeaderRequired);
    _showLoader(isLoaderRequired);

    try {
      final response = await _dio.put(url, data: data, queryParameters: queryParameters);
      return _parseResponse(response);
    } on DioException catch (e) {
      _handleException(e);
      return _parseResponse(e.response);
    } finally {
      _hideLoader(isLoaderRequired);
    }
  }

  Future<dynamic> delete(
    String url,
    dynamic data,
    dynamic retry, {
    Map<String, dynamic>? queryParameters,
    bool isHeaderRequired = false,
    bool isLoaderRequired = false,
    bool isFormData = false,
    bool isJsonEncodeRequired = true,
  }) async {
    if (!_isConnected()) return null;
    _setHeaders(isHeaderRequired);
    _showLoader(isLoaderRequired);

    try {
      dynamic payload = data;
      if (isFormData) {
        payload = FormData.fromMap(data);
      } else if (isJsonEncodeRequired && data != null) {
        payload = jsonEncode(data);
      }
      final response = await _dio.delete(url, data: payload, queryParameters: queryParameters);
      return _parseResponse(response);
    } on DioException catch (e) {
      _handleException(e);
      return _parseResponse(e.response);
    } finally {
      _hideLoader(isLoaderRequired);
    }
  }

  dynamic _parseResponse(Response? response) {
    if (response == null) {
      throw Exception('No response from server');
    }
    final contentType = response.headers['content-type']?.join(',') ?? '';
    if (contentType.contains('application/json')) {
      try {
        return jsonDecode(response.data);
      } catch (e) {
        throw Exception('Invalid JSON response');
      }
    } else if (contentType.contains('text/plain')) {
      return response.data.toString();
    } else if (contentType.contains('text/html') || response.data.toString().startsWith('<html')) {
      throw Exception('Received unexpected HTML response from server');
    } else {
      throw Exception('Unexpected response: ${response.statusCode}');
    }
  }

  void _setHeaders(bool isHeaderRequired, {bool isMultipart = false}) {
    _dio.options.headers["isApp"] = true;
    if (isHeaderRequired) {
      _dio.options.headers["Authorization"] = _accessToken;
      _dio.options.headers["Content-Type"] = isMultipart ? "multipart/form-data" : "application/json";
    }
  }

  bool _isConnected() {
    if (_connectionController.isInternetConnected.isTrue) return true;
    AppWidgets().getSnackBar(title: "Info", message: "No internet connection.");
    return false;
  }

  void _showLoader(bool isLoaderRequired) {
    if (isLoaderRequired) AppHelper().showLoader();
  }

  void _hideLoader(bool isLoaderRequired) {
    if (isLoaderRequired) AppHelper().hideLoader();
  }

  void _handleError(DioException err, ErrorInterceptorHandler handler) {
    printLog('API Error: ${err.message}\nStackTrace: ${err.stackTrace}');
    if (err.response?.statusCode == 401) {
      AuthHelper().clearUserData();
    }
    AppWidgets().getSnackBar(
      title: "Error",
      message: err.response?.data != null
          ? jsonDecode(err.response.toString())["message"] ?? "Unauthorized"
          : err.message ?? "Unknown error",
    );
    handler.next(err);
  }

  void _handleException(DioException e) {
    printLog('DioException: ${e.message}\nStackTrace: ${e.stackTrace}');
    AppHelper().hideLoader();
  }
}