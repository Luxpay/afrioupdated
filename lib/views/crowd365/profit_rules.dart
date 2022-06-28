import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/widgets/touchUp.dart';

class ProfitRules extends StatefulWidget {
  const ProfitRules({Key? key}) : super(key: key);

  @override
  State<ProfitRules> createState() => _ProfitRulesState();
}

class _ProfitRulesState extends State<ProfitRules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: HexColor("#333333").withOpacity(0.3),
                  width: 0.5,
                ),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () => {Navigator.maybePop(context)},
                      icon: const Icon(Icons.arrow_back_ios_new)),
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal! * 4,
                  ),
                  const Text(
                    "Rules",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
                margin: EdgeInsets.only(top: 80, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    crowd360Rules(
                      question: "What is Crowd365 ?",
                      answer:
                          "Crowd365 is a risk-free profitable program open to users located in Nigeria. It is a crowdfunding that works on a peer-to-peer basis between our community members .Is a system that enables members to earn from inviting “Valid Users” to our platform. You can participate on Crowd365 as a single affiliate. Crowd365 is a matrix donation system that gives substantial rewards   ",
                    ),
                    SizedBox(height: 20),
                    crowd360Rules(
                      question: "Who is a valid user ?",
                      answer:
                          "For a user(s) to be considered Valid they have to register on LuxPay fully; this includes entering their BVN and completing their KYC. Doing these would increase their Top-Up wallet balance and secure your Crowd365 referral bonus.",
                    ),
                    SizedBox(height: 20),
                    crowd360Rules(
                      question: "What is community funding ?",
                      answer:
                          "What is community funding ? While there is no formal definition, community funding can be defined as a group of people who have a common economic interest. That group agrees to actively and consiously pursue that financial interest together to create a sustainable and secure economy for themselves. Empowering Familiy and Community What This is Not? This is not a business opportunity or network marketing company; this is not gifting - we do not sell anything",
                    ),
                    SizedBox(height: 20),
                    crowd360Rules(
                        question: "How does EPIC works ?",
                        answer:
                            " 1 You are to register with as low N1,000. 2 branches are then automatically created, which you'll need to fill by inviting people through your invitation link. \n\n2 To attain the N5,000 reward, your 2 invitees will bring 2 more people each, thereby completing the 6 man matrix. \n\n3 After completing the matrix, your N5,000 reward would be eligible for withdrawal. \n\n4 Crowd365 also rewards you with N750 as a spillover for every time any of your downlines completes a cycle. \n\n5 After your matrix, you can resubscribe with N2,000 to complete another cycle; by doing this, you never stop earning. \n\n6 Epic also rewards its members with juicy offers like iPhones, home theaters, laptops, and much more.  "),
                    SizedBox(height: 30),
                  ],
                )),
          ),
        ]),
      )),
    );
  }
}
