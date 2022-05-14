// create a class extending DioInterceptor implementing all fields and methods
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:luxpay/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderInterceptor extends Interceptor {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // get Auth token from shared preferences and add it to header
    if (await getAuthToken() != null) {
      options.headers.addAll({
        'Authorization': 'Bearer ${await getAuthToken() ?? ""}',
      });
    }

    log(options.headers.toString(), name: "Request");
    log(options.data.toString(), name: "Request");
    return handler.next(options);
  }

  // create an async function that returns token from shared preferences called getAuthToken
  Future<String?> getAuthToken() async {
    var prefs = await SharedPreferences.getInstance();
    return await prefs.getString(authToken);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    log(response.data.toString(), name: "Response");
    return handler.next(response);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    log("${err.message} - ${err.response?.data}", name: "Error");
    return handler.next(err);
  }
}

Dio dio = Dio(BaseOptions(baseUrl: "https://staging.luxpay.ng"))
  ..interceptors.addAll([HeaderInterceptor()]);

Dio unAuthDio = Dio(BaseOptions(baseUrl: "https://staging.luxpay.ng"));
