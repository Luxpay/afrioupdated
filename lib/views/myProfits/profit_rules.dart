import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';

class ProfitRules extends StatefulWidget {
  const ProfitRules({Key? key}) : super(key: key);

  @override
  _ProfitRulesState createState() => _ProfitRulesState();
}

class _ProfitRulesState extends State<ProfitRules> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: HexColor("#333333").withOpacity(0.3),
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
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
                    "Rules",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      RichText(text: TextSpan()),
                      Text(
                          "My Profits is a risk-free profitable program open to users located in Nigeria. It is a crowdfunding that works on a peer-to-peer basis between our community members."
                          "\n\n\nTo get rewarded on My Profit, you are to register with N2,000 and then refer two users who become your Level 2 partners; they are to refer two others (L3 partners), making the whole matrix seven users total."
                          "\n\nAfter a cycle (6 Level 2&3 partners), you are to resubscribe; by doing this, you never stop earning. Also, My Proft rewards you with juicy incentives like N1,500 spillover from your downlines."
                          "\n\nLook at My Profits as an amazing opportunity within this platform to have a passive income."
                          "\n\n\nWhat is community funding ? While there is no formal definition, community funding can be defined as a group of people who have a common economic interest. That group agrees to actively and consiously pursue that financial interest together to create a sustainable and secure economy for themselves. Empowering Familiy and Community"
                          "\n\n\nWhat This is Not? This is not a business opportunity or network marketing company; this is not gifting - we do not sell anything")
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
