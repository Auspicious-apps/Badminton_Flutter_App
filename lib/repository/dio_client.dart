
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';

import 'localstorage.dart';



const Duration _defaultConnectTimeout =
    Duration(milliseconds: Duration.millisecondsPerMinute);
const Duration _defaultReceiveTimeout =
    Duration(milliseconds: Duration.millisecondsPerMinute);
final LocalStorage _localStorage = LocalStorage();

String setContentType() {
  return 'application/json';
}

class DioClient {
  String baseUrl;

  static late Dio _dio;

  final List<Interceptor>? interceptors;

  DioClient(
    this.baseUrl,
    Dio dio, {
    this.interceptors,
  }) {
    _dio = dio;
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter
      ..options.contentType = setContentType()
      ..options.headers = {
        'Content-Type': setContentType(),
      };

    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors!);
    }
    // if (kDebugMode) {
    //   _dio.interceptors.add(LogInterceptor.LogInterceptor(
    //       requestHeader: true,
    //       request: false,
    //       requestBody: true));
    // }
  }

  Future<dynamic> get(String uri,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      bool? skipAuth}) async {
    try {
      if (skipAuth == false) {
        final token = _localStorage.getAuthToken();
        if (token != null) {
          options ??= Options();
          options.headers ??= {};
          options.headers!['Authorization'] = 'Bearer $token';
        }
      }

      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool? isLoading = true,
      bool? skipAuth}) async {
    // FocusManager.instance.primaryFocus?.unfocus();
    try {
      if (skipAuth == false) {
        final token = _localStorage.getAuthToken();
        if (token != null) {
          options ??= Options();
          options.headers ??= {};
          options.headers!['Authorization'] = 'Bearer $token';
        }
      }

      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );


      return response.data;
    } on FormatException catch (_) {

      throw const FormatException('Unable to process the data');
    } catch (e) {

      rethrow;
    }
  }

   Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
        bool? isLoading = true,
        bool? skipAuth
  }) async {
    try {
      if (skipAuth == false) {
        final token = _localStorage.getAuthToken();
        if (token != null) {
          options ??= Options();
          options.headers ??= {};
          options.headers!['Authorization'] = 'Bearer $token';
        }
      }

      final dynamic response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      // ignore: avoid_dynamic_calls
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {

      rethrow;
    }
  }

   Future<dynamic> patch(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool? isLoading = true,
        bool? skipAuth
      }) async {
    try {
      if (skipAuth == false) {
        if (skipAuth == false) {
          final token = _localStorage.getAuthToken();
          if (token != null) {
            options ??= Options();
            options.headers ??= {};
            options.headers!['Authorization'] = 'Bearer $token';
          }
        }
      }

      final dynamic response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,

      );

      // ignore: avoid_dynamic_calls
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {

      rethrow;
    }
  }


  static Future<dynamic> delete(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool? isLoading = true,
        bool? skipAuth
      }) async {
    try {
      if (skipAuth == false) {
        if (skipAuth == false) {
          final token = _localStorage.getAuthToken();
          if (token != null) {
            options ??= Options();
            options.headers ??= {};
            options.headers!['Authorization'] = 'Bearer $token';
          }
        }
      }

      final dynamic response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,

      );

      // ignore: avoid_dynamic_calls
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {

      rethrow;
    }
  }
}
