import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/widgets/touchUp.dart';
import 'package:flutter_share/flutter_share.dart';
import '../../utils/colors.dart';
import '../../widgets/lux_buttons.dart';

class Crowd365ReferralCode extends StatefulWidget {
  const Crowd365ReferralCode({Key? key}) : super(key: key);

  @override
  State<Crowd365ReferralCode> createState() => _Crowd365ReferralCodeState();
}

class _Crowd365ReferralCodeState extends State<Crowd365ReferralCode> {
  String copyText = "1 N Q Y T Y W 2 V C";

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height - 500,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      height: 6,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: grey4,
                      ),
                      margin: const EdgeInsets.only(top: 10)),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        margin: EdgeInsets.only(right: 20, top: 20),
                        child: CircleButton(
                            onTap: () => Navigator.pop(context),
                            iconData: Icons.close))),
                Container(
                  margin: EdgeInsets.only(top: 60, right: 40, left: 40),
                  child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text("Referral Code"),
                                ),
                                SizedBox(height: 10),
                                Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: grey2),
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Text(copyText),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                Clipboard.setData(ClipboardData(
                                                    text: copyText));
                                              },
                                              child: Icon(Icons.copy))
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: share,
                            child: luxButton(HexColor("#415CA0"), Colors.white,
                                "Share Code", 325,
                                fontSize: 16, height: 50, radius: 8),
                          ),
                        ],
                      )),
                ),
              ],
            )
          ],
        ));
  }
}
