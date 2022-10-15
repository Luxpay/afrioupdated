import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../utils/constants.dart';
import '../dio.dart';

Dio dioClient = Dio();
Dio dio = Dio(
  BaseOptions(
    baseUrl: base_url,
    connectTimeout: 100000,
    receiveTimeout: 100000,
    responseType: ResponseType.json,
  ),
)..interceptors.addAll([
    // LoggerInterceptor(),
    HeaderInterceptor(),
    PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90),
  ]);

Dio unAuthDio = Dio(
  BaseOptions(
    baseUrl: base_url,
    connectTimeout: 20000,
    receiveTimeout: 10000,
    responseType: ResponseType.json,
  ),
)..interceptors.addAll([
    //LoggerInterceptor(),
    PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90),
  ]);
