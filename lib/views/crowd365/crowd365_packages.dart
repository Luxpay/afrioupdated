import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/models/errors/error.dart';
import 'package:luxpay/networking/dio.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';

import 'package:luxpay/widgets/lux_buttons.dart';

import '../../widgets/methods/showDialog.dart';
import 'crowd365_payment.dart';

class Crowd365Packages extends StatefulWidget {
  static const String path = "crowd365Packages";
  List? referrerPackage;

  Crowd365Packages({
    Key? key,
    required this.referrerPackage,
  }) : super(key: key);

  @override
  State<Crowd365Packages> createState() => _Crowd365PackagesState();
}

class _Crowd365PackagesState extends State<Crowd365Packages> {
  final List<String> images = <String>[
    "assets/premium.png",
    "assets/standard.png",
    "assets/basic.png",
    "assets/basic.png"
  ];

  int selectedIndex = -1;
  List? itemPackage;
  bool checkPackage = false;
  bool _isLoading = false;
  bool selectPackageCheck = false;
  String errors = 'Something went wrong try again';
  String? codeReferrer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.referrerPackage!.isEmpty) {
      setState(() {
        checkPackage = true;
      });
    } else {
      setState(() {
        itemPackage = widget.referrerPackage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: checkPackage == true
              ? Center(
                  child: CircularProgressIndicator(color: HexColor("#415CA0")))
              : Stack(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      onPressed: () => {Navigator.pop(context)},
                                      icon:
                                          const Icon(Icons.arrow_back_ios_new),
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width:
                                          SizeConfig.safeBlockHorizontal! * 2.4,
                                    ),
                                    const Text(
                                      "Select Package",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              color: HexColor("#FBFBFB"),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        //var item = items[index];
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: Offset(0,
                                                    1), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: GestureDetector(
                                            onTap: () => setState(() {
                                              selectedIndex = index;
                                              selectPackageCheck = true;
                                            }),
                                            child: AnimatedContainer(
                                              duration: Duration(
                                                milliseconds: 200,
                                              ),
                                              padding: EdgeInsets.only(
                                                top: 23,
                                                left: SizeConfig
                                                        .blockSizeHorizontal! *
                                                    5,
                                                right: SizeConfig
                                                        .blockSizeHorizontal! *
                                                    5,
                                                bottom: 17,
                                              ),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                border: selectedIndex == index
                                                    ? Border.all(
                                                        color:
                                                            HexColor("#415CA0"),
                                                      )
                                                    : null,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.shade100
                                                        .withOpacity(0.4),
                                                    offset: Offset(3, 3),
                                                  )
                                                ],
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(images[index]),
                                                  SizedBox(
                                                      width: SizeConfig
                                                              .blockSizeHorizontal! *
                                                          4),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                            bottom: 16,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                itemPackage![
                                                                        index]
                                                                    .name,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${itemPackage![index].priceCurrency} ${itemPackage![index].price}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                            bottom: 10,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Welcome Bonus",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: HexColor(
                                                                          "#8D9091"),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "Reward",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: HexColor(
                                                                          "#8D9091"),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "Each Cycle",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: HexColor(
                                                                          "#8D9091"),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "N500",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: HexColor(
                                                                          "#8D9091"),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "N4,500",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: HexColor(
                                                                          "#8D9091"),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "N5,000",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: HexColor(
                                                                          "#8D9091"),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        height:
                                            SizeConfig.blockSizeVertical! * 2,
                                      ),
                                      itemCount: itemPackage!.length,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical! * 4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin:
                            EdgeInsets.only(left: 30, right: 30, bottom: 50),
                        child: InkWell(
                            onTap: () async {
                              var validators = [
                                selectPackageCheck == false
                                    ? "Please Select a Package"
                                    : null,
                              ];
                              if (validators
                                  .any((element) => element != null)) {
                                setState(() {
                                  _isLoading = false;
                                });
                                showChoiceDialog(
                                    context,
                                    validators.firstWhere(
                                            (element) => element != null) ??
                                        "","Crowd365");

                                return;
                              }
                              String namePage =
                                  await itemPackage![selectedIndex].name;
                              String price =
                                  await itemPackage![selectedIndex].price;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Crowd365PaymentMethod(
                                              packageName: namePage,
                                              packagePrice: price)));

                              debugPrint(
                                  "Package Selected ${itemPackage![selectedIndex].name}");
                            },
                            child: _isLoading
                                ? luxButtonLoading(
                                    HexColor("#415CA0"), double.infinity)
                                : luxButton(HexColor("#415CA0"), Colors.white,
                                    "Get Package", double.infinity,
                                    fontSize: 16, height: 50, radius: 8)),
                      ),
                    ),
                  ],
                )),
    );
  }
}
