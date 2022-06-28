import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:luxpay/views/accountSettings/transaction_statement.dart';

import '../../utils/colors.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';

class TransactionDetails extends StatefulWidget {
  const TransactionDetails({Key? key}) : super(key: key);

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  margin: EdgeInsets.only(
                    top: 70,
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
                margin: EdgeInsets.only(top: 110),
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView(children: [Card3(), SizedBox(height: 20)]),
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

  // This is a block of Model Dialog
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
}

class Card3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildItem(String label) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(label),
      );
    }

    buildList() {
      return Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height - 300,
              child: ListView(
                children: [
                  transactionCard(),
                  transactionCard(),
                  transactionCard(),
                  transactionCard(),
                  transactionCard()
                ],
              ))
        ],
      );
    }

    return ExpandableNotifier(
        child: Container(
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  height: 55,
                  color: grey1,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  "January, 2022",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: grey10),
                                ),
                              ),
                              SizedBox(width: 8),
                              ExpandableIcon(
                                theme: const ExpandableThemeData(
                                  expandIcon: Icons.arrow_drop_down,
                                  collapseIcon: Icons.arrow_drop_down,
                                  iconColor: Colors.grey,
                                  iconSize: 20.0,
                                  //iconRotationAngle: math.pi / 2,
                                  iconPadding: EdgeInsets.only(right: 5),
                                  hasIcon: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Icon(IconlyLight.document),
                        )
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: buildList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

Widget transactionCard() {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(
          top: 15,
          left: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/transactionwithdraw.png',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                        left: 70,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Transfer to bank",
                            style: TextStyle(fontSize: 17, color: black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("January 12, 20:18")
                        ],
                      ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Successful",
                      style: TextStyle(
                          color: green4,
                          fontSize: 15,
                          fontWeight: FontWeight.w300)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "-5000",
                    style: TextStyle(
                        fontSize: 18,
                        color: black,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 8,
      ),
      Divider(
        color: HexColor("#FBFBFB"),
        thickness: 5,
      ),
    ],
  );
}
