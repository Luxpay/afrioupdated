import 'dart:math';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';

import 'package:luxpay/networking/DioServices/dio_errors.dart';
import 'package:luxpay/views/accountSettings/transaction_statement.dart';

import '../../models/trans_history.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/methods/showDialog.dart';
import '../../widgets/transfer_card.dart';
import '../finances/transactionPage_details.dart';

class AccountTransactions extends StatefulWidget {
  const AccountTransactions({Key? key}) : super(key: key);

  @override
  State<AccountTransactions> createState() => _AccountTransactionsState();
}

class _AccountTransactionsState extends State<AccountTransactions> {
  var errors;
  List<String> status = [
    "Any Status",
    "Successful",
    "Pending",
    "Expired",
    "To be paid"
  ];
  int selected_index = -1;

  List<String> categories = [
    "Electricity",
    "Airtime",
    "Funds",
    "Crowd365",
    "Reward",
    "Water",
    "Wallet",
    "Currency"
  ];
  int selected_cate = -1;
  bool checkCate = false;
  bool checkStatus = false;
  List<Result> transferList = [];
  bool fetchTransaction = false;

  @override
  void initState() {
    super.initState();
    getTransactionHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 70,
              decoration: BoxDecoration(color: Colors.white),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
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
                            "Transactions",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(right: 15),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TransactionStatement()));
                            },
                            icon: Icon(IconlyLight.download)))
                  ],
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  margin: EdgeInsets.only(
                    top: 50,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              allCategories(context);
                            },
                            child: secondHeader(
                                name: checkCate == false
                                    ? "Any Categories"
                                    : "${categories[selected_cate]}")),
                        SizedBox(
                          width: 50,
                        ),
                        InkWell(
                            onTap: () {
                              anyStatus(context);
                            },
                            child: secondHeader(
                                name: checkStatus == false
                                    ? "Any Status"
                                    : "${status[selected_index]} ")),
                      ],
                    ),
                  ))),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 100),
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView(children: [
                      MultipleItemsWidget(
                        transferList: transferList,
                        header: "All Transactions",
                      ),
                      SizedBox(height: 20)
                    ]),
                  ),
                ),
              ))
        ],
      )),
    );
  }

  Widget secondHeader({name}) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 6,
        ),
        const Icon(Icons.arrow_drop_down),
      ],
    ));
  }

  // Dialog for status
  anyStatus(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(15),
              height: 370,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Transaction Status"),
                    SizedBox(height: 40),
                    Container(
                        height: 270,
                        child: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => SizedBox(
                            height: SizeConfig.blockSizeVertical! * 3,
                          ),
                          itemCount: status.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected_index = index;
                                  checkStatus = true;
                                  Navigator.pop(context);
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${status[index]}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                  ),
                                  Container(
                                      child: selected_index == index
                                          ? Icon(Icons.check, color: Colors.red)
                                          : Container())
                                ],
                              ),
                            );
                          },
                        ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

// dialog for all categories
  allCategories(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              height: 450,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 30,
                      width: 130,
                      margin: EdgeInsets.only(top: 15, left: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: grey7),
                      child: Center(
                          child: Text("All Categories",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text("Bill Categories",
                            style: TextStyle(color: grey9))),
                    Container(
                      height: 150,
                      width: double.infinity,
                      color: grey1,
                      child: Container(
                          margin: EdgeInsets.only(right: 15),
                          child: GridView.builder(
                            itemCount: categories.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio:
                                  MediaQuery.of(context).size.width /
                                      (MediaQuery.of(context).size.height / 5),
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected_cate = index;
                                      checkCate = true;
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: cate(
                                      cateName: categories[index],
                                      boderColor: selected_cate == index
                                          ? Colors.red
                                          : grey9));
                            },
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 15),
                        child:
                            Text("Finances", style: TextStyle(color: grey9))),
                    Container(
                      height: 110,
                      width: double.infinity,
                      color: grey1,
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  cate(
                                      cateName: 'Electricity',
                                      boderColor: grey9),
                                  cate(
                                      cateName: 'Electricity',
                                      boderColor: grey9),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  cate(
                                      cateName: 'Electricity',
                                      boderColor: grey9),
                                  cate(
                                      cateName: 'Electricity',
                                      boderColor: grey9),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  cate(
                                      cateName: 'Electricity',
                                      boderColor: grey9),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget cate({cateName, boderColor}) {
    return Container(
      height: 30,
      width: 130,
      margin: EdgeInsets.only(top: 15, left: 15),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: boderColor),
          borderRadius: BorderRadius.circular(30),
          color: grey1),
      child: Center(
          child: Text(cateName, style: TextStyle(color: grey7, fontSize: 13))),
    );
  }

  Future<bool> getTransactionHistory() async {
    try {
      var response = await dio.get(
        base_url + "/v1/wallets/history/",
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        var transactionData = await TransactionHistory.fromJson(data);
        setState(() {
          transferList = transactionData.data.results;
          fetchTransaction = true;
        });
        debugPrint("OutPut ${transactionData.data.results.length}");
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          showExpiredsessionDialog(
              context, "Please Login again\nThanks", "Expired Session");
          return false;
        } else {
          // var errorData = e.response?.data;
          //var errorMessage = await ReferralError.fromJson(errorData);
          // errors = errorMessage.errors.extra.error[0];
          return false;
        }
      } else {
        errors = errorMessage;
        showErrorDialog(context, errors, "Banks");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}

class MultipleItemsWidget extends StatefulWidget {
  final String header;
  final List<Result> transferList;
  const MultipleItemsWidget(
      {Key? key, required this.header, required this.transferList})
      : super(key: key);

  @override
  _MultipleItemsWidgetState createState() => _MultipleItemsWidgetState();
}

class _MultipleItemsWidgetState extends State<MultipleItemsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: grey1,
      child: ExpansionTile(
        title: Text(
          widget.header,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 14.0),
        iconColor: Colors.black,
        onExpansionChanged: (v) {
          if (v) {
            controller.forward();
          } else {
            controller.reverse();
          }
        },
        trailing: AnimatedBuilder(
            animation: controller,
            child: const Icon(Icons.chevron_right),
            builder: (context, child) {
              return Transform.rotate(
                angle: lerpDouble(0, pi / 2, controller.value) ?? 0,
                child: child,
              );
            }),
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.separated(
                itemCount: widget.transferList.length,
                itemBuilder: (context, index) {
                  var transfers = widget.transferList[index];
                  var arr = transfers.amount.split('.');
                  var amount = arr[0];
                  var ref = transfers.reference;
                  // DateFormat("h:mma");
                  var dateValue = new DateFormat("yyyy-MM-dd HH:mm:ss")
                      .parse("${transfers.createdAt}", true)
                      .toLocal();
                  String formattedDate =
                      DateFormat("MMMd h:mma").format(dateValue);

                  return TransferHistoryCard(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransactionDetailsPage(
                                      reference: ref,
                                    )));
                      },
                      amount: amount,
                      //channel: transfers.channel,
                      status: transfers.status,
                      date: formattedDate,
                      type: transfers.type);
                },
                separatorBuilder: (context, index) {
                  return Divider(color: Colors.black45);
                },
              ))
        ],
      ),
    );
  }
}

