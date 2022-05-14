import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/reused_widgets.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/widgets/description_and_details.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/quantity_widget.dart';

class OrderConfirmation extends StatefulWidget {
  const OrderConfirmation({Key? key}) : super(key: key);

  @override
  _OrderConfirmationState createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Order Confirmation",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        leading: GestureDetector(
          child: const Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 35,
          ),
          onTap: Navigator.of(context).pop,
        ),
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 0.5,
          ),
          buildDivider,
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: 73,
                      width: 77,
                      decoration: BoxDecoration(
                        color: HexColor("#ECECEC"),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                      ),
                    ),
                    Container(
                      height: 10,
                      width: 77,
                      decoration: BoxDecoration(
                        color: HexColor("#144DDE"),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "White",
                          style: TextStyle(color: Colors.white, fontSize: 6),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 34,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Apple Airpod Pro 3",
                      style: TextStyle(
                        color: HexColor("#1E1E1E"),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Row(
                      children: [
                        Text(
                          "N95,000",
                          style: TextStyle(
                            color: HexColor("#D70A0A"),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "+",
                          style: TextStyle(
                            color: HexColor("#1E1E1E"),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "450 pts",
                          style: TextStyle(
                            color: HexColor("#1E1E1E"),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Text(
                      "N128,000",
                      style: TextStyle(
                        color: HexColor("#8D9091"),
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 2,
          ),
          // address
          buildDivider,
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Address",
                      style: TextStyle(
                        color: HexColor("#1E1E1E"),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 1.5,
                    ),
                    Text(
                      "23, Victoria Island",
                      style: TextStyle(
                        color: HexColor("#8D9091"),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 1.5,
                    ),
                    Text(
                      "L.G.A",
                      style: TextStyle(
                        color: HexColor("#8D9091"),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 1.5,
                    ),
                    Text(
                      "P.O Box",
                      style: TextStyle(
                        color: HexColor("#8D9091"),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 1.5,
                    ),
                    Text(
                      "Phone number",
                      style: TextStyle(
                        color: HexColor("#8D9091"),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "CHANGE",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: HexColor("#144DDE"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 2,
          ),
          // Quantity controller
          buildDivider,
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Quantity",
              style: TextStyle(
                fontSize: 13,
                color: HexColor("#8D9091"),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: QuantityWidget(
                amount: count,
                onChange: (v) {
                  if (v >= 0) {
                    setState(() {
                      count = v;
                    });
                  }
                }),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 3,
          ),
          buildDivider,
          // summary
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Order Summary ( 2 item )",
              style: TextStyle(
                color: HexColor("#1E1E1E"),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 1.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: DescriptionAndDetails(
              description: "Subtotal:",
              fontSize: 14,
              details: Row(
                children: [
                  Text(
                    "N95,000",
                    style: TextStyle(
                      color: HexColor("#8D9091"),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "+",
                    style: TextStyle(
                      color: HexColor("#1E1E1E"),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "450 pts",
                    style: TextStyle(
                      color: HexColor("#8D9091"),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: DescriptionAndDetails(
              description: "Shipping fee:",
              fontSize: 14,
              details: Text(
                "N0.00",
                style: TextStyle(
                  fontSize: 14,
                  color: HexColor("#1E1E1E"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: DescriptionAndDetails(
              description: "Points:",
              fontSize: 14,
              details: Text(
                "-N202.80",
                style: TextStyle(
                  fontSize: 14,
                  color: HexColor("#144DDE"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: DescriptionAndDetails(
              description: "Total",
              fontSize: 14,
              black: true,
              details: Row(
                children: [
                  Text(
                    "N95,000",
                    style: TextStyle(
                      color: HexColor("#1E1E1E"),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "+",
                    style: TextStyle(
                      color: HexColor("#1E1E1E"),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "450 pts",
                    style: TextStyle(
                      color: HexColor("#1E1E1E"),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const OrderConfirmation(),
                ));
              },
              child: luxButton(HexColor("#D70A0A"), Colors.white, "Continue",
                  double.infinity,
                  height: 50, fontSize: 16),
            ),
          ),
        ],
      )),
    );
  }
}
