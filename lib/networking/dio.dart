// create a class extending DioInterceptor implementing all fields and methods
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/utils/constants.dart';


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
    // if (err.response?.statusCode == 401) {
    //   var tokenError = await ExpiredToken.fromJson(err.response?.data);
    //   if (tokenError.errors.message.messages[0].message ==
    //       "Token is invalid or expired") {
            
  
    //         return handler.next(err);
       
    //   }
    // }

    /**
     * and Ends Here
     */
    return handler.next(err);
  }


}

