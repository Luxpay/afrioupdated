import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';

class PointsBottomSheet extends StatefulWidget {
  const PointsBottomSheet({Key? key}) : super(key: key);

  @override
  _PointsBottomSheetState createState() => _PointsBottomSheetState();
}

class _PointsBottomSheetState extends State<PointsBottomSheet> {
  int groupValue = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 1.0,
          ),
          //handle
          Container(
            height: 4,
            width: 36,
            color: HexColor("#AAACAE"),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 1.5,
          ),
          //close and title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Points",
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
            height: SizeConfig.safeBlockVertical! * 3,
          ),
          //use points radio
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 33.25),
            child: Row(
              children: [
                Image.asset("assets/rechargeBills/airtime/points-money.png"),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal! * 1,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Use 5 points as N30.00",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      Radio(
                        value: 0,
                        groupValue: groupValue,
                        onChanged: (T) {
                          setState(() {
                            groupValue = 0;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 1.7,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Divider(),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 1.7,
          ),
          //save points radio
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 33.25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Save for later",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
                Radio(
                  value: 1,
                  groupValue: groupValue,
                  onChanged: (T) {
                    setState(() {
                      groupValue = 1;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 1.7,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
