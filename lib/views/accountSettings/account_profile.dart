import 'package:flutter/material.dart';
import 'package:luxpay/views/accountSettings/kyc.dart';

import '../../utils/colors.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/lux_buttons.dart';
import 'edit_profile.dart';

class AccountProfile extends StatefulWidget {
  const AccountProfile({Key? key}) : super(key: key);

  @override
  State<AccountProfile> createState() => _AccountProfileState();
}

class _AccountProfileState extends State<AccountProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => {Navigator.pop(context)},
                          icon: const Icon(Icons.arrow_back_ios_new)),
                      const Text(
                        "Profile Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(
                  top: 90,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: grey4,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                            height: 30,
                            width: 130,
                            decoration: BoxDecoration(
                                color: grey1,
                                border: Border.all(color: grey5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(child: Text("Level 1"))),
                        SizedBox(height: 10),
                        Text(
                          "Full Name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "luxpay@gmail.com",
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "+234703040404",
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(height: 8),
                        button(
                          title: "Edit details",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile()));
                          },
                          active: true,
                        ),
                        SizedBox(height: 15),
                        kyc_card()
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(left: 20, top: 700, right: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => KYCPage()));
                    },
                    child: luxButton(HexColor("#D70A0A"), Colors.white,
                        "Upgrade KYC", double.infinity,
                        fontSize: 16),
                  ),
                )),
          ],
        ),
      )),
    );
  }

  Widget button(
      {required String title, VoidCallback? onTap, bool active = true}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        width: SizeConfig.blockSizeHorizontal! * 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: HexColor("#D70A0A"),
          boxShadow: [
            BoxShadow(
              color: grey3.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: active ? Colors.white : Colors.black,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class kyc_card extends StatelessWidget {
  const kyc_card({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(
          milliseconds: 200,
        ),
        height: 280,
        width: MediaQuery.of(context).size.width - 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: HexColor("#D70A0A")),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100.withOpacity(0.4),
              offset: Offset(3, 3),
            )
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              "Level 1",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
            SizedBox(height: 5),
            Text(
              "Current Limit",
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Single transaction limit",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "N20,000.00",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Daily transaction limit",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "N50,000.00",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Cumulative transaction\nlimit",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "N400,000.00",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Maximum account\nbalance",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "N50,000.00",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Benefits",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "Domestic transactions",
                      style: TextStyle(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
