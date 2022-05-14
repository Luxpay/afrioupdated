import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/reused_widgets.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/rewards/product_page.dart';
import 'package:luxpay/widgets/lux_buttons.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({Key? key}) : super(key: key);

  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Rewards",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 7,
            ),
            // Invitation card
            Container(
              height: 110,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.fromLTRB(22, 14, 22, 22),
              decoration: BoxDecoration(
                color: HexColor("#771313"),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Invite & earn".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  RichText(
                    text: const TextSpan(
                        text: "Refer a friend and earn up to \n",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          height: 1.7,
                        ),
                        children: [
                          TextSpan(
                            text: "N620 ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: "per referral daily.",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          )
                        ]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            buildDivider,
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            // checkin
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: RichText(
                text: TextSpan(
                    text: "Get coupons or points : ",
                    style: TextStyle(
                      fontSize: 14,
                      color: HexColor("#1E1E1E"),
                      fontWeight: FontWeight.w600,
                    ),
                    children: const [
                      TextSpan(
                        text: "Check in for 7 days !",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      )
                    ]),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GridView(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 6 / 5,
                    mainAxisSpacing: SizeConfig.blockSizeHorizontal! * 2,
                    crossAxisSpacing: SizeConfig.blockSizeHorizontal! * 2),
                children: [
                  buildCheckinCard("1", "+5P", ""),
                  buildCheckinCard("2", "N10", ""),
                  buildCheckinCard("3", "+10P", ""),
                  buildCheckinCard("4", "+15P", ""),
                  buildCheckinCard("5", "N15", ""),
                  buildCheckinCard("6", "N20", ""),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 1,
            ),
            buildCheckinCardSpan("7", "+25P", "N30", "", ""),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: luxButton(HexColor("#D70A0A"), Colors.white, "Check in",
                  double.infinity,
                  height: 50, fontSize: 16),
            ),
            // Earn points
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            buildDivider,
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: HexColor("#E4E9F2"),
              ),
              itemBuilder: (context, index) => buildEarnings(
                "",
                "+10 points",
                "Earn points",
                Row(
                  children: const [
                    Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
            ),
            // redeem gifts
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            buildDivider,
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Gifts to redeem",
                    style: TextStyle(
                      color: HexColor("#1E1E1E"),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "More",
                    style: TextStyle(
                      color: HexColor("#8D9091"),
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 3,
            ),
            Container(
              color: HexColor("#FBFBFB"),
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12),
              child: GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 5 / 7,
                    mainAxisSpacing: SizeConfig.blockSizeHorizontal! * 2,
                    crossAxisSpacing: SizeConfig.blockSizeHorizontal! * 2),
                children: [
                  buildCartItem("Apple Airpod Pro 3", "N95,100", "N128,400",
                      "80 pts", ""),
                  buildCartItem("Apple Airpod Pro 3", "N95,100", "N128,400",
                      "80 pts", ""),
                  buildCartItem("Apple Airpod Pro 3", "N95,100", "N128,400",
                      "80 pts", ""),
                  buildCartItem("Apple Airpod Pro 3", "N95,100", "N128,400",
                      "80 pts", ""),
                  buildCartItem("Apple Airpod Pro 3", "N95,100", "N128,400",
                      "80 pts", ""),
                  buildCartItem("Apple Airpod Pro 3", "N95,100", "N128,400",
                      "80 pts", ""),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 6,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCartItem(String name, String amount, String originalAmount,
      String points, String image) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ProductPage(),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(13, 13, 13, 21),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(),
            ),
            Text(
              name,
              style: TextStyle(
                color: HexColor("#8D9091"),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              amount,
              style: TextStyle(
                color: HexColor("#D70A0A"),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  points,
                  style: TextStyle(
                    color: HexColor("#1E1E1E"),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              originalAmount,
              style: TextStyle(
                color: HexColor("#8D9091"),
                fontSize: 14,
                decoration: TextDecoration.lineThrough,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEarnings(
      String image, String title, String buttonText, Widget subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: HexColor("#1E1E1E"),
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    subtitle,
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
              Container(
                height: 37,
                width: SizeConfig.blockSizeHorizontal! * 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.green.shade900, Colors.green],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  buttonText,
                  style: const TextStyle(fontSize: 13, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCheckinCardSpan(
      String day, String value, String value2, String image, String image2) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25.0),
      padding: const EdgeInsets.symmetric(vertical: 23),
      height: SizeConfig.blockSizeVertical! * 9,
      width: double.infinity,
      decoration: BoxDecoration(
        color: HexColor("#E8E8E8").withOpacity(0.35),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: HexColor("#CCCCCC")),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "Day $day",
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: HexColor("#CCCCCC")),
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(
                    value2,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCheckinCard(String day, String value, String image) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: HexColor("#E8E8E8").withOpacity(0.35),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Day $day",
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
