import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/login_page.dart';
import 'package:luxpay/views/authPages/otp_verification.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';
import 'package:luxpay/widgets/touchUp.dart';

import '../../utils/hexcolor.dart';


class CreateAccount extends StatefulWidget {
  const CreateAccount({ Key? key }) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
 TextEditingController? phoneNumberController;
 TextEditingController? passwordController;
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      body: SafeArea(
        child: Container(
           margin: EdgeInsets.only(left: 30,right: 30),
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Container(child: Center(child: Image.asset("assets/moreToLife.png"),),),
              SizedBox(height: 20,),
              Flexible(child:Text("Please enter your registered phone number and a secured password that include the following criterias to proceed")),
              SizedBox(height: 20,),
              LuxpayTextFieldNumber(hint: "Phone Number", controller: phoneNumberController),
              SizedBox(height: 20,),
              PassWordtextField(hint: "Password",controller: passwordController),
              SizedBox(height: 10),
              Flexible(child:Text("* Your password must be 8 or more characters long & contain a mix of upper & lower case letters, numbers & symbols.",style: TextStyle(color:Colors.grey),)),
              SizedBox(height: 70,),
              InkWell(
                onTap: (){
                  
                 // Navigator.push(context,MaterialPageRoute(builder: (context)=> OTPVerification()));
                },
                child: luxButton(HexColor("#D70A0A"), Colors.white,"Continue", 350)),
                 SizedBox(height: 70,),
  RichText(
        text: TextSpan(
            text: 'Don\'t have an account?',
            style: TextStyle(
                color: Colors.black, fontSize: 12),
            children: <TextSpan>[
              TextSpan(text: ' Log in',
                  style: TextStyle(
                      color: Colors.blue, fontSize: 15),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> LoginPage()));
                    }
              )
            ]
        ),
      ), 

      ],),
        )),
    );
  }
}