import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/password_change_congratulation.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/touchUp.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({Key? key}) : super(key: key);

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  var controllerPassword = TextEditingController();
  var controllerConfirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: HexColor("#333333").withOpacity(0.3),
                  width: 0.5,
                ),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () => {Navigator.maybePop(context)},
                      icon: const Icon(Icons.arrow_back_ios_new)),
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal! * 23,
                  ),
                  const Text(
                    "New Password",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: SizeConfig.safeBlockVertical! * 4,
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Enter Your Mobile Number",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 1,
                  ),
                  Text(
                    "Create a new password. Password should be different from previous..",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3,
                  ),
                  PasswordTextField(
                      hint: "New Password", controller: controllerPassword),
                  SizedBox(height: 40),
                  PasswordTextField(
                      hint: "Confirm Password",
                      controller: controllerConfirmPassword),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 8,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PasswordChangeCongratulation()));
                    },
                    child: luxButton(HexColor("#D70A0A"), Colors.white,
                        "Confirm", double.infinity,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
