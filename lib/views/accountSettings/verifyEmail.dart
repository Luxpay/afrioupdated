import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../models/aboutUser.dart';
import '../../models/errors/authError.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/colors.dart';
import '../../utils/hexcolor.dart';
import '../../widgets/lux_buttons.dart';
import '../../widgets/methods/showDialog.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  TextEditingController controllerEmail = TextEditingController();
  bool _isLoading = false;
  var errors;

  String currentEmail = "loading...";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      aboutUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    //margin: EdgeInsets.only(left: 30, right: 30),
                    width: double.infinity,
                    child: Stack(children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: HexColor("#333333").withOpacity(0.3),
                              width: 0.5,
                            ),
                          )),
                          child: Container(
                            margin: EdgeInsets.only(top: 10, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () => {Navigator.pop(context)},
                                    icon: const Icon(Icons.arrow_back_ios_new)),
                                const Text(
                                  "Verify Email",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 80, left: 30, right: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // LuxTextField(
                                //     hint: "Email",
                                //     controller: controllerEmail,
                                //     innerHint: "eg johnson@gmail.com",
                                //     onChanged: (v) {}),
                                SizedBox(height: 20),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(color: grey1),
                                  child: Center(
                                    child: Text(
                                      currentEmail,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                InkWell(
                                    onTap: () async {
                                      //var email = controllerEmail.text.trim();

                                      setState(() {
                                        _isLoading = true;
                                      });
                                      // var validators = [];
                                      // if (validators
                                      //     .any((element) => element != null)) {
                                      //   ScaffoldMessenger.of(context)
                                      //       .showSnackBar(SnackBar(
                                      //           content: Text(validators
                                      //                   .firstWhere((element) =>
                                      //                       element != null) ??
                                      //               "")));
                                      //   return;
                                      // }

                                      var response = await updateUserEmail(
                                        currentEmail,
                                      );

                                      if (!response) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        showErrorDialog(
                                            context, errors, "Verification");
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      } else {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        showErrorDialog(
                                            context,
                                            "Verification link have been sent to your email\ncheck your email to complete your verification",
                                            "Verification");
                                      }
                                    },
                                    child: _isLoading
                                        ? luxButtonLoading(HexColor("#D70A0A"),
                                            double.infinity)
                                        : luxButton(
                                            HexColor("#D70A0A"),
                                            Colors.white,
                                            "Verify",
                                            double.infinity,
                                            fontSize: 16)),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ))
                    ])))));
  }

  Future<bool> aboutUser() async {
    var response = await dio.get(
      "/user/profile/",
    );
    debugPrint('Data Code ${response.statusCode}');
    try {
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('Check Data ${data}');

        var user = await AboutUser.fromJson(data);

        setState(() {
          // controllerEmail.text = user.data.email;
          currentEmail = user.data.email;
        });

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          showExpiredsessionDialog(
              context, "Please Login again\nThanks", "Expired Session");
          return false;
        } else {
          var errorData = e.response?.data;
          var errorMessage = await AuthError.fromJson(errorData);
          errors = errorMessage.message;
          return false;
        }
      } else {
        errors = errorMessage;
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

  Future<bool> updateUserEmail(email) async {
    Map<String, dynamic> body = {"email": email};
    var response =
        await dio.post("/user/email/request-verification/", data: body);
    debugPrint('Data Code ${response.statusCode}');
    try {
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          showExpiredsessionDialog(
              context, "Please Login again\nThanks", "Expired Session");
          return false;
        } else {
          var errorData = e.response?.data;
          var errorMessage = await AuthError.fromJson(errorData);
          errors = errorMessage.message;
          return false;
        }
      } else {
        errors = errorMessage;
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}
