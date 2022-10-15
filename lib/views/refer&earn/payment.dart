import 'package:flutter/material.dart';
import 'package:luxpay/views/refer&earn/successfull_payment.dart';
import 'package:luxpay/widgets/lux_buttons.dart';

import '../../utils/colors.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';

class SelectPaymentMethod extends StatefulWidget {
  const SelectPaymentMethod({Key? key}) : super(key: key);

  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  bool selectPackageCheck = false;
  int selectedIndex = -1;
  List<String> walletInfo = ["N,3000,000", 'N,3000,000"'];
  bool checkdata = false;

  //bool _isLoading = false;
  var errors;
  // String? price;
  // String? name;

  List<String> images = [
    "assets/paymentMethod/mastercard-logo.png",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 16, top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () => {Navigator.pop(context)},
                              icon: const Icon(Icons.arrow_back_ios_new),
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: SizeConfig.safeBlockHorizontal! * 2.4,
                            ),
                            const Text(
                              "Payment Method",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                        "Select payment",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      )),
                  Container(
                    height: MediaQuery.of(context).size.height - 600,
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          //var item = items[index];
                          return GestureDetector(
                              onTap: () => setState(() {
                                    selectedIndex = index;
                                    selectPackageCheck = true;
                                  }),
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20, top: 20, right: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: HexColor("#E8E8E8")
                                            .withOpacity(.35),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18.0, top: 13, bottom: 13),
                                          child: Image.asset(
                                            images[0],
                                            height: 24.67,
                                            width: 37,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "5234",
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              "#1E1E1E"),
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(
                                                      width: SizeConfig
                                                              .safeBlockVertical! *
                                                          1.2,
                                                    ),
                                                    Text(
                                                      "****",
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              "#8D9091"),
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(
                                                      width: SizeConfig
                                                              .safeBlockVertical! *
                                                          1.2,
                                                    ),
                                                    Text(
                                                      "****",
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              "#8D9091"),
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(
                                                      width: SizeConfig
                                                              .safeBlockVertical! *
                                                          1.2,
                                                    ),
                                                    Text(
                                                      "1357",
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              "#1E1E1E"),
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    320,
                                              ),
                                              Container(
                                                  child: selectedIndex == index
                                                      ? Image.asset(
                                                          'assets/selected_radio.png',
                                                          color: Colors.red,
                                                        )
                                                      : Image.asset(
                                                          'assets/unselect_radio.png',
                                                          color: Colors.grey)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )));
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: SizeConfig.blockSizeVertical! * 2,
                            ),
                        itemCount: walletInfo.length),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Text(
                        "Add a new Card",
                      )),
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                    decoration: BoxDecoration(
                        color: grey1, borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "N 1000",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(height: 3),
                          Text('Refer And Earn')
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin:
                  EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 250),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentSuccessfull()));
                        },
                        child: luxButton(HexColor("#D70A0A"), Colors.white,
                            "Pay", double.infinity,
                            fontSize: 16, height: 50, radius: 8)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      child: Image.asset(
                    "assets/fprint.png",
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
