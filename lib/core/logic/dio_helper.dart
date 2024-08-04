import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:quick_log/quick_log.dart';

import '../../views/auth/login.dart';
import 'helper_methods.dart';


enum APIMethods { post, put, delete }

class DioHelper {
  final _dio = Dio(
    BaseOptions(
      receiveDataWhenStatusError: true,
      baseUrl: "https://venusenterpriseapi.dataocean-venus.com/",
      // baseUrl: "https://eservices.aljhospital.com:4438/",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        "Accept": "application/json",
      },
      // todo: get bearer token from shared preferences which saved from generate token
    ),
  );

  DioHelper() {
    _dio.interceptors.add(CustomApiInterceptor());
  }

  // final bloc = KiwiContainer().resolve<GenerateTokenBloc>();

  Future<CustomResponse> fakeCase() async {
    await Future.delayed(const Duration(seconds: 1));
    return CustomResponse(
      isSuccess: true,
      msg: "Success",
    );
  }

  Future<Response> getResponse(String path, Map<String, dynamic>? data,Map<String, dynamic>? headers, APIMethods method,) async {
    late Response resp;
    if (method == APIMethods.post) {
      resp = await _dio.post(path,options: Options(headers: headers), data:  data);
    } else if (method == APIMethods.put) {
      resp = await _dio.put(path, data: data);
    } else if (method == APIMethods.delete) {
      resp = await _dio.delete(path, data: data);
    }
    return resp;
  }

  Future<CustomResponse> send(
    String path, {
    Map<String, dynamic>? data,
     Object? rawData,
    Map<String, dynamic>? headers,
    APIMethods method = APIMethods.post,
  }) async {
    if (path.isEmpty) {
      return fakeCase();
    } else {
      try {
        final resp = await getResponse(path, data,headers,method);

        if ([204, 500].contains(resp.data["code"])) {
          return CustomResponse(data:rawData?? resp.data, msg: resp.data["error_message"]);
        }
        return CustomResponse(
          data: resp.data,
          isSuccess: true,
          msg: resp.data["error_message"] ?? "Success",
        );
      } on DioException catch (ex) {
        return handleServerError(ex);
      }
    }
  }

  Future<CustomResponse> get(String path, {Map<String, dynamic>? params}) async {
    if (path.isEmpty) {
      return fakeCase();
    } else {
      try {
        final resp = await _dio.get(path, queryParameters: params);
        return CustomResponse(data: resp.data, isSuccess: NetworkExceptions.handleResponse(resp) == null, msg: "Success");
      } on DioException catch (ex) {
        return handleServerError(ex);
      }
    }
  }

  CustomResponse handleServerError(DioException err) {
    // if(err.response?.statusCode==401)
    //   {
    //     bloc.add(GenerateTokenEvent());
    //   }
    return CustomResponse(
      statusCode: err.response?.statusCode ?? 500,
      msg: NetworkExceptions.getDioException(err),
    );
  }
}

class CustomResponse {
  final String msg;
  final int? statusCode;
  final bool isSuccess;
  final dynamic data;

  CustomResponse({
    required this.msg,
    this.statusCode,
    this.isSuccess = false,
    this.data,
  });
}

class CustomApiInterceptor extends Interceptor {
  final log = const Logger("");

  // String username = 'TestEnvironments';
  //
  // // String username = 'ALJSecretkey';
  // String password = 'ZGF0YW9jZWFuQDIwMjI=';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);
    // bloc.add(GenerateTokenEvent());
    log.info("*" * 40);
    log.info("onRequest");
    // todo: remove comment
    // options.headers.addAll({
    //   "Authorization": 'Bearer ${CacheHelper.token}'
    // });
    log.info("(${options.method}) ( ${options.baseUrl}${options.path} )");
    if ((options.data ?? {}).isNotEmpty) {
      log.info("Data :");
      if (options.data is Iterable) {
        options.data.forEach((key, value) {
          log.info("$key : $value");
        });
        log.info("-" * 20);
      }
    }

    if ((options.queryParameters).isNotEmpty) {
      log.info("Query Parameters :");
      options.queryParameters.forEach((key, value) {
        log.info("$key : $value");
      });
      log.info("-" * 20);
    }
    log.info("Headers:");
    options.headers.forEach((key, value) {
      log.info("$key : $value");
    });
    log.info("*" * 40);
  }


  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log.error("onError");
    log.error(err);
    if(err.response?.statusCode==401)
      {
        navigateTo(const LoginView(),keepHistory: false);
      }
    return super.onError(err, handler);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    log.fine("onResponse");
    var resp = jsonEncode(response.data);
    log.fine(resp);
    return super.onResponse(response, handler);
  }
}

abstract class NetworkExceptions {
  static String? handleResponse(Response response) {
    int statusCode = response.statusCode ?? 0;
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
         // todo: remove comment
        // CacheHelper.logOut();
        navigateTo(const LoginView(), keepHistory: false);
        return "Unauthorized request. Please log in again.";
      case 404:
        return "Requested resource not found.";
      case 409:
        return "Error due to a conflict. Please try again later.";
      case 408:
        return "Connection request timeout. Please try again later.";
      case 500:
        return "Internal server error. Please try again later.";
      case 503:
        return "Service unavailable. Please try again later.";
      default:
        return null;
    }
  }

  static String getDioException(error) {
    if (error is Exception) {
      try {
        var errorMessage = "";
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              // errorMessage = "Request cancelled.";
              errorMessage = "Contact Administrator";
              break;
            case DioExceptionType.badCertificate:
              errorMessage = "Contact Administrator";
              // errorMessage = "Bad Certificate";
              break;
            case DioExceptionType.connectionError:
              errorMessage = "No internet connection";
              break;
            case DioExceptionType.sendTimeout:
              errorMessage = "Contact Administrator";
              // errorMessage = "Send timeout in connection with API server. Please try again later.";
              break;
            case DioExceptionType.receiveTimeout:
              errorMessage = "Contact Administrator";
              // errorMessage = "Send timeout in connection with API server. Please try again later.";
              break;
            case DioExceptionType.connectionTimeout:
              errorMessage = "Contact Administrator";
              // errorMessage = "Connection request timeout. Please try again later.";
              break;
            case DioExceptionType.badResponse:
              errorMessage = "Contact Administrator";
              // errorMessage = NetworkExceptions.handleResponse(error.response!) ?? "Bad Response";
              break;

            default:
              // errorMessage = "Un Known Error";
              errorMessage = "Contact Administrator";
          }
        } else if (error is SocketException) {
          errorMessage = "No internet connection.";
        } else {
          errorMessage = "Contact Administrator";
          // errorMessage = "Unexpected error occurred. Please try again later.";
        }
        return errorMessage;
      } on FormatException {
        return "Unexpected error occurred. Please try again later.";
      } catch (_) {
        return "Unexpected error occurred. Please try again later.";
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return "Unable to process the data. Please try again later.";
      } else {
        return "Unexpected error occurred. Please try again later.";
      }
    }
  }
}
