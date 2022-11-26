import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/networking/DioServices/dio_client.dart';
import 'package:luxpay/utils/functions.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/login_page.dart';
import 'package:luxpay/views/authPages/otp_verification.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/touchUp.dart';
import '../../models/errors/authError.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/constants.dart';
import '../../utils/hexcolor.dart';
import '../../utils/validators.dart';
import '../../widgets/lux_textfield.dart';
import '../../widgets/methods/getDeviceInfo.dart';
import '../../widgets/navigate_route.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  //TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool _isLoading = false;

  String? errors, fcMessageToken;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    fcmToken();
    getDeviceDetails();
    setState(() {
      _isLoading = false;
    });
  }

  //TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Container(
            //height: 900,
            width: double.infinity,
            // margin: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // IconButton(
                      //     onPressed: () => {Navigator.maybePop(context)},
                      //     icon: const Icon(Icons.arrow_back_ios_new)),
                      // SizedBox(
                      //   width: SizeConfig.safeBlockHorizontal! * 10,
                      // ),
                      const Text(
                        "Create New Account",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Center(
                    child: Image.asset(
                      "assets/moreToLife.png",
                      scale: 1.6,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: Container(
                    child: Row(
                      children: [
                        Flexible(
                            child: Text(
                                "Please enter your registered phone number and a secured password that include the following criterias to proceed")),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 2.2,
                ),
                Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: PhoneNumberField(
                        boaderColor: HexColor("#D70A0A"),
                        controller: phoneController,
                        innerHint: "Phone Number")),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 2.2,
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      LuxTextField(
                        hint: "UserName",
                        controller: controllerUsername,
                        innerHint: "eg johnson",
                        // prefixIcon: Icon(Icons.person),
                        boaderColor: HexColor("#D70A0A"),
                      ),
                      Text(
                        "* username can container only letters and underscores minimum of two letters",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 2.2,
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: LuxTextField(
                    hint: "Email",
                    controller: controllerEmail,
                    innerHint: "eg mike@gmail.com",
                    // prefixIcon: Icon(Icons.person),
                    boaderColor: HexColor("#D70A0A"),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 2.2,
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: PasswordTextField(
                    hint: "Password",
                    controller: passwordController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: Container(
                    child: Row(
                      children: [
                        Flexible(
                            child: Text(
                          "* Your password must be 8 or more characters long & contain a mix of upper & lower case letters, numbers & symbols.",
                          style: TextStyle(color: Colors.grey),
                        )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    String password = passwordController.text.trim();
                    String phoneNumber = phoneController.text.trim();
                    String username = controllerUsername.text.trim();
                    String email = controllerEmail.text.trim();

                    debugPrint(phoneNumber);
                    debugPrint(password);

                    var validators = [
                      Validators.forEmptyField(username),
                      Validators.isValidPassword(password),
                      Validators.isValidPhoneNumber(phoneNumber),
                      Validators.isValidEmail(email),
                    ];
                    if (validators.any((element) => element != null)) {
                      setState(() {
                        _isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(validators
                                  .firstWhere((element) => element != null) ??
                              "")));
                      return;
                    }
                    setState(() {
                      _isLoading = true;
                    });

                    var response = await createUser(
                        password, phoneNumber, username, email);

                    debugPrint("SignUp: $response");
                    if (response) {
                      setState(() {
                        _isLoading = false;
                      });

                      Navigator.push(
                          context,
                          SizeTransition4(OTPVerification(
                              recipientAddressEmail: obscureEmail(email),
                              recipientAddress: obscureEmail(phoneNumber))));
                    } else {
                      setState(() {
                        _isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(errors ?? "something went wrong")));
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: _isLoading
                        ? luxButtonLoading(HexColor("#D70A0A"), width)
                        : luxButton(HexColor("#D70A0A"), Colors.white,
                            "Create Account", width,
                            fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                RichText(
                  text: TextSpan(
                      text: 'Already have an account?',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Log in',
                            style: TextStyle(
                                color: HexColor("#D70A0A"), fontSize: 15),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context, SizeTransition4(LoginPage()));
                              })
                      ]),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<bool> createUser(
      String password, String phone, String username, String email) async {
    final storage = new FlutterSecureStorage();

    Map<String, dynamic> body = {
      'password': password,
      "phone": phone,
      'username': username,
      'email': email
      //'token': await storage.read(key: 'fcmToken'),
      //'platform': await storage.read(key: 'DeviceName')
    };
    try {
      var response = await unAuthDio.post(
        "/auth/signup/",
        data: body,
      );

      if (response.statusCode == 201) {
        // var data = response.data;
        // var userData = await Signup.fromJson(data);
        // phone = userData.data.phone;
        // debugPrint("PhoneNumber Stored: ${phone}");
        await storage.write(key: phoneNumber, value: phone);
        return true;
      } else {
        setState(() {
          _isLoading = false;
        });
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        setState(() {
          _isLoading = false;
        });
        handleStatusCode(e.response?.statusCode, context);
        debugPrint(' Error Error: ${e.response?.data}');
        var errorData = e.response?.data;
        debugPrint(' Error Error: ${errorData}');
        var errorMessage = await AuthError.fromJson(errorData);
        errors = errorMessage.message;

        return false;
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
