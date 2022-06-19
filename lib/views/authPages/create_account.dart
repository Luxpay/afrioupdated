import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/models/errors/error.dart';
import 'package:luxpay/models/userInfoModel.dart';
import 'package:luxpay/utils/functions.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/login_page.dart';
import 'package:luxpay/views/authPages/otp_verification.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/touchUp.dart';
import '../../networking/dio.dart';
import '../../utils/constants.dart';
import '../../utils/hexcolor.dart';
import '../../utils/validators.dart';
import '../../widgets/methods/getDeviceInfo.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  //TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool _isLoading = false;

  String? errors, fcMessageToken;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    setState(() {
      _isLoading = false;
      fcmToken(fcMessageToken);
      getDeviceDetails();
    });
  }

  //TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          //height: 900,
          width: double.infinity,
          // margin: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () => {Navigator.maybePop(context)},
                        icon: const Icon(Icons.arrow_back_ios_new)),
                    SizedBox(
                      width: SizeConfig.safeBlockHorizontal! * 10,
                    ),
                    const Text(
                      "Create New Account",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Container(
                child: Center(
                  child: Image.asset("assets/moreToLife.png"),
                ),
              ),
              SizedBox(
                height: 20,
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
                      controller: phoneController, hint: "Phone Number")),
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
              SizedBox(height: 20),
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
                height: 50,
              ),
              InkWell(
                onTap: () async {
                  var password = passwordController.text.trim();
                  var phoneNumber = phoneController.text.trim();

                  debugPrint(phoneNumber);
                  debugPrint(password);

                  var validators = [
                    Validators.isValidPassword(password),
                    Validators.isValidPhoneNumber(phoneNumber),
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

                  var response = await createUser(password, phoneNumber);
                  setState(() {
                    _isLoading = false;
                  });
                  debugPrint("SignUp: $response");
                  if (response) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OTPVerification(
                                onVerified: () async {},
                                recipientAddress: obscureEmail(phoneNumber))));
                  } else {
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
                              color: Color.fromARGB(255, 7, 139, 248),
                              fontSize: 15),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            })
                    ]),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      )),
    );
  }

  Future<bool> createUser(String password, String phone) async {
    late String token, refToken;
    final storage = new FlutterSecureStorage();
    Map<String, dynamic> body = {
      'password': password,
      "phone": phone,
      'token': await storage.read(key: 'fcmToken'),
      // 'platform': await storage.read(key: 'DeviceName')
    };
    debugPrint('Data : ${body.toString()}');
    try {
      var response = await unAuthDio.post(
        "/api/user/signup/",
        data: body,
      );
      debugPrint('${response.toString()}');
      debugPrint('${response.statusCode}');
      if (response.statusCode == 201) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        var userData = await UserData.fromJson(data);

        token = userData.data.tokens.access;
        refToken = userData.data.tokens.refresh;
        phone = userData.data.user.phone;

        await storage.write(key: authToken, value: token);
        await storage.write(key: refreshToken, value: refToken);

        print("Token Stored: ${await storage.read(key: authToken)}");
        print("refreshToken stored: ${await storage.read(key: refreshToken)}");
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

// void purgeALL() async {
//   Map<String, dynamic> body = {
//     'phone': "08118691299",
//   };
//   try {
//     await unAuthDio.delete(
//       "/api/user/purge/",
//       data: body,
//     );

//     print("Purge successful");
//     return null;
//   } on DioError catch (e) {
//     print(e.message);
//     if (e.response != null) {
//       return e.response?.data['message'] ?? "An error occurred";
//     } else {
//       return;
//     }
//   } catch (e) {
//     return;
//   } finally {
//     SharedPreferences.getInstance().then((pref) async {
//       await pref.clear();
//     });
//   }
// }
