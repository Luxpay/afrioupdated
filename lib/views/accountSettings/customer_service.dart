import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/sizeConfig.dart';

class CustomerService extends StatefulWidget {
  const CustomerService({Key? key}) : super(key: key);

  @override
  State<CustomerService> createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<CustomerService> {
  _launchURL() async {
    const url = 'https://wa.me/message/DO3MUPT5ZFQCO1';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Container(
                margin: EdgeInsets.only(top: 20),
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
                      "Customer Service",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  height: 100,
                  // color: Colors.red,
                  margin: EdgeInsets.only(top: 130, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: Image.asset(
                          "assets/cservice.png",
                          scale: 0.6,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi Samson",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                              "You can contact me through any of the\nmeans below")
                        ],
                      ))
                    ],
                  ))),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  margin: EdgeInsets.only(top: 220, left: 50, right: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          _launchURL();
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border.all(width: 1, color: grey3)),
                          child: Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(IconlyLight.chat, color: Colors.blue),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    "Live Chat",
                                    style: TextStyle(color: Colors.blue),
                                  )
                                ]),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: grey4,
                                ),
                                child: Center(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: Colors.black,
                                          size: 14,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          "Live Chat",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: grey4,
                                ),
                                child: Center(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.email,
                                          color: Colors.black,
                                          size: 15,
                                        ),
                                        Text(
                                          "support@luxpay.ng",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Please note we are available;",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Divider(
                            color: grey5,
                          ),
                          Text(
                            "Monday - friday",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          SizedBox(height: 9),
                          Text(
                            "8:30am - 7:00pm",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Saturdays and Public Holidays",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          SizedBox(height: 9),
                          Text(
                            "10:00am - 4:00pm",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ))
                    ],
                  )))
        ],
      )),
    );
  }
}
