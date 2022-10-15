import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/utils/validators.dart';
import 'package:luxpay/views/authPages/create_account.dart';
import 'package:luxpay/views/authPages/create_user_profile.dart';
import 'package:luxpay/views/authPages/login_view_model.dart';
import 'package:luxpay/views/authPages/otp_verification.dart';
import 'package:luxpay/views/authPages/reset_password.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';
import '../../models/errors/authError.dart';
import '../../models/userData.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/constants.dart';
import '../../widgets/methods/getDeviceInfo.dart';
import '../../widgets/touchUp.dart';
import '../page_controller.dart';
import 'create_pin_page.dart';
import 'deviceCheck/changeDeviceOtp.dart';

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
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var errors;
  //var avatar, email;
  var first_name, last_name;
  bool has_pin = false;

  final storage = new FlutterSecureStorage();

  LocalAuthentication localAuthentication = LocalAuthentication();
  bool? canScan;

  String? checkPin;

  bool? checkEmailVerify;

  void checkBiometrics() async {
    canScan = await localAuthentication.canCheckBiometrics;
    authenticate();
  }

  void authenticate() async {
    bool didAuthenticate = false;
    didAuthenticate = await localAuthentication.authenticate(
        localizedReason: 'please authenticate to login',
        options: AuthenticationOptions(stickyAuth: true, biometricOnly: true));

    if (didAuthenticate) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AppPageController()));
    }
  }

  void numberPhone() async {
    var number = await storage.read(key: phoneNumber);
    if (number != null) {
      setState(() {
        controllerPhone.text = number;
        debugPrint("$number");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fcmToken();
    numberPhone();
    getDeviceDetails();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double width = MediaQuery.of(context).size.width;

    Future<bool> _willPopCallback() async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));
      return true; // return true if the route to be popped
    }

    return AnnotatedRegion(
      // Reset SystemUiOverlayStyle for PageOne.
      // If this is not set, the status bar will use the style applied from another route.
      value: SystemUiOverlayStyle(
        statusBarColor: grey1,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        key: _formKey,
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: _willPopCallback,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // IconButton(
                          //     onPressed: () => {Navigator.maybePop(context)},
                          //     icon: const Icon(Icons.arrow_back_ios_new)),
                          // SizedBox(
                          //   width: SizeConfig.safeBlockHorizontal! * 43.9,
                          // ),
                          const Text(
                            "Log in Account",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 2.7,
                      ),
                      Center(
                        child: Image.asset(
                          "assets/moreToLife.png",
                          scale: 1.6,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 2.0,
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
                                      controller: controllerEmail,
                                      innerHint: "johndoe@mail.com",
                                      boaderColor: HexColor("#D70A0A"),
                                    )
                                  : Container(
                                      child: PhoneNumberField(
                                          boaderColor: HexColor("#D70A0A"),
                                          controller: controllerPhone,
                                          innerHint: "Phone Number")),
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
                              height: SizeConfig.safeBlockVertical! * 2.0,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: () {
                                  controllerEmail.value = TextEditingValue(
                                      text: "",
                                      selection: TextSelection.collapsed(
                                          offset: controllerEmail.text.length));
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
                              height: SizeConfig.safeBlockVertical! * 3.0,
                            ),
                            InkWell(
                              onTap: () async {
                                var email = controllerEmail.text.trim();
                                var phone = controllerPhone.text.trim();
                                var password = passwordController.text.trim();
                                // print(controllerB);
                                // print(password);
                                var validators;
                                if (email.isNotEmpty) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  validators = [
                                    Validators.forWithdrawal(password),
                                    Validators.isValidEmail(email),
                                  ];
                                } else {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  validators = [
                                    Validators.forWithdrawal(password),
                                    Validators.isValidPhoneNumber(phone),
                                  ];
                                }

                                if (validators
                                    .any((element) => element != null)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(validators.firstWhere(
                                                  (element) =>
                                                      element != null) ??
                                              "")));
                                  return;
                                }
                                setState(() {
                                  _isLoading = true;
                                });

                                if (email.isNotEmpty) {
                                  var response =
                                      await loginUser(password, "", email);
                                  print('login:$response');
                                  if (!response) {
                                    if (errors == "email not verified") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(errors ??
                                                  "Please check your Email, or login with phone number")));
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(errors ??
                                                "something went wrong")));
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  } else {
                                    if ((first_name == null ||
                                        last_name == null)) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Complete your registration Thanks.")));
                                      setState(() {
                                        _isLoading = false;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CreateUserProfile()));
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
                                } else {
                                  var response =
                                      await loginUser(password, phone, "");
                                  print('login:$response');
                                  if (!response) {
                                    if (errors == "User not verified") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OTPVerification(
                                                      recipientAddressEmail:
                                                          email,
                                                      recipientAddress:
                                                          phone)));
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(errors ??
                                                "something went wrong")));
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  } else {
                                    if ((first_name == null ||
                                        last_name == null)) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Complete your registration Thanks.")));
                                      setState(() {
                                        _isLoading = false;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CreateUserProfile()));
                                      });
                                    } else if (checkPin == 'false') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreatePinPage()));

                                      setState(() {
                                        _isLoading = false;
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
                              height: SizeConfig.safeBlockVertical! * 3.0,
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
                              height: 20,
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
                                onTap: () async {
                                  // debugPrint("Biometric Check");
                                  // final prefs =
                                  //     await SharedPreferences.getInstance();
                                  // String? checkData =
                                  //     prefs.getString(completeSignUp);
                                  // debugPrint("Biometric: $checkData");
                                  // if (checkData == 'done') {
                                  //   checkBiometrics();
                                  // } else {
                                  //   // errors =
                                  //   //     'Login with your phoneNumber and Password';
                                  //   // ScaffoldMessenger.of(context).showSnackBar(
                                  //   //     SnackBar(content: Text("$errors")));
                                  // }
                                },
                                child: Image.asset(
                                  "assets/fprint.png",
                                  height: 45,
                                  width: 45,
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
                                    color:
                                        HexColor("#333333").withOpacity(0.9)),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical! * 2.8,
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
                                    " Create New account",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: HexColor("#D70A0A")),
                                  ),
                                ),
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
        ),
      ),
    );
  }

  Future<bool> loginUser(String password, String phone, String email) async {
    String token, url;

    final storage = new FlutterSecureStorage();
    Map<String, dynamic> body = {
      'password': password,
      "phone": phone,
      "email": email,
      "token": await storage.read(key: 'fcmToken'),
      "platform": await storage.read(key: "DeviceName")
    };
    if (phone.isEmpty) {
      body.remove("phone");
      url = "/auth/login/email/";
    } else {
      body.remove("email");
      url = "/auth/login/phone/";
    }
    try {
      var response = await unAuthDio.post(
        url,
        data: body,
      );
     
      if (response.statusCode == 200) {
        var data = response.data;
        var userData = await UserData.fromJson(data);
        first_name = userData.data.user.firstName;
        last_name = userData.data.user.lastName;
        token = userData.data.token;
        checkEmailVerify = userData.data.user.emailVerified;
        debugPrint("Token Stored: ${token}");
        await storage.write(key: authToken, value: token);
        debugPrint("PhoneNumber Stored: ${phone}");
        await storage.write(key: phoneNumber, value: phone);
        
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        if (e.response?.statusCode == 422) {
          setState(() {
            _isLoading = false;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeDeviceOtp(
                        recipientAddresEmail: email,
                        recipientAddress: phone,
                      )));
          return false;
        } else {
          debugPrint(' Error Error: ${e.response?.data}');
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
