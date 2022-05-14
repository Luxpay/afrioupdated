import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/widgets/payment/wallet.dart';

class DebitCard extends StatefulWidget {
  const DebitCard({Key? key}) : super(key: key);

  @override
  _DebitCardState createState() => _DebitCardState();
}

class _DebitCardState extends State<DebitCard> {
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
                  const Text("Debit Card",style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600
                  ),),
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 1.6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 3.3,
                    ),
                    Wallet(),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 3.5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: HexColor("#E8E8E8").withOpacity(.35),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0,top: 13,bottom: 13),
                            child: Image.asset("assets/paymentMethod/mastercard-logo.png",height: 24.67, width: 37,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("5234",style: TextStyle(
                                    color: HexColor("#1E1E1E"),
                                    fontSize: 16
                                ),),
                                SizedBox(
                                  width: SizeConfig.safeBlockVertical! * 1.2,
                                ),
                                Text("****",style: TextStyle(
                                    color: HexColor("#8D9091"),
                                    fontSize: 16
                                ),),
                                SizedBox(
                                  width: SizeConfig.safeBlockVertical! * 1.2,
                                ),
                                Text("****",style: TextStyle(
                                    color: HexColor("#8D9091"),
                                    fontSize: 16
                                ),),
                                SizedBox(
                                  width: SizeConfig.safeBlockVertical! * 1.2,
                                ),
                                Text("1357",style: TextStyle(
                                    color: HexColor("#1E1E1E"),
                                    fontSize: 16
                                ),),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
