import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getX;
import '../core/config/app_config.dart';
import '../core/connection_manager/connection_manager_controller.dart';
import '../core/helper/app_helper.dart';
import '../core/helper/app_widgets.dart';
import '../core/helper/print_log.dart';
import '../core/helper/shared_value_helper.dart';

class ApiClient {
  late final Dio dio;
  final _connectionController = getX.Get.find<ConnectionManagerController>();
  final String _accessToken = accessToken.$;

  ApiClient({String customBaseUrl = ''}) {
    dio = Dio(
      BaseOptions(
        baseUrl: customBaseUrl.isNotEmpty ? customBaseUrl : AppConfig.basePath,
        connectTimeout: const Duration(seconds: 100),
        receiveTimeout: const Duration(seconds: 30),
        responseType: ResponseType.plain,
      ),
    );

    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) {
          printLog("On request working");
          handler.next(options);
        },
        onResponse: (response, handler) {
          _handleStatusCode(response.statusCode, response);
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
        Map<String, dynamic>? mQueryParameters,
        bool isLoaderRequired = false,
        bool isHeaderRequired = false,
      }) async {
    if (!_isConnected()) return null;
    _setHeaders(isHeaderRequired);
    _showLoader(isLoaderRequired);

    try {
      final response = await dio.get(url, queryParameters: mQueryParameters);
      _hideLoader(isLoaderRequired);
      return response;
    } on DioException catch (e) {
      _handleException(e, isHeaderRequired);
      return null;
    }
  }

  Future<Response?> post(
      String url,
      dynamic data,
      dynamic retry, {
        bool isHeaderRequired = false,
        bool isLoaderRequired = false,
        bool isFormData = false,
        bool isJsonEncodeRequired = true,
      }) async {
    if (!_isConnected()) return null;
    _setHeaders(isHeaderRequired);
    _showLoader(isLoaderRequired);

    try {
      final payload = isFormData
          ? FormData.fromMap(data)
          : isJsonEncodeRequired
          ? jsonEncode(data)
          : data;
      final response = await dio.post(url, data: payload);
      _hideLoader(isLoaderRequired);
      return response;
    } on DioException catch (e) {
      _handleException(e, isHeaderRequired);
      return null;
    }
  }

  Future<Response?> put(
      String url,
      dynamic data,
      dynamic retry, {
        bool isHeaderRequired = true,
        bool isLoaderRequired = false,
      }) async {
    if (!_isConnected()) return null;
    _setHeaders(isHeaderRequired);
    _showLoader(isLoaderRequired);

    try {
      final response = await dio.put(url, data: data);
      _hideLoader(isLoaderRequired);
      return response;
    } on DioException catch (e) {
      _handleException(e, isHeaderRequired);
      return null;
    }
  }

  Future<Response?> delete(
      String url,
      dynamic data,
      dynamic retry, {
        bool isHeaderRequired = false,
        bool isLoaderRequired = false,
      }) async {
    if (!_isConnected()) return null;
    _setHeaders(isHeaderRequired);
    _showLoader(isLoaderRequired);

    try {
      final response = await dio.delete(url, data: data);
      _hideLoader(isLoaderRequired);
      return response;
    } on DioException catch (e) {
      _handleException(e, isHeaderRequired);
      return null;
    }
  }

  void _setHeaders(bool isHeaderRequired) {
    dio.options.headers["isApp"] = true;
    if (isHeaderRequired) {
      dio.options.headers["Authorization"] = _accessToken;
      dio.options.headers["Content-Type"] = "application/json";
    }
  }

  void _handleStatusCode(int? statusCode, Response? response) {
    switch (statusCode) {
      case 200:
      case 201:
        break;
      case 400:
        AppWidgets().getSnackBar(title: "Bad Request", message: "Invalid request.");
        break;
      case 401:
        AppWidgets().getSnackBar(title: "Unauthorized", message: "Session expired. Please login again.");
        break;
      case 403:
        AppWidgets().getSnackBar(title: "Forbidden", message: "You do not have permission.");
        break;
      case 404:
        AppWidgets().getSnackBar(title: "Not Found", message: "Resource not found.");
        break;
      case 500:
        AppWidgets().getSnackBar(title: "Server Error", message: "Internal server error.");
        break;
      case 502:
      case 503:
      case 504:
        AppWidgets().getSnackBar(title: "Server Unavailable", message: "Service temporarily unavailable.");
        break;
      default:
        if (statusCode != null) {
          AppWidgets().getSnackBar(title: "Error", message: "Unexpected error: $statusCode");
        } else {
          AppWidgets().getSnackBar(title: "Error", message: "Unknown error occurred.");
        }
    }
  }

  void _handleError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    _handleStatusCode(statusCode, err.response);
    if (statusCode == 401) {
      dio.options.headers["Authorization"] = _accessToken;
      printLog("Refreshing token done");
      handler.next(err);
    } else {
      if (err.response != null) {
        handler.resolve(err.response!);
      } else {
        handler.next(err);
      }
    }
  }

  void _handleException(DioException e, bool isHeaderRequired) {
    AppHelper().hideLoader();
    final responseStr = e.response?.data?.toString() ?? '';
    if (responseStr.startsWith('<!DOCTYPE html>')) {
      AppWidgets().getSnackBar(
        title: "Error",
        message: "Server returned an unexpected response. Please try again later.",
      );
      return;
    }
    AppWidgets().getSnackBar(
      title: "Error",
      message: "Something went wrong. Please try again later.",
    );
  }

  bool _isConnected() {
    if (_connectionController.isInternetConnected.isTrue) {
      return true;
    }
    AppWidgets().getSnackBar(title: "Info", message: "No internet connection.");
    return false;
  }

  void _showLoader(bool isLoaderRequired) {
    if (isLoaderRequired) AppHelper().showLoader();
  }

  void _hideLoader(bool isLoaderRequired) {
    if (isLoaderRequired) AppHelper().hideLoader();
  }
}
