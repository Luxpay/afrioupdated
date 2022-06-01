import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/lux_tag.dart';
import 'package:luxpay/views/authPages/account_create_successful.dart';
import 'package:luxpay/widgets/camera_image.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';
import 'package:luxpay/widgets/touchUp.dart';

class CreateNewPassword2Profile extends StatefulWidget {
  const CreateNewPassword2Profile({Key? key}) : super(key: key);

  @override
  State<CreateNewPassword2Profile> createState() =>
      _CreateNewPassword2ProfileState();
}

class _CreateNewPassword2ProfileState extends State<CreateNewPassword2Profile> {
  TextEditingController controllerFullname = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPaytag = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
                //margin: EdgeInsets.only(left: 30, right: 30),
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
                    IconButton(
                        onPressed: () => {Navigator.maybePop(context)},
                        icon: const Icon(Icons.arrow_back_ios_new)),
                    SizedBox(
                      width: SizeConfig.safeBlockHorizontal! * 18,
                    ),
                    const Text(
                      "Verify your Account",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                  margin: EdgeInsets.only(top: 100, left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("STEP 2 OF 2",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w100)),
                      SizedBox(height: 20),
                      Text(
                        "Provide Prosenal Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 15),
                      Flexible(
                          child: Text(
                              "We will require a few details about you to set up your Luxpay account")),
                    ],
                  )),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 240, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CameraWidget(),
                    SizedBox(height: 20),
                    InkWell(
                        onTap: () {},
                        child: Text(
                          "Tap to take a selfie",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w100),
                        )),
                    LuxTextField(
                      hint: "Full Name",
                      controller: controllerFullname,
                      innerHint: "Enter full name",
                    ),
                    SizedBox(height: 15),
                    LuxTextField(
                      hint: "Email Address",
                      controller: controllerEmail,
                      innerHint: "eg johnson@gmail.com",
                    ),
                    SizedBox(height: 15),
                    LuxTextField(
                      hint: "Luxpay Tag",
                      controller: controllerPaytag,
                      innerHint: "@johnson",
                    ),
                    SizedBox(height: 50),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=> PasswordChangeCongratulation()));
                      },
                      child: luxButton(HexColor("#D70A0A"), Colors.white,
                          "Create Account", 350),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.only(bottom: 188,left:109),
                child: InkWell(
                  onTap: (){
                    _luxTagBottomSheet(context);
                  },
                  child: Image.asset(
                    "assets/exclamation.png",
                  ),
                ),
              ),
            )
          ],
        ))));
  }
}

void _luxTagBottomSheet(context) {
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
        return LuxTag();
      });
}
