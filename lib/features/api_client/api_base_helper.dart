import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// Define a callback interface
abstract class DialogCallback {
  void showAlertDialog(String message);
}

class ApiBaseHelper {
  final _dio = GetIt.I<Dio>();
  final DialogCallback? dialogCallback;

  ApiBaseHelper({this.dialogCallback});

  Future<dynamic> get(String url, {String? tokenValue}) async {
    // dynamic responseJson;
    try {
      final response = await _dio.get(url);

      dynamic responseJson = _returnResponse(response);
      return responseJson;
    } catch (e, stackTrace) {
      log("API Base Helper catch (e) ==> $e");
      await Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      if (e is DioException) {
        log("API Base Helper catch (e) if ==> ${e.response?.statusCode}");
        Response responseData = Response(requestOptions: RequestOptions());
        dynamic responseJson = _returnResponse(e.response ?? responseData );
        return responseJson;
      }
    }
  }

  Future<dynamic> post(String url,
      {required Map<String, dynamic> reqbody}) async {
    // dynamic responseJson;
    try {
      final response = await _dio.post(url, data: FormData.fromMap(reqbody));
      dynamic responseJson = _returnResponse(response);
      return responseJson;
    } catch (e, stackTrace) {
      log("API Base Helper catch Post (e) ==> $e");
      await Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      if (e is DioException) {
        // log("API Base Helper catch Post (e) if ==> ${e.response?.statusCode}");
        Response responseData = Response(requestOptions: RequestOptions());
        dynamic responseJson = _returnResponse(e.response ?? responseData );
        // log("API Base Helper Post 11 ==> ${responseJson.statusMessage}");
        return responseJson;
      }
    }
  }

  Future<dynamic> put(String url,
      {required Map<String, dynamic> reqbody}) async {
    // dynamic responseJson;
    try {
      final response = await _dio.put(url, data: FormData.fromMap(reqbody));
      dynamic responseJson = _returnResponse(response);
      return responseJson;
    } catch (e, stackTrace) {
      log("API Base Helper catch Post (e) ==> $e");
      await Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      if (e is DioException) {
        // log("API Base Helper catch Post (e) if ==> ${e.response?.statusCode}");
        Response responseData = Response(requestOptions: RequestOptions());
        dynamic responseJson = _returnResponse(e.response ?? responseData );
        // log("API Base Helper Post 11 ==> ${responseJson.statusMessage}");
        return responseJson;
      }
    }
  }

  Future<dynamic> patch(String url,
      {required Map<String, dynamic> reqbody}) async {
    // dynamic responseJson;
    try {
      final response = await _dio.patch(url, data: reqbody);
      dynamic responseJson = _returnResponse(response);
      log("API Base Helper Patch 00 ==> ${responseJson.data["data"]}");
      return responseJson;
    } catch (e, stackTrace) {
      log("API Base Helper catch Patch (e) ==> $e");
      await Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      if (e is DioException) {
        log("API Base Helper catch Patch (e) if ==> ${e.response?.statusCode}");

        Response responseData = Response(requestOptions: RequestOptions());
        dynamic responseJson = _returnResponse(e.response ?? responseData );
        log("API Base Helper Patch 11 ==> ${responseJson.statusMessage}");
        return responseJson;
      }
    }
  }

  Future<dynamic> delete(String url) async {
    // dynamic responseJson;
    try {
      final response = await _dio.delete(url);
      dynamic responseJson = _returnResponse(response);
      log("API Base Helper Patch 00 ==> ${responseJson.data["data"]}");
      return responseJson;
    } catch (e, stackTrace) {
      log("API Base Helper catch Patch (e) ==> $e");
      await Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      if (e is DioException) {
        log("API Base Helper catch Patch (e) if ==> ${e.response?.statusCode}");

        Response responseData = Response(requestOptions: RequestOptions());
        dynamic responseJson = _returnResponse(e.response ?? responseData );
        log("API Base Helper Patch 11 ==> ${responseJson.statusMessage}");
        return responseJson;
      }
    }
  }
}

dynamic _returnResponse(Response response) {
  log('Data in return response ==> ${response.statusCode}');
  switch (response.statusCode) {
    case 200:
      var responseJson = (response);
      return responseJson;

    case 201:
      var responseJson = (response);
      return responseJson;

    case 202:
      var responseJson = (response);
      return responseJson;

    case 400:
      var responseJson = response;
      return responseJson;

    case 401:
      var responseJson = response;
      return responseJson;

    case 403:
      var responseJson = response;
      return responseJson;

    case 404:
      var responseJson = response;
      return responseJson;

    case 422:
      var responseJson = response;
      return responseJson;

    case 500:
      var responseJson = response;
      return responseJson;
  }
}
