import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:todo_application/const/app_constants.dart';
class DioClient {
  late final Dio _dio;

  DioClient() {
    String baseUrl = AppConstants.baseUrl;

    /// paste your API's baseUrl here...
    final BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
      responseType: ResponseType.json,
      baseUrl: baseUrl,
      /*headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        }*/
    );

    _dio = Dio(options);
    // if(roleId == 2){
    //   _dio.interceptors.add(AdminAuthorizationInterceptor());
    // }else {
    // }
    _dio.interceptors.add(AuthorizationInterceptor());
    _dio.interceptors.add(LoggingInterceptor());
  }

  Dio getDio() => _dio;
}

class AuthorizationInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);
    options.headers['Accept'] = 'application/json';
    options.headers['User-Agent'] = 'Mozilla/5.0';
    return handler.next(options);

  }
}

class LoggingInterceptor extends InterceptorsWrapper {
  final _logger = Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //_logger.d(options.path);
    _logger.d(options.queryParameters.toString());
    _logger.d(options.headers.toString());
    _logger.d(options.data);
    _logger.d("API : ${options.baseUrl}${options.path} and Method : ${options.method}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d(response.data);
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final errorMessage = err.message;
    final errorData = err.response?.data;
    _logger.e(errorMessage);
    log("Token Error : ${err.message}");
    if (err.type == DioExceptionType.connectionTimeout) {
    }
    if (errorData != null) {
      _logger.e(errorData);
    }
    super.onError(err, handler);
  }
}
