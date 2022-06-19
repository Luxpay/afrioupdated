// create a class extending DioInterceptor implementing all fields and methods
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/utils/constants.dart';
import '../models/errors/expired_token.dart';
import '../models/refreshUser.dart';

class HeaderInterceptor extends Interceptor {
  final _storage = const FlutterSecureStorage();
  String? accessToken;
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
    final storage = new FlutterSecureStorage();
    return await storage.read(key: authToken);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    log(response.data.toString(), name: "Response");
    return handler.next(response);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    log("${err.message} - ${err.response?.data}", name: "Errors");
/**
 * Token refreshing login starts here
 */
    if (err.response?.statusCode == 401) {
      var tokenError = await ExpiredToken.fromJson(err.response?.data);
      if (tokenError.errors.message.messages[0].message ==
          "Token is invalid or expired") {
        if (await _storage.containsKey(key: refreshToken)) {
          if (await refreshTokennns()) {
            return handler.next(err);
          }
        }
      }
    }

    /**
     * and Ends Here
     */
    return handler.next(err);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = new Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return unAuthDio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<bool> refreshTokennns() async {
    String token, refToken;
    var refreshTokenn = await _storage.read(key: refreshToken);
    final response = await unAuthDio
        .post('/api/user/login/refresh/', data: {'refresh': refreshTokenn});
    if (response.statusCode == 200) {
      var data = response.data;
      debugPrint('${response.statusCode}');
      debugPrint('Data: ${data}');
      debugPrint("Trying To Refresh Token${response.data.toString()}");
      var userData = await RefreahUser.fromJson(data);
      final storage = new FlutterSecureStorage();
      token = userData.data.access;
      refToken = userData.data.refresh;
      await storage.write(key: authToken, value: token);
      await storage.write(key: refreshToken, value: refToken);
      return true;
    } else {
      // refresh token is wrong
      // accessToken = null;
      // _storage.deleteAll();
      return false;
    }
  }
}

Dio dio = Dio(BaseOptions(baseUrl: base_url))
  ..interceptors.addAll([HeaderInterceptor()]);

Dio unAuthDio = Dio(BaseOptions(baseUrl: base_url));
