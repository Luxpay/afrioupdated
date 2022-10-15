import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../utils/constants.dart';

// which needs to be passed with "Authorization" header as Bearer token.
class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (await getAuthToken() != null) {
      options.headers.addAll({
        'Authorization': 'Bearer ${await getAuthToken() ?? ""}',
      });
    }
    // continue with the request
    super.onRequest(options, handler);
  }

  // create an async function that returns token from shared preferences called getAuthToken
  Future<String?> getAuthToken() async {
    final storage = new FlutterSecureStorage();
    return await storage.read(key: authToken);
  }
}
