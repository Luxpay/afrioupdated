import 'package:flutter/material.dart';
import 'package:luxpay/views/authPages/create_new_pin_password.dart';

class PasswordChangeConfirm extends StatefulWidget {
  const PasswordChangeConfirm({ Key? key }) : super(key: key);

  @override
  State<PasswordChangeConfirm> createState() => _PasswordChangeConfirmState();
}

class _PasswordChangeConfirmState extends State<PasswordChangeConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      body:Center(child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        InkWell(
          
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=> CreateNewPassword()));
          },
          child: Image.asset("assets/successIcon.png",scale: 3,)),
        Text("Successful !", style:TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.black)),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: Text("Your transaction pin has successfully been created",style: TextStyle(color:Colors.grey))),
            ],
          ),
        )
      ],))
    );
  }
}