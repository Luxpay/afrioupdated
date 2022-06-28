import 'package:flutter/material.dart';
import 'package:luxpay/views/refer&earn/payment.dart';

import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/lux_buttons.dart';
import '../../widgets/lux_textfield.dart';

class ReferrerDebitCard extends StatefulWidget {
  const ReferrerDebitCard({Key? key}) : super(key: key);

  @override
  State<ReferrerDebitCard> createState() => _ReferrerDebitCardState();
}

class _ReferrerDebitCardState extends State<ReferrerDebitCard> {
  bool isChecked = false;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SafeArea(
              child: Stack(children: [
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
                            "Debit Card",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 90, left: 20, right: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Provide further information; as they\nappear on the card."),
                          SizedBox(height: 20),
                          LuxTextField(
                            hint: "Card Number",
                            // controller: controller,
                            innerHint: "Enter card number",
                          ),
                          SizedBox(height: 20),
                          LuxTextField(
                            hint: "Card Holder Name",
                            // controller: controller,
                            innerHint: "Enter card Holder name",
                          ),
                          SizedBox(height: 40),
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: LuxTextField(
                                    hint: "Expiriy Date",
                                    // controller: controller,
                                    innerHint: "MM/YY",
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Expanded(
                                  child: LuxTextField(
                                    hint: "CCV",
                                    // controller: controller,
                                    innerHint: "CCV",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Save card Details"),
                                Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      getColor),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 150, left: 20, right: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectPaymentMethod()));
                      },
                      child: luxButton(
                        HexColor("#D70A0A"),
                        Colors.white,
                        "Add Card",
                        MediaQuery.of(context).size.width,
                        fontSize: 16,
                        height: 50,
                        radius: 8,
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ));
  }
}
