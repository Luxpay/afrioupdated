import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/utils/toaster.dart';
import 'package:luxpay/views/paymentMethod/payment_method.dart';
import 'package:luxpay/widgets/airtime/confirmation.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';

class GenericBillPage extends StatefulWidget {
  final String title;
  final String transactionIdHint;
  final String transactionIdInnerHint;
  const GenericBillPage({Key? key, required this.title, required this.transactionIdHint, required this.transactionIdInnerHint}) : super(key: key);

  @override
  _GenericBillPageState createState() => _GenericBillPageState();
}

class _GenericBillPageState extends State<GenericBillPage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController transactionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: ()=>{
                      Navigator.pop(context)
                    },
                    icon: const Icon(Icons.arrow_back_ios_new),color: Colors.black,),
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal! * 2.4,
                  ),
                  Text("${widget.title}",style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600
                  ),),
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    //service provider
                    GestureDetector(
                      onTap: ()=>{
                        LuxToast.show(msg: "msg")
                      },
                      child: LuxTextField(hint: "Select service provider",
                          hintColour: HexColor("#8D9091"),
                          hintWeight: FontWeight.w400,
                          enabled: false,
                          innerHint: "Service provider",
                          maxLength: 11,
                          textInputType: TextInputType.phone,
                          suffixIcon: Icon(Icons.arrow_drop_down_sharp)
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 2.2,
                    ),
                    //option
                    GestureDetector(
                      onTap: ()=>{
                        LuxToast.show(msg: "msg")
                      },
                      child: LuxTextField(hint: "Select an option",
                          hintColour: HexColor("#8D9091"),
                          hintWeight: FontWeight.w400,
                          enabled: false,
                          innerHint: "Select option",
                          maxLength: 11,
                          textInputType: TextInputType.phone,
                          suffixIcon: Icon(Icons.arrow_drop_down_sharp)
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 2.2,
                    ),
                    //transactionId
                    LuxTextField(hint: "${widget.transactionIdHint}",
                      hintColour: HexColor("#8D9091"),
                      hintWeight: FontWeight.w400,
                      controller: transactionController,
                      innerHint: "${widget.transactionIdInnerHint}",
                      textInputType: TextInputType.number,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 2.2,
                    ),
                    //amount
                    LuxTextField(hint: "Enter an amount",
                      hintColour: HexColor("#8D9091"),
                      hintWeight: FontWeight.w400,
                      controller: amountController,
                      innerHint: "Enter amount",
                      textInputType: TextInputType.number,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 4.5,
                    ),
                    InkWell(
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentMethod()))
                        },
                        child: luxButton(HexColor("#D70A0A"),Colors.white,"Continue",325,fontSize: 16,height: 50,radius: 8))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
