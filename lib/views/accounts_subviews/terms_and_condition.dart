import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';

class TermsAndConditions extends StatelessWidget {
  static const String path = "/terms_and_conditions";
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () => {Navigator.maybePop(context)},
                      icon: const Icon(Icons.arrow_back_ios_new)),
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal! * 5,
                  ),
                  const Text(
                    "Terms And Condition",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 25,
                        left: 26,
                        right: 26,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Terms of use",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            """LUXPAY LIMITED, its parent, subsidiaries, successors,
assignees and affiliates ("Luxpay", 'we","our", or"us")
provide access to and use of Luxpay. co, a website
owned and operated by Luxpay, as well as any and all
other websites, mobile optimised sites, mobile
applications, subdomains owned, operated or
controlled by Luxpay (the"Website","LuxPay App"),
together with the content, software, mobile services, financial products and functionality offered on or
through the Website and the Luxpay App (collectively, the "Services").
These Terms of Use ( the Terms') as well as any and all
specific terms and conditions for each of our products
and services, as amended from time to time, represent
an agreement between you (you","your' or collectively
with other users,"Users") and Luxpay, and governs your use and access to our Services.""",
                            style: TextStyle(
                              color: HexColor("#8D9091"),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            """
PLEASE READ THESE TERMS CAREFULLY TO ENSURE THAT YOU UNDERSTAND EACH PROVISION. BY DOWNLOADING, REGISTERING, SIGNING INTO, ACCESSING, BROWSING, OR OTHERWISE USING THE SERVICES, WHETHER AS A GUEST OR REGISTERED USER, OR OTHERWISE ACCEPTING THESE TERMS, YOU ARE SIGNIFYING THAT YOU HAVE READ AND UNDERSTOOD THE TERMS, AND AGREE TO BE BOUND BY THESE TERMS,
OUR PRIVACY POLICY AND ALL FUTURE MODIFICATIONS TO THESE TERMS, AS WELL AS TO
THE COLLECTION AND USE OF YOUR INFORMATION
AS SET OUT IN OUR PRIVACY POLICY."""
                                .replaceAll("\n", " "),
                            style: TextStyle(
                              color: HexColor("#8D9091"),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
