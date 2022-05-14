import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';

class ReceiveMoneyFromOthers extends StatefulWidget {
  const ReceiveMoneyFromOthers({Key? key}) : super(key: key);

  @override
  _ReceiveMoneyFromOthersState createState() => _ReceiveMoneyFromOthersState();
}

class _ReceiveMoneyFromOthersState extends State<ReceiveMoneyFromOthers> {
  bool _isLoading = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: ()=>{
                      Navigator.pop(context)
                    },
                    icon: const Icon(Icons.arrow_back_ios_new)),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal! * 2.4,
                ),
                const Text("Request money from others",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                ),)
              ],
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical! * 1.9,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  LuxTextField(
                    hint: "Amount (N)",
                    controller: controller,
                  ),
                  LuxTextField(
                    hint: "Reason for request? (optional)",
                    controller: controller,
                  ),
                  Center(
                      child: InkWell(
                          onTap: () => {
                          },
                          child: _isLoading? luxButtonLoading(HexColor("#D70A0A"),width) :
                          luxButton(HexColor("#D70A0A"),Colors.white,"Send",width,fontSize: 16))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
