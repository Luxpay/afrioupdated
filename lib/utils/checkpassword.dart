

import 'package:luxpay/utils/colors.dart';

Map checkPassword(String value) {
  String _password = value.trim();
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  if (_password.isEmpty) {
    return {
      'result': "Poor",
      'color': red2,
      'why': 'Please enter your password',
      'error': true
    };
  } else if (_password.length < 6) {
    return {
      'result': "Weak",
      'color': red2,
      'why': 'Your password is too short',
      'error': true
    };
  } else if (_password.length < 8) {
    return {
      'result': "Ok",
      'color': green2,
      'why': 'Your password is acceptable but not strong',
      'error': false
    };
  } else {
    if (!letterReg.hasMatch(_password) || !numReg.hasMatch(_password)) {
      return {
        'result': "Good",
        'color': green2,
        'why': 'Your password is good',
        'error': false
      };
    } else {
      // Password length >= 8
      // Password contains both letter and digit characters
      return {
        'result': "Strong",
        'color': green2,
        'why': 'Your password is strong',
        'error': false
      };
    }
  }
}
