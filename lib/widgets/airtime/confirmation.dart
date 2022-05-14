import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/widgets/points.dart';

import '../lux_buttons.dart';

class ConfirmationBottomSheet extends StatelessWidget {
  const ConfirmationBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: 654,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 1.0,
          ),
          Container(
            height: 4,
            width: 36,
            color: HexColor("#AAACAE"),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 1.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Confirmation",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: Container(
                        height: 34,
                        width: 34,
                        decoration: BoxDecoration(
                            color: HexColor("#E8E8E8").withOpacity(.35),
                            borderRadius: BorderRadius.circular(17)),
                        child: Icon(
                          Icons.clear,
                          color: HexColor("#8D9091"),
                          size: 14.4,
                        )))
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 3.7,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                  color: HexColor("#E8E8E8").withOpacity(.35),
                  borderRadius: BorderRadius.circular(8)),
              //
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/rechargeBills/airtime/mtn.png",
                      width: 38,
                      height: 36.54,
                    ),
                    SizedBox(
                      width: SizeConfig.safeBlockHorizontal! * 1.6,
                    ),
                    Text(
                      "AIRTIME/MTN/08123456789",
                      style: TextStyle(
                          color: HexColor("#8D9091"),
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 1.2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              height: 106,
              decoration: BoxDecoration(
                  color: HexColor("#E8E8E8").withOpacity(.35),
                  borderRadius: BorderRadius.circular(8)),
              //
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 1.6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Amount",
                          style: TextStyle(
                              color: HexColor("#8D9091"),
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "N500.00",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Fee",
                          style: TextStyle(
                              color: HexColor("#8D9091"),
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "N0.00",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "VAT",
                          style: TextStyle(
                              color: HexColor("#8D9091"),
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "N0.00",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 1.2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                  color: HexColor("#E8E8E8").withOpacity(.35),
                  borderRadius: BorderRadius.circular(8)),
              //
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Points",
                      style: TextStyle(
                          color: HexColor("#8D9091"),
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () => {
                        showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40.0),
                                topLeft: Radius.circular(40.0)),
                          ),
                          backgroundColor: Colors.white,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return PointsBottomSheet();
                          },
                        )
                      },
                      child: Text(
                        "-N30.00",
                        style: TextStyle(
                            color: HexColor("#144DDE"),
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 2.2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Divider(),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 2.2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 43.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                Text(
                  "N470.00",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 8.1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                luxButton(HexColor("#D70A0A"), Colors.white, "Pay", 260,
                    fontSize: 16, height: 50, radius: 8),
                Center(
                    child: Image.asset(
                  "assets/fprint.png",
                  height: 50,
                  width: 50,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
