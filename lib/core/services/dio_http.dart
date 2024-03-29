import 'dart:js';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:printlog/printlogs.dart';
import 'package:providerskeleton/app/app_key.dart';
import 'package:providerskeleton/core/models/error_model.dart';
import 'package:providerskeleton/core/utils/constants/urls.dart';
import 'package:providerskeleton/meta/widgets/snack_bar.dart';

class HttpService {
  Dio? _dio;

  // final baseUrl = Urls.photosBaseUrl;

  HttpService() {
    _dio = Dio(BaseOptions(
      baseUrl: Urls.baseURL,
      responseType: ResponseType.json,
      connectTimeout: 100000,
      receiveTimeout: 30000,
    ));

    initializeInterceptors();
  }

  //GET

  Future get({String? endPoint}) async {
    Response? response;

    try {
      response = await _dio!.get(endPoint ?? '');
    } on DioError catch (e) {
      response = e.response;
      // throw Exception(e.message);
    }

    return response;
  }

  // POST

  Future<Response> post({
    @required String? endPoint,
    dynamic data,
  }) async {
    Response? response;

    try {
      response = await _dio!.post(endPoint ?? '', data: data);
    } on DioError catch (e) {
      response = e.response;
      // throw Exception(e.message);
    }

    return response!;
  }

  // PUT

  Future put({String? endPoint, Map<String, dynamic>? body}) async {
    Response? response;

    try {
      response = await _dio!.put(endPoint ?? '', queryParameters: body ?? {});
    } on DioError catch (e) {
      response = e.response;

      // throw Exception(e.message);
    }

    return response;
  }

  // Delete

  Future delete({String? endPoint, Map<String, dynamic>? body}) async {
    Response? response;

    try {
      response =
          await _dio!.delete(endPoint ?? '', queryParameters: body ?? {});
    } on DioError catch (e) {
      response = e.response;

      // throw Exception(e.message);
    }

    return response;
  }

  initializeInterceptors() {
    _dio?.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent

      // define bearer token
      options.headers["Authorization"] = "Bearer ";
      PrintLog.green("Url => ${options.uri}");
      PrintLog.green("Header => ${options.headers}");
      PrintLog.green("Body => ${options.data}");

      return handler.next(options);
    }, onResponse: (response, handler) {
      PrintLog.blue("Response => ${response.data}");

      // Do something with response data

      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onError: (DioError e, handler) {
      // Do something with response error

      resopneErrorHandler(response: e.response, dioErrorType: e.type);

      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }));
  }
}

// [Response Error]

void resopneErrorHandler({Response? response, DioErrorType? dioErrorType}) {
  ErrorModel? errorModal;
  try {
    errorModal = ErrorModel.fromJson(response?.data);
  } catch (e) {
    // PrintLog.red(response?.data);
  }

  if (response?.statusCode == 200) {
    PrintLog.green("Successfully GET - 200 ${response?.data}");
  } else if (response?.statusCode == 201) {
    PrintLog.green("Successfully POST - 201 ${response?.data}");
  } else if (response?.statusCode == 401) {
    PrintLog.yellow("Invalid AUTH Token - 401 ${response?.data}");
    appSnackBar(
        duration: const Duration(seconds: 5),
        background: Colors.red,
        content: "${errorModal?.error?.errorMessage}");
  } else if (response?.statusCode == 400) {
    PrintLog.yellow("Bad Reqest - 400 ${response?.data}");

    appSnackBar(
        duration: const Duration(seconds: 5),
        background: Colors.red,
        content: "${errorModal?.error?.errorMessage}");
  } else if (response?.statusCode == 404) {
    PrintLog.yellow("Not Found - 404 ${response?.data}");

    appSnackBar(
        duration: const Duration(seconds: 5),
        background: Colors.red,
        content: "${errorModal?.error?.errorMessage}");
  } else if (response?.statusCode == 422) {
    PrintLog.red("Unprocessable Entity - 422 ${response?.data}");

    appSnackBar(
        duration: const Duration(seconds: 5),
        background: Colors.red,
        content: "${errorModal?.error?.errorMessage}");
  } else if (response?.statusCode == 500) {
    PrintLog.yellow("Server Error - 500 ${response?.data}");
    appSnackBar(
        duration: const Duration(seconds: 5),
        background: Colors.red,
        content: "${errorModal?.error?.errorMessage}");
  } else if (response?.statusCode == 403) {
    PrintLog.yellow("Forbidden - 403 ${response?.data}");
    appSnackBar(
        duration: const Duration(seconds: 5),
        background: Colors.red,
        content: "${errorModal?.error?.errorMessage}");
  } else if (dioErrorType == DioErrorType.connectTimeout) {
    PrintLog.yellow("ConnectTimeout - $response?.data}");
    // [ Here impliment internet Slow widget ]
    appSnackBar(background: Colors.red, content: "Internet slow");
  } else if (dioErrorType == DioErrorType.receiveTimeout) {
    PrintLog.yellow("ReceiveTimeout - ${response?.data}");
    appSnackBar(background: Colors.red, content: "Internet slow");
    // [ Here impliment internet Slow widget ]

  } else if (dioErrorType == DioErrorType.sendTimeout) {
    PrintLog.yellow("SentTimeout - ${response?.data}");

    // [ Here impliment other error and no internet ]
    appSnackBar(background: Colors.red, content: "Internet slow");
  } else if (dioErrorType == DioErrorType.other) {
    PrintLog.yellow("Other Internet - ${response?.data}");
    appSnackBar(background: Colors.red, content: "No Internet");
  }
}
