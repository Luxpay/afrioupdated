import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../widgets/touchUp.dart';

class SelectIDCard extends StatefulWidget {
  const SelectIDCard({Key? key}) : super(key: key);

  @override
  State<SelectIDCard> createState() => _SelectIDCardState();
}

class _SelectIDCardState extends State<SelectIDCard> {
  int selectedIndex = -1;
  List<IDType> idList = [
    IDType("1", "BVN"),
    IDType("2", "NIN"),
    IDType("3", "DRV"),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            child: Column(children: [
              Stack(children: [
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
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        margin: EdgeInsets.only(left: 20, top: 30),
                        child: Text(
                          "Select ID Type",
                          style: TextStyle(color: Colors.black),
                        ))),
                Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        margin: EdgeInsets.only(left: 20, top: 60, right: 20),
                        child: Container(
                          height: 200,
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    Divider(height: 1),
                            itemCount: idList.length,
                            itemBuilder: (context, index) {
                              //var banks = bankList[index];
                              var ids = idList[index];
                              return ListTile(
                                  title: Text(ids.name),
                                  leading: Text(ids.id),
                                  trailing: Image.asset(
                                      "assets/selected_radio.png",
                                      color: selectedIndex == index
                                          ? Colors.red
                                          : Colors.grey),
                                  // subtitle: Text(banks.bankCode),
                                  onTap: () async {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                    Map<String, dynamic> body = {
                                      "cardID": ids.id,
                                      "cardName": ids.name
                                    };
                                    Navigator.pop(context, body);
                                  });
                            },
                          ),
                        )))
              ])
            ])));
  }
}

class IDType {
  String name;
  String id;

  IDType(this.id, this.name);
}

// how to delete item from list in flutter ?

