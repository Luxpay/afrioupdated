import 'package:flutter/material.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/accountSettings/my_address.dart';

import '../../utils/hexcolor.dart';
import '../../widgets/lux_buttons.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({Key? key}) : super(key: key);

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () => {Navigator.maybePop(context)},
                        icon: const Icon(Icons.arrow_back_ios_new)),
                    SizedBox(
                      width: SizeConfig.safeBlockHorizontal! * 2,
                    ),
                    const Text(
                      "My Address",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: 80, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 200),
                    Image.asset("assets/location.png"),
                    SizedBox(
                      height: 20,
                    ),
                    Text("The is no address information. "),
                    SizedBox(height: 80),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyAddress()));
                      },
                      child: luxButton(HexColor("#D70A0A"), Colors.white,
                          "Add New Address", width,
                          fontSize: 16),
                    ),
                  ],
                ),
              ))
        ],
      )),
    );
  }
}
