import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/networking/dio.dart';
import 'package:luxpay/utils/constants.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutPopup extends StatelessWidget {
  const LogoutPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
      ),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: HexColor("#1E1E1E"),
        // borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 3,
          ),
          Text(
            "Log Out",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 2,
          ),
          Text(
            "Are you sure you want to logout? You'll be required to enter your login details when you return.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => {Navigator.of(context).pop()},
                  child: Container(
                    height: 35,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    String? data = await logout();
                    if (data != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(data),
                        ),
                      );
                      return;
                    }
                    var pref = await SharedPreferences.getInstance();
                    await pref.remove(authToken);
                    await pref.remove(authToken);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginPage.path, (route) => false);
                  },
                  child: Container(
                    height: 35,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 2.5,
          ),
        ],
      ),
    );
  }

  Future<String?> logout() async {
    var pref = await SharedPreferences.getInstance();
    var refresh = await pref.getString(refreshToken) ?? "";
    Map<String, dynamic> body = {"refresh_token": refresh};
    try {
      await dio.post(
        "/api/auth/logout/",
        data: body,
      );
      return null;
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response?.data['message'] ?? "An error occurred";
      } else {
        return "An error occurred";
      }
    } catch (e) {
      return "An error occurred";
    }
  }
}
