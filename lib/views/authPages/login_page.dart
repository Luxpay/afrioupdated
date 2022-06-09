import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/models/error.dart';
import 'package:luxpay/models/loginUserModel.dart';

import 'package:luxpay/models/userInfoModel.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/utils/validators.dart';
import 'package:luxpay/views/authPages/create_account.dart';
import 'package:luxpay/views/authPages/create_pin_page.dart';
import 'package:luxpay/views/authPages/login_view_model.dart';
import 'package:luxpay/views/authPages/reset_password.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../networking/dio.dart';
import '../../services/local_auth.dart';
import '../../utils/constants.dart';
import '../../widgets/touchUp.dart';
import '../page_controller.dart';

final loginProvider = ChangeNotifierProvider<LoginViewModel>((ref) {
  return LoginViewModel();
});

class LoginPage extends StatefulWidget {
  static const String path = "/login";
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isEmail = true;
  bool _isLoading = false;

  TextEditingController controller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String errors = "something went wrong";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    Future<bool> _willPopCallback() async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));
      return true; // return true if the route to be popped
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: _willPopCallback,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => {Navigator.maybePop(context)},
                          icon: const Icon(Icons.arrow_back_ios_new)),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal! * 35,
                      ),
                      const Text(
                        "Log in",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )
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
                        Container(
                          child: !isEmail
                              ? LuxTextField(
                                  hint: "Email",
                                  controller: controller,
                                  innerHint: "johndoe@mail.com",
                                )
                              : Container(
                                  // margin: EdgeInsets.only(left: 30, right: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Phone Number",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: HexColor("#1E1E1E")),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 45,
                                            width: 100,
                                            // margin: EdgeInsets.only(top: 2),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                border: Border.all(
                                                    color: borderColor),
                                                color: HexColor("#E8E8E8")
                                                    .withOpacity(0.35)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                //  Image.asset(
                                                //   "assets/nigeria.png",
                                                //   scale: 0.2,
                                                // ),
                                                Text("(+234)"),
                                                Icon(Icons.arrow_drop_down)
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Expanded(
                                            child: LuxTextFieldNumber(
                                              controller: controller,
                                              innerHint: "e.g 07012345678",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 2.2,
                        ),
                        //Password
                        PasswordTextField(
                          hint: "Password",
                          controller: passwordController,
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 4.8,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () {
                              controller.value = TextEditingValue(
                                  text: "",
                                  selection: TextSelection.collapsed(
                                      offset: controller.text.length));
                              setState(() {
                                isEmail = !isEmail;
                              });
                            },
                            child: Text(
                              "Log in with ${!isEmail ? 'phone number' : 'e-mail'}",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 5.8,
                        ),
                        InkWell(
                          onTap: () async {
                            var controllerB = controller.text.trim();
                            var password = passwordController.text.trim();
                            // print(controllerB);
                            // print(password);
                            var validators = [
                              Validators.isValidPassword(password),
                              controllerB.isEmpty
                                  ? "Email or Phone field is empty"
                                  : null
                              //Validators.isValidPhoneNumber(controllerB),
                            ];

                            if (validators.any((element) => element != null)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(validators.firstWhere(
                                              (element) => element != null) ??
                                          "")));
                              return;
                            }
                            setState(() {
                              _isLoading = true;
                            });

                            if (controllerB.contains('@')) {
                              print("email");
                              print("Data : $controllerB");
                              var response =
                                  await loginUser(password, "", controllerB);
                              print('login:$response');
                              if (!response) {
                                setState(() {
                                  _isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(errors)));
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AppPageController()));
                              }
                            } else {
                              print('phoneNumber');
                              print("Data : $controllerB");
                              var response =
                                  await loginUser(password, controllerB, "");
                              print('login:$response');
                              final storage = new FlutterSecureStorage();
                              String? refresh =
                                  await storage.read(key: refreshToken);
                              print('confrim:$refresh');
                              if (!response) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(errors)));
                                setState(() {
                                  _isLoading = false;
                                });
                              } else {
                                var login_confirm = await loginConfrim(refresh);
                                print('logincinfirm:$login_confirm');
                                if (!login_confirm) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Complete your registration Thanks.")));
                                  setState(() {
                                    _isLoading = false;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreatePinPage()));
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  });
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AppPageController()));
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              }
                            }
                          },
                          child: _isLoading
                              ? luxButtonLoading(HexColor("#D70A0A"), width)
                              : luxButton(HexColor("#D70A0A"), Colors.white,
                                  "Log in", width,
                                  fontSize: 16),
                        ),

                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 3.8,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(ResetPassword.path),
                            child: Text(
                              "Forgot password ?",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 4.8,
                        ),
                        Center(
                            child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                                offset: Offset(
                                  0.0,
                                  1.0,
                                ),
                              )
                            ],
                          ),
                          child: InkWell(
                            onTap: () async {},
                            child: Image.asset(
                              "assets/fprint.png",
                              height: 120,
                              width: 120,
                            ),
                          ),
                        )),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 1.8,
                        ),
                        Center(
                          child: Text(
                            "Login with Touch ID",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: HexColor("#333333").withOpacity(0.9)),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 4.8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "New to LuxPay?",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            InkWell(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CreateAccount()))
                              },
                              child: Text(
                                " Create account",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: HexColor("#144DDE")),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> loginUser(String password, String phone, String email) async {
    String token, refToken;
    Map<String, dynamic> body = {
      'password': password,
      "phone": phone,
      "email": email,
    };
    try {
      var response = await unAuthDio.post(
        "/api/user/login/",
        data: body,
      );

      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('Data: ${data}');
        var userData = await LoginData.fromJson(data);

        final storage = new FlutterSecureStorage();
        token = userData.data.tokens.access;
        refToken = userData.data.tokens.refresh;
        //phone = userData.data.user.phone;
        print("Token: ${token}");
        print("refreshToken: ${refToken}");

        await storage.write(key: authToken, value: token);
        await storage.write(key: refreshToken, value: refToken);

        print("Stored Reading.......:${await storage.read(key: refreshToken)}");

        return true;
      } else {
        return false;
      }

      //await pref.setString(userPref, User.fromMap(data).toJson());
      // return [null, data['email']];

    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(' Error: ${e.response?.data}');
        var errorData = e.response?.data;
        var errorMessage = await ErrorMessages.fromJson(errorData);
        errors = errorMessage.errors.message;
        return false;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

  Future<bool> loginConfrim(String? refresh) async {
    Map<String, dynamic> body = {
      'refresh': refresh,
    };
    try {
      var response = await unAuthDio.post(
        "/api/user/login/refresh/",
        data: body,
      );

      debugPrint('Data: ${response.data}');

      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('Data: ${data}');
        //var userData = await LoginData.fromJson(data);
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(' Error: ${e.response?.data}');
        var errorData = e.response?.data;
        var errorMessage = await ErrorMessages.fromJson(errorData);
        errors = errorMessage.errors.message;
        return false;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}

Widget buildText(String text, bool checked) => Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          checked
              ? Icon(Icons.check, color: Colors.green, size: 24)
              : Icon(Icons.close, color: Colors.red, size: 24),
          const SizedBox(width: 12),
          Text(text, style: TextStyle(fontSize: 24)),
        ],
      ),
    );
