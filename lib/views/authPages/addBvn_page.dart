import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/create_account.dart';
import 'package:luxpay/views/authPages/create_new_pin_password_profile.dart';
import 'package:luxpay/views/authPages/dont_know_your_bvn.dart';
import 'package:luxpay/views/authPages/login_page.dart';
import 'package:luxpay/views/page_controller.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/touchUp.dart';

import '../../utils/hexcolor.dart';
import '../../widgets/lux_textfield.dart';
import '../../widgets/util.dart';

class AddBvnPage extends StatefulWidget {
  const AddBvnPage({Key? key}) : super(key: key);

  @override
  State<AddBvnPage> createState() => _AddBvnPageState();
}

class _AddBvnPageState extends State<AddBvnPage> {
  DateTime dateTime = DateTime.now();
  String dateFormate = 'yyyy/MM/dd';
  String? dateOfBirth;
  TextEditingController bvnController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  Future<bool> _willPopCallback() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
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
                      Text("STEP 2 OF 2"),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                            "Date Of Birth",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: HexColor("#1E1E1E")),
                          )),
                          SizedBox(height: 8),
                          Container(
                              height: 55,
                              color: HexColor("#E8E8E8").withOpacity(0.35),
                              child: InkWell(
                                  onTap: () {
                                    Utils.showSheet(
                                      context,
                                      child: buildDatePicker(),
                                      onClicked: () {
                                        final value = DateFormat('yyyy/MM/dd')
                                            .format(dateTime);
                                        // Utils.showSnackBar(
                                        //     context, 'Selected "$value"');
                                        setState(() {
                                          dateOfBirth = value.toString();
                                          debugPrint(
                                              "Date Of Birth : $dateOfBirth");
                                        });

                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Text(
                                          "Pick Date of Birth",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 15),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 20),
                                        child: Text(dateOfBirth ?? dateFormate,
                                            style: TextStyle(fontSize: 18)),
                                      )
                                    ],
                                  ))),
                        ],
                      ),
                      SizedBox(height: 13),
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
                  margin: EdgeInsets.only(top: 650),
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
                                                    AppPageController()));
                                      })
                              ]),
                        ),
                        SizedBox(height: 20)
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

  Widget buildDatePicker() => SizedBox(
        height: 600,
        child: CupertinoDatePicker(
          minimumYear: 1440,
          maximumYear: DateTime.now().year,
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );
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
