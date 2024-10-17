import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'interceptor.dart';

enum RequestType {
  get,
  post,
  put,
  delete,
}

class BaseClient {
  static final BaseClient shared = BaseClient._privateConstructor();

  BaseClient._privateConstructor();

  final Dio dioInstance = Dio(
      BaseOptions(headers: {'Accept': 'application/json', "client": "OMS"}));

  // request timeout (default 10 seconds)

  /// dio getter (used for testing)
  get dio => dioInstance;

  /// perform safe api request
  safeApiCall(
    String url,
    RequestType requestType, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Function(Response response) onSuccess,
    Function(Either<String, String>)? onError,
    Function(int value, int progress)? onReceiveProgress,
    Function(int total, int progress)?
        onSendProgress, // while sending (uploading) progress
    Function? onLoading,
    bool? includeAuth = true,
    dynamic data,
  }) async {
    dioInstance.interceptors.clear();
    dioInstance.interceptors.add(CustomLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      dio: dioInstance,
    ));
    try {
      // 1) indicate loading state
      await onLoading?.call();
      // 2) try to perform http request
      late Response response;

      var option = Options(
        headers: headers,
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
      );
      switch (requestType) {
        case RequestType.get:
          response = await dioInstance.get(url,
              onReceiveProgress: onReceiveProgress,
              queryParameters: queryParameters,
              options: option);
          break;
        case RequestType.post:
          response = await dioInstance.post(
            url,
            data: data,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
            queryParameters: queryParameters,
            options: option,
          );
          break;
        case RequestType.put:
          response = await dioInstance.put(
            url,
            data: data,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
            queryParameters: queryParameters,
            options: option,
          );
          break;
        case RequestType.delete:
          response = await dioInstance.delete(
            url,
            data: data,
            queryParameters: queryParameters,
            options: option,
          );
          break;
      }
      // 3) return response (api done successfully)
      await onSuccess(response);
    } on DioException catch (error) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          if (onError != null) {
            onError(const Left("Time Out Exception"));
          }

        case DioExceptionType.connectionError:
          if (onError != null) {
            onError(const Left("No Internet Connection"));
          }

        case DioExceptionType.badResponse:
          if (onError != null) {
            onError(Left("${error.response}"));
          }

        case DioExceptionType.cancel:
          if (onError != null) {
            onError(Left("Request Cancelled\n\n${error.message}'"));
          }

        default:
          if (onError != null) {
            onError(Left(error.message ?? "Something went wrong"));
          }
      }

      // dio error (api reach the server but not performed successfully
      //_handleDioError(error: error, url: url, onError: onError);
    } on SocketException {
      // No internet connection
      if (onError != null) {
        onError(const Left("No Internet Connection"));
      }
    } catch (error) {
      if (onError != null) {
        onError(Left("$error"));
      }
    }
  }
}
