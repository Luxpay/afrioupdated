import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'hexcolor.dart';

class LuxToast {
  static void show({required String msg, HexColor? hexColor}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: hexColor == null ? HexColor("#21CE9C") : hexColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
