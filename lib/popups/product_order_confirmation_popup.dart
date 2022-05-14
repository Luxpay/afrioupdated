import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/rewards/order_confirmation.dart';
import 'package:luxpay/widgets/description_and_details.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/quantity_widget.dart';

class ProductOrderConfirmationPopup extends StatefulWidget {
  const ProductOrderConfirmationPopup({Key? key}) : super(key: key);

  @override
  State<ProductOrderConfirmationPopup> createState() =>
      _ProductOrderConfirmationPopupState();
}

class _ProductOrderConfirmationPopupState
    extends State<ProductOrderConfirmationPopup> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        height: MediaQuery.of(context).size.height * 0.65,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: HexColor("#AAACAE"),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: Navigator.of(context).pop,
                  child: Container(
                    height: 34,
                    width: 34,
                    decoration: BoxDecoration(
                      color: HexColor("#E8E8E8").withOpacity(0.35),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, color: HexColor("#8D9091")),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 4,
            ),
            DescriptionAndDetails(
                description: "To pay:",
                details: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                )),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 4,
            ),
            DescriptionAndDetails(
              description: "Color:",
              details: Text(
                "White",
                style: TextStyle(
                  fontSize: 13,
                  color: HexColor("#1E1E1E"),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 4,
            ),
            DescriptionAndDetails(
              description: "Quantity to redeem:",
              details: Text(
                "Less than 5",
                style: TextStyle(
                  fontSize: 13,
                  color: HexColor("#1E1E1E"),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            const Divider(),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 3,
            ),
            Text(
              "Quantity",
              style: TextStyle(
                fontSize: 13,
                color: HexColor("#8D9091"),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            QuantityWidget(
                amount: count,
                onChange: (v) {
                  if (v >= 0) {
                    setState(() {
                      count = v;
                    });
                  }
                }),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            const Divider(),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const OrderConfirmation(),
                ));
              },
              child: luxButton(HexColor("#D70A0A"), Colors.white, "Continue",
                  double.infinity,
                  height: 50, fontSize: 16),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 6,
            ),
          ],
        ),
      ),
    );
  }
}
