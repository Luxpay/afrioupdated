import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/create_account.dart';
import 'package:luxpay/views/authPages/create_new_pin_password_profile.dart';
import 'package:luxpay/views/authPages/dont_know_your_bvn.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/touchUp.dart';

import '../../utils/hexcolor.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({Key? key}) : super(key: key);

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  TextEditingController bvnController = TextEditingController();
  Future<bool> _willPopCallback() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateAccount()));
    return true; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 80,
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
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal! * 28,
                        ),
                        const Text(
                          "Verify your Account",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 100, left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("STEP 1 OF 2"),
                      SizedBox(height: 20),
                      Text(
                        "Link your BVN",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 15),
                      Container(
                        child: Row(
                          children: [
                            Flexible(
                                child: Text(
                                    "Enter your 11 digits BVN number to unlock various features on the Luxpay account")),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      PasswordTextField(hint: "BVN", controller: bvnController),
                      SizedBox(height: 20),
                      Container(
                        child: Row(
                          children: [
                            Flexible(
                                child: Text(
                                    "* Your BVN is confidential and won’t be disclosed to any third-party")),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        child: Row(
                          children: [
                            Flexible(
                                child:
                                    Text("* This is a one time verification")),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      InkWell(
                          onTap: () {
                            //Navigator.push(context,MaterialPageRoute(builder: (context)=> PasswordChangeConfirm()));
                            // Navigator.push(context,MaterialPageRoute(builder: (context)=> OTPVerification()));
                          },
                          child: luxButton(HexColor("#D70A0A"), Colors.white,
                              "Submit", 350)),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 550),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        InkWell(
                            onTap: () {
                              _dontKnowUrBVNBottomSheet(context);
                            },
                            child: Text(
                              "Don't know your BVN ?",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w100),
                            )),
                        SizedBox(height: 60),
                        RichText(
                          text: TextSpan(
                              text: 'Not Ready ?',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' Skip for ',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 7, 139, 248),
                                        fontSize: 15),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CreateNewPassword2Profile()));
                                      })
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

void _dontKnowUrBVNBottomSheet(context) {
  showModalBottomSheet<dynamic>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return DontKnowUrBVN();
      });
}
