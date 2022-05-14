import 'package:flutter/material.dart';
import 'package:luxpay/podos/banks.dart';
import 'package:luxpay/utils/formatter.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/widgets/points.dart';
import 'package:url_launcher/url_launcher.dart';

import '../lux_buttons.dart';

class ProcessingBottomSheet extends StatelessWidget {
  final Bank bank;
  final double amount;
  const ProcessingBottomSheet(
      {Key? key, required this.bank, required this.amount})
      : super(key: key);

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
                  "Processing",
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
            height: SizeConfig.safeBlockVertical! * 2.8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Amount ( N )",
                    style: TextStyle(fontSize: 13, color: HexColor("#8D9091")),
                  ),
                ),
                Container(
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
                          "N ${LuxFormatter.doubleAsCurrency(amount)}",
                          style: TextStyle(
                              color: HexColor("#8D9091"),
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 2,
          ),
          //Select a funding source
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Select a funding source",
                    style: TextStyle(fontSize: 13, color: HexColor("#8D9091")),
                  ),
                ),
                InkWell(
                  onTap: () => {Navigator.pop(context)},
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
                            "${bank.name} ${bank.ussdCode}",
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
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: HexColor("#8D9091"),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 4.2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Text(
              "Dial the code below and follow all onscreen instructions to credit your account. ",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: HexColor("#8D9091"),
                fontSize: 13,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25, top: 5),
            child: SizedBox(
              height: 56,
              width: MediaQuery.of(context).size.width,
              child: Card(
                shape: ContinuousRectangleBorder(),
                elevation: 0.5,
                child: Center(
                  child: Text(
                    "${bank.ussdCode.replaceAll("#", "")}*${LuxFormatter.doubleAsCurrency(amount).replaceAll(",", "")}*7010589059#",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: HexColor("#1E1E1E"),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 8.1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: InkWell(
                onTap: () => {
                      canLaunch(
                              "${bank.ussdCode.replaceAll("#", "")}*${LuxFormatter.doubleAsCurrency(amount).replaceAll(",", "")}*7010589059#")
                          .then((value) => {
                                print("can launch $value"),
                              })
                          .catchError((e) => {print(e)}),
                      launch(
                          "tel://${bank.ussdCode.replaceAll("#", "")}*${LuxFormatter.doubleAsCurrency(amount).replaceAll(",", "")}*7010589059#")
                    },
                child: luxButton(
                    HexColor("#D70A0A"), Colors.white, "Dial code", 325,
                    fontSize: 16, height: 50, radius: 8)),
          ),
        ],
      ),
    );
  }
}
