import 'package:flutter/material.dart';
import 'package:luxpay/podos/banks.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';

class TransferInstructions extends StatelessWidget {
  final Bank bank;
  const TransferInstructions({Key? key, required this.bank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: HexColor("#C10505"),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: ()=>{
                            Navigator.pop(context)
                          },
                          icon: const Icon(Icons.arrow_back_ios_new),color: Colors.white,),
                    ],
                  ),
                  Image.asset("${bank.wallpaper}",height: 73.8, width: 123,),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 1.9,
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
