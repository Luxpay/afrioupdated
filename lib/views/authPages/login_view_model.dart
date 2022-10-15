import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../networking/DioServices/dio_client.dart';

class LoginViewModel extends ChangeNotifier {
  Future<LoginAction> login(String email, String password, bool isEmail) async {
    Map<String, dynamic> body = {
      'email': email,
      'phone_number': email,
      'password': password,
    };
    if (isEmail) {
      body.remove('phone_number');
    } else {
      body.remove('email');
    }
    try {
      var response = await unAuthDio.post(
        "/api/auth/login/?type=${!isEmail ? 'phone' : 'email'}",
        data: body,
      );
      var data = response.data['data'];
      var pref = await SharedPreferences.getInstance();
      await pref.setString(authToken, data['access']);
      //await pref.setString(refreshToken, data['refresh']);
     // await pref.setString(userPref, User.fromMap(data).toJson());
      return LoginAction(
        data: null,
        navType:
            !data['is_pin_set'] ? NavigationType.setPin : NavigationType.home,
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return LoginAction(
            data: e.response?.data['message'] ?? "An error occurred");
      } else {
        return LoginAction(data: "An error occurred");
      }
    } catch (e) {
      return LoginAction(data: "An error occurred");
    }
  }
}

enum NavigationType {
  home,
  setPin,
}

class LoginAction {
  String? data;
  NavigationType? navType;
  LoginAction({this.data, this.navType});
}
