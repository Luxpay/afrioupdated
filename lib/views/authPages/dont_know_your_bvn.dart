import 'package:flutter/material.dart';
import 'package:luxpay/utils/colors.dart';

import 'package:luxpay/widgets/touchUp.dart';

class DontKnowUrBVN extends StatefulWidget {
  const DontKnowUrBVN({Key? key}) : super(key: key);

  @override
  State<DontKnowUrBVN> createState() => _DontKnowUrBVNState();
}

class _DontKnowUrBVNState extends State<DontKnowUrBVN> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
          width: double.infinity,
          height: 350,
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
                      alignment: Alignment.topCenter,
                      child: Container(
                        child: Row(
                          children: [
                            Flexible(
                                child: Text(
                              "Dial the code below and follow all onscreen instructions to get your BVN number. ",
                              textAlign: TextAlign.center,
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 120, right: 40, left: 40),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                                child: Text(
                              "*565*0#",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 140, right: 40, left: 40),
                    child: Align(
                      alignment: Alignment.center,
                      child: Divider(
                        height: 50,
                        thickness: 3,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 240, right: 40, left: 40),
                    child: Align(
                      alignment: Alignment.center,
                      child: CallNumberButton(phoneNumber: "*565*0#"),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
