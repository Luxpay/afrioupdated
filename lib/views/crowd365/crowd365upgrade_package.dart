import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import '../../models/errors/authError.dart';
import '../../models/packagesModel.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../widgets/methods/showDialog.dart';
import 'crowd365_payment.dart';

class Crowd365PackagesUpgrade extends StatefulWidget {
  final String? price;
  Crowd365PackagesUpgrade({Key? key, this.price}) : super(key: key);

  @override
  State<Crowd365PackagesUpgrade> createState() =>
      _Crowd365PackagesUpgradeState();
}

class _Crowd365PackagesUpgradeState extends State<Crowd365PackagesUpgrade> {
  final List<String> images = <String>[
    "assets/Premium.png",
    "assets/Standard.png",
    "assets/Basic.png",
  ];

  int selectedIndex = -1;
  List<Datum> itemPackage = [];
  List<Datum> filter = [];
  bool checkPackage = false;
  bool _isLoading = false;
  bool selectPackageCheck = false;
  String errors = 'Something went wrong try again';
  String? codeReferrer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getPackage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: itemPackage.isEmpty
              ? Center(child: Text("No Package Found"))
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
                                                                filter[index]
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
                                                                "N${filter[index].price}",
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
                                                                    "N${filter[index].welcomeBonus}",
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
                                                                    "N${filter[index].reward}",
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
                                                                    "N${filter[index].eachCycle}",
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
                                      itemCount: filter.length,
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
                                showErrorDialog(
                                    context,
                                    validators.firstWhere(
                                            (element) => element != null) ??
                                        "",
                                    "Crowd365");

                                return;
                              }
                              String namePage =
                                  await filter[selectedIndex].name;
                              String price = await filter[selectedIndex].price;
                              String welcomeBonus =
                                  await filter[selectedIndex].welcomeBonus;
                              String reward =
                                  await filter[selectedIndex].reward;
                              String eachCycle =
                                  await filter[selectedIndex].eachCycle;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Crowd365PaymentMethod(
                                            packageName: namePage,
                                            packagePrice: price,
                                            packageEachCycle: eachCycle,
                                            packageWelcomeBonus: welcomeBonus,
                                            packageReward: reward,
                                          )));

                              debugPrint(
                                  "Package Selected ${filter[selectedIndex].name}");
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

  Future<bool> getPackage() async {
    try {
      var response = await dio.get(
        "/v1/crowd365/packages/",
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;

        var packageData = Packages.fromJson(data);

        setState(() {
          itemPackage = packageData.data;
          filter.addAll(itemPackage);

          filter.retainWhere((element) {
            if (double.parse('${widget.price}') == 1000.00) {
              return double.parse('${element.price}') >
                  1000.00; // return every package greater than 1000
            } else if (double.parse('${widget.price}') == 3000.00) {
              return double.parse('${element.price}') >
                  3000.00; // return every package greater than 3000
            } else if (double.parse('${widget.price}') == 6000.00) {
              return double.parse('${element.price}') >
                  3000.00; // return every package greater than 3000
            }
            return false;
          });
        });

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        debugPrint(' Error: ${e.response?.data}');
        if (e.response?.statusCode == 401) {
          showExpiredsessionDialog(
              context, "Please Login again\nThanks", "Expired Session");
          return false;
        } else {
          var errorData = e.response?.data;
          var errorMessage = await AuthError.fromJson(errorData);
          errors = errorMessage.message;
          return false;
        }
      } else {
        errors = errorMessage;
        showErrorDialog(context, errors, "Crowd365");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}
