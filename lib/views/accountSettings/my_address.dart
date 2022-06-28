import 'package:flutter/material.dart';
import 'package:luxpay/views/launchPages/welcome_page.dart';
import 'package:luxpay/widgets/lux_buttons.dart';

import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/lux_textfield.dart';
import 'add_address.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({Key? key}) : super(key: key);

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  String state = "";
  String city = "";
  String discrit = "";
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double heightt = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
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
            alignment: Alignment.topCenter,
            child: Container(
                margin: EdgeInsets.only(top: 80, left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Container(
                    height: heightt,
                    child: Column(
                      children: [
                        LuxTextField(
                          hint: "Contact information",
                          // controller: controller,
                          innerHint: "phone",
                        ),
                        SizedBox(height: 20),
                        LuxTextField(
                          hint: "My Address",
                          // controller: controller,
                          innerHint: "first name",
                        ),
                        LuxTextField(
                          hint: "",
                          // controller: controller,
                          innerHint: "last name",
                        ),
                        LuxTextField(
                          hint: "",
                          // controller: controller,
                          innerHint: "Apartment, suite, etc",
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 54,
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                              color: HexColor("#E8E8E8").withOpacity(0.35),
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "State",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: HexColor("#333333")
                                            .withOpacity(0.25),
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: state,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: HexColor("#1E1E1E"),
                                      fontWeight: FontWeight.w300),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      state = newValue!;
                                      print(state);
                                    });
                                  },
                                  items: <String>[
                                    'Enugu',
                                    'Lagos',
                                    'Abuja',
                                    'Kaduna',
                                    'Kanu',
                                    ""
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 54,
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                              color: HexColor("#E8E8E8").withOpacity(0.35),
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "City",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: HexColor("#333333")
                                            .withOpacity(0.25),
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: city,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: HexColor("#1E1E1E"),
                                      fontWeight: FontWeight.w300),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      city = newValue!;
                                      print(city);
                                    });
                                  },
                                  items: <String>[
                                    'Lekki',
                                    'Otigba',
                                    'Alilia',
                                    ""
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 54,
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                              color: HexColor("#E8E8E8").withOpacity(0.35),
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "District ",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: HexColor("#333333")
                                            .withOpacity(0.25),
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: discrit,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: HexColor("#1E1E1E"),
                                      fontWeight: FontWeight.w300),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      discrit = newValue!;
                                      print(discrit);
                                    });
                                  },
                                  items: <String>[
                                    'Winners',
                                    "",
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        LuxTextField(
                          hint: "",
                          // controller: controller,
                          innerHint: "Email(optional)",
                        ),
                        SizedBox(height: 40),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddNewAddress()));
                          },
                          child: luxButton(HexColor("#D70A0A"), Colors.white,
                              "Continue", width,
                              fontSize: 16),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                )),
          )
        ],
      )),
    );
  }
}
