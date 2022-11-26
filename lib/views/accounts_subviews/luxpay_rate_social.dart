import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import '../../utils/colors.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/lux_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class LuxPaySocial extends StatefulWidget {
  const LuxPaySocial({Key? key}) : super(key: key);

  @override
  State<LuxPaySocial> createState() => _LuxPaySocialState();
}

class _LuxPaySocialState extends State<LuxPaySocial> {
  _launchURLFacebook() async {
    var url = "https://www.facebook.com/LuxpayTech";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLInstagram() async {
    var url = "https://instagram.com/luxpayapp?igshid=YmMyMTA2M2Y=";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLTwitter() async {
    var url = "https://twitter.com/Luxpayapp";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLTelegram() async {
    var url = "https://t.me/+bYCxPxIzNacwZWQ8";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLPlayStoreRate() async {
    var url =
        "https://play.google.com/store/apps/details?id=luxpay.luxpay.com.luxpay";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
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
                    "LuxPay Socials",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Rate us",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        "LuxPay is concerned about the rating of every customer, and we are always ready to respond quickly to every review"),
                    SizedBox(height: 50),
                    InkWell(
                      onTap: () {
                        _launchURLPlayStoreRate();
                      },
                      child: luxButton(
                          HexColor("#D70A0A"), Colors.white, "Rate Us", width,
                          fontSize: 16),
                    ),
                    SizedBox(height: 50),
                    Text(
                      "Join the Community",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    Text(
                        "Follow us on Social media, let's know what you think"),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: socialButton(
                                account: "Facebook",
                                onTap: () {
                                  _launchURLFacebook();
                                }),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: socialButton(
                                account: "Instagram",
                                onTap: () {
                                  _launchURLInstagram();
                                }),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: socialButton(
                                account: "Telegram",
                                onTap: () {
                                  _launchURLTelegram();
                                }),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: socialButton(
                                account: "Twitter",
                                onTap: () {
                                  _launchURLTwitter();
                                }),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}

class socialButton extends StatelessWidget {
  final VoidCallback onTap;
  final String account;
  const socialButton({Key? key, required this.onTap, required this.account})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: grey2,
            blurRadius: 5.0,
            spreadRadius: 3.0,
            offset: Offset(
              0.0,
              1.0,
            ),
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Center(child: Text(account)),
      ),
    );
  }
}
