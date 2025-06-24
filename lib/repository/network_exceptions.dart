


import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'app_strings.dart';

class NetworkExceptions {
  static String messageData = "";

  static getDioException(error) {
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              return messageData = strRequestCancelled;
            case DioExceptionType.connectionTimeout:
              return messageData = strConnectionTimeOut;
            case DioExceptionType.unknown:
              List<String> dateParts = error.message!.split(":");
              List<String> message = dateParts[2].split(",");

              if (message[0].trim() == strConnectionRefused) {
                return messageData = strServerUnderMaintenance;
              } else if (message[0].trim() == strNetworkUnReachable) {
                return messageData = strNetworkUnReachable;
              } else if (dateParts[1].trim() == strFailedToHostLookup) {
                return messageData = strNoInternetConnection;
              } else if (error.message == null) {
                return messageData = strNoInternetConnection;
              } else {
                return messageData = dateParts[1];
              }
            case DioExceptionType.receiveTimeout:
              return messageData = strTimeOut;
            case DioExceptionType.badResponse:
              switch (error.response!.statusCode) {
                case 400:
                  debugPrint('error type of data: ${error.response?.data}');
                  var data = error.response?.data;
                  if (data != null && data is Map<String, dynamic>) {
                    if (data['message'] is String) {
                      return messageData = data['message'];
                    } else if (data['message'] is List) {
                      return messageData = data['message'].join(', ');
                    }
                  }
                  return messageData = strNotFound;


                case 401:
                  // LocalStorage().clearLoginData();
                  // Get.offAllNamed(AppRoutes.loginRoute);
                  try {
                    return messageData = error.response?.data['message'] ??
                        'Unauthorised Exception';
                  } catch (err) {
                    return messageData = 'Unauthorised Exception';
                  }
                case 403:
                  // LocalStorage().clearLoginData();
                  try {
                    return messageData = error.response?.data['message'] ??
                        'Unauthorised Exception';
                  } catch (err) {
                    return messageData = 'Unauthorised Exception';
                  }
                case 404:
                  return messageData = strNotFound;
                case 408:
                  return messageData = strRequestTimeOut;
                case 500:
                  return messageData = strInternalServerError;
                case 503:
                  return messageData = strServiceUnavailable;
                default:
                  return messageData = strSomethingWrong;
              }
            case DioExceptionType.sendTimeout:
              return messageData = strTimeOut;
            case DioExceptionType.badCertificate:
              // TODO: Handle this case.
              break;
            case DioExceptionType.badResponse:
              // TODO: Handle this case.
              break;
            case DioExceptionType.connectionError:
              // TODO: Handle this case.
              break;
          }
        } else if (error is SocketException) {
          return messageData = strSocketExceptions;
        } else {
          return messageData = strUnExceptedException;
        }
      } on FormatException catch (_) {
        return messageData = strFormatException;
      } catch (_) {
        return messageData = strUnExceptedException;
      }
    } else {
      return error.toString().contains(strNotSubType)
          ? messageData = strUnableToProcessData
          : messageData = strUnExceptedException;
    }
  }
}
