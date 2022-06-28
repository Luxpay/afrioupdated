import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/models/errors/error.dart';
import 'package:luxpay/models/loginUserModel.dart';
import 'package:luxpay/models/refreshUser.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/utils/validators.dart';
import 'package:luxpay/views/authPages/create_account.dart';
import 'package:luxpay/views/authPages/create_new_pin_password_profile.dart';
import 'package:luxpay/views/authPages/create_pin_page.dart';
import 'package:luxpay/views/authPages/login_view_model.dart';
import 'package:luxpay/views/authPages/otp_verification.dart';
import 'package:luxpay/views/authPages/reset_password.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';
import '../../networking/dio.dart';
import '../../utils/constants.dart';
import '../../widgets/methods/getDeviceInfo.dart';
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
  String? fcMessageToken;

  TextEditingController controller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var errors;

  String? avatar,
      first_name,
      last_name,
      gender,
      date_of_birth,
      email,
      phone_number_data;
  bool email_verified = false;
  bool has_pin = false;
  //String? is_verified;
  bool phone_verified = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fcmToken(fcMessageToken);
    //getDeviceDetails();
  }

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
      key: _formKey,
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
                                  child: PhoneNumberField(
                                      controller: controller,
                                      hint: "Phone Number")),
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
                              if (!response) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            errors ?? "something went wrong")));
                                setState(() {
                                  _isLoading = false;
                                });
                              } else {
                                if (!phone_verified) {
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
                                                OTPVerification(
                                                    onVerified: () {},
                                                    recipientAddress:
                                                        phone_number_data!)));
                                  });
                                } else if (!has_pin) {
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
                                  });
                                }
                                //else if (date_of_birth == null) {
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(
                                //         content: Text(
                                //             "Complete your registration Thanks.")));
                                // setState(() {
                                //   _isLoading = false;
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               AddBvnPage()));
                                // });
                                // }

                                else if ((first_name == '' ||
                                    last_name == '')) {
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
                                                CreateNewPassword2Profile()));
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
                          height: 25,
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
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
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
                          height: 3,
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
                            ),
                            SizedBox(height: 100)
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
    final storage = new FlutterSecureStorage();
    Map<String, dynamic> body = {
      'password': password,
      "phone": phone,
      "email": email,
    // "token": await storage.read(key: 'fcmToken'),
      //"platform": await storage.read(key: "DeviceName")
    };
    debugPrint("Body: ${body}");
    try {
      var response = await unAuthDio.post(
        "/api/user/login/",
        data: body,
      );
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('Data: ${data}');

        var userData = await LoginUser.fromJson(data);
        debugPrint("I Stop Here");

        token = userData.data.tokens.access;
        refToken = userData.data.tokens.refresh;
        //phone = userData.data.user.phone;
        debugPrint("Token: ${token}");
        debugPrint("refreshToken: ${refToken}");

        await storage.write(key: authToken, value: token);
        await storage.write(key: refreshToken, value: refToken);

        avatar = userData.data.user.avatar;
        first_name = userData.data.user.firstName;
        last_name = userData.data.user.lastName;
        // gender = userData.data.user.gender;
        phone_number_data = userData.data.user.phone;
        email_verified = userData.data.user.emailVerified;
        has_pin = userData.data.user.hasPin;
        // is_verified = userData.data.user.isVerified;
        //date_of_birth = userData.data.user.dateOfBirth;
        phone_verified = userData.data.user.phoneVerified;

        debugPrint("phoneVerification: ${phone_verified}");
        debugPrint("myPhoneNumber: ${phone_number_data}");

        // debugPrint(
        //     "Stored Reading.......:${await storage.read(key: refreshToken)}");

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(' Error Error: ${e.response?.data}');
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
