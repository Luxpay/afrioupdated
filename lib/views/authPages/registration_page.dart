import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/utils/constants.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/utils/validators.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../networking/DioServices/dio_client.dart';

class RegistrationPage extends StatefulWidget {
  static const String path = "/login";
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController controller = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double width = MediaQuery.of(context).size.width;
    //  final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () => {Navigator.pop(context)},
                      icon: const Icon(Icons.arrow_back_ios_new)),
                ),
                const Positioned.fill(
                  child: Center(
                    child: Text(
                      "Create new account",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical! * 2.7,
            ),
            Image.asset(
              "assets/moreToLife.png",
              height: 31.48,
              width: 115,
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical! * 5.5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //name
                  LuxTextField(
                    hint: "Full name",
                    controller: fullNameController,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 2.2,
                  ),
                  //emailvvv
                  LuxTextField(
                    hint: "Email address",
                    controller: emailController,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 2.2,
                  ),
                  LuxTextField(
                    hint: "Phone number",
                    controller: controller,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 2.2,
                  ),
                  //Password
                  LuxTextField(
                    hint: "Password",
                    controller: passwordController,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 4.8,
                  ),
                  Center(
                      child: InkWell(
                          onTap: () async {
                            var email = emailController.text.trim();
                            var password = passwordController.text.trim();
                            var phone = controller.text.trim();
                            var fullname = fullNameController.text.trim();
                            print(email);
                            var validators = [
                              Validators.isValidEmail(email),
                              Validators.isValidPassword(password),
                              Validators.isValidPhoneNumber(phone),
                              fullname.isEmpty
                                  ? "Please Enter your full name"
                                  : null
                            ];

                            if (validators.any((element) => element != null)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(validators.firstWhere(
                                              (element) => element != null) ??
                                          "")));
                              return;
                            }
                            _isLoading = true;
                            if (mounted) {
                              setState(() {});
                            }
                            var response = await register(
                                fullname, email, password, phone);
                            _isLoading = false;
                            if (mounted) {
                              setState(() {});
                            }
                            if (response[1] != null) {
                              // String email = response[1]!.replaceRange(
                              //     2, response[1]!.length - 5, "****");
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => OTPVerification(
                              //         onVerified: () async {
                              //           await Navigator.of(context)
                              //               .pushNamed(CreatePinPage.path);
                              //           Navigator.of(context).pop();
                              //         },
                              //         recipientAddress: obscureEmail(email)),
                              //   ),
                              // );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(response[0] ?? "")));
                            }
                          },
                          child: _isLoading
                              ? luxButtonLoading(HexColor("#D70A0A"), width)
                              : luxButton(HexColor("#D70A0A"), Colors.white,
                                  "Create account", width,
                                  fontSize: 16))),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 7.8,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          " Log in",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: HexColor("#144DDE")),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<String?>> register(
      String fullname, String email, String password, String phone) async {
    Map<String, dynamic> body = {
      'email': email,
      'password': password,
      "phone_number": phone,
      "full_name": fullname,
    };
    try {
      var response = await unAuthDio.post(
        "/api/auth/signup/",
        data: body,
      );
      var data = response.data['data'];
      var pref = await SharedPreferences.getInstance();
      await pref.setString(authToken, data['access']);
      // await pref.setString(refreshToken, data['refresh']);
      //await pref.setString(userPref, User.fromMap(data).toJson());
      return [null, data['email']];
    } on DioError catch (e) {
      print(e.response?.data);
      if (e.response != null) {
        return [e.response?.data['message'] ?? "An error occurred", null];
      } else {
        return ["An error occurred", null];
      }
    } catch (e) {
      print(e);
      return ["An error occurred", null];
    }
  }
}

void purge() async {
  Map<String, dynamic> body = {
    'email': "ezechukwu69@gmail.com",
  };
  try {
    await unAuthDio.post(
      "/api/auth/purge/",
      data: body,
    );

    print("Purge successful");
    return null;
  } on DioError catch (e) {
    print(e.message);
    if (e.response != null) {
      return e.response?.data['message'] ?? "An error occurred";
    } else {
      return;
    }
  } catch (e) {
    return;
  } finally {
    SharedPreferences.getInstance().then((pref) async {
      await pref.clear();
    });
  }
}
