import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/create_pin_page.dart';
import 'package:luxpay/views/authPages/login_view_model.dart';
import 'package:luxpay/views/authPages/reset_password.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';

import '../page_controller.dart';
import 'registration_page.dart';

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
  bool isEmail = false;
  bool _isLoading = false;
  TextEditingController controller = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                  width: SizeConfig.safeBlockHorizontal! * 32,
                ),
                const Text(
                  "Log in",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                  LuxTextField(
                    hint: !isEmail ? "Phone number" : "Email",
                    controller: controller,
                    innerHint: !isEmail ? "090********" : "johndoe@mail.com",
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 2.2,
                  ),
                  //Password
                  LuxTextField(
                    hint: "Password",
                    controller: passwordController,
                    innerHint: "Password",
                    obscureText: true,
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
                        "Log in with ${!isEmail ? 'email' : 'phone number'}",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: HexColor("#144DDE")),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 5.8,
                  ),
                  Center(
                      child: Consumer(
                    builder: (context, ref, _) => InkWell(
                      onTap: () async {
                        _isLoading = true;
                        if (mounted) {
                          setState(() {});
                        }
                        var info = await ref.read(loginProvider).login(
                            controller.text.trim(),
                            passwordController.text.trim(),
                            isEmail);
                        _isLoading = false;
                        if (mounted) {
                          setState(() {});
                        }
                        if (info.data == null) {
                          if (info.navType == NavigationType.home) {
                            Navigator.pushNamedAndRemoveUntil(context,
                                AppPageController.path, (route) => false);
                          } else if (info.navType == NavigationType.setPin) {
                            Navigator.pushNamed(context, CreatePinPage.path);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(info.data!)));
                        }
                      },
                      child: _isLoading
                          ? luxButtonLoading(HexColor("#D70A0A"), width)
                          : luxButton(HexColor("#D70A0A"), Colors.white,
                              "Log in", width,
                              fontSize: 16),
                    ),
                  )),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3.8,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () =>
                          Navigator.of(context).pushNamed(ResetPassword.path),
                      child: Text(
                        "Forgot password ?",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: HexColor("#144DDE")),
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
                    child: Image.asset(
                      "assets/fprint.png",
                      height: 50,
                      width: 50,
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
                                      const RegistrationPage()))
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
    );
  }
}
