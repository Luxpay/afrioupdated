import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/models/errors/error.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/login_page.dart';

import '../networking/DioServices/dio_client.dart';
import 'methods/showDialog.dart';

class LogoutPopup extends StatelessWidget {
  LogoutPopup({Key? key}) : super(key: key);

  static String errors = 'something went wrong';
  static String statusCode = '';

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () =>
                      {Navigator.of(context, rootNavigator: true).pop()},
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
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    _fetchLogout(context);
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

  Future<bool> logout(context) async {
    try {
      var response = await dio.post(
        "/auth/logout/",
      );
      debugPrint('${response.statusCode}');

      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          statusCode = "401";
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
          debugPrint("LogOut");
          return false;
        } else {
          debugPrint(' Error: ${e.response?.data}');
          var errorData = e.response?.data;
          var errorMessage = await ErrorMessages.fromJson(errorData);
          errors = errorMessage.errors.message;
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

  void _fetchLogout(BuildContext context) async {
    // show the loading dialog
    showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });

    Future.delayed(const Duration(milliseconds: 100), () async {
// Here you can write your code

      var data = await logout(context);

      debugPrint("$data");
      if (!data) {
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errors),
          ),
        );
        return;
      } else if (statusCode == 401) {
        Navigator.of(context).pop();
        showExpiredsessionDialog(
            context, "Please Login again\nThanks", "Expired Session");
      } else {
        Navigator.of(context).pop();
        // final storage = new FlutterSecureStorage();
        // await storage.delete(key: authToken);

        // print("ALL Token Deleted");

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
        debugPrint("LogOut");
      }
    });
  }
}
