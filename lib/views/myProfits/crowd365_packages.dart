import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/myProfits/crowd365_dashboard.dart';
import 'package:luxpay/widgets/lux_buttons.dart';

class Crowd365Packages extends StatefulWidget {
  static const String path = "crowd365Packages";
  const Crowd365Packages({Key? key}) : super(key: key);

  @override
  State<Crowd365Packages> createState() => _Crowd365PackagesState();
}

class _Crowd365PackagesState extends State<Crowd365Packages> {
  List<Map<String, dynamic>> items = [
    {
      "image": "assets/basic.png",
      "header": {"name": "Basic Package", "price": "N1000"},
      "items": [
        {"name": "Welcome Bonus", "price": "N1000"},
        {"name": "Reward", "price": "N1000"},
        {"name": "Each Cycle", "price": "N1000"},
      ]
    },
    {
      "image": "assets/standard.png",
      "header": {"name": "Standard Package", "price": "N3000"},
      "items": [
        {"name": "Welcome Bonus", "price": "N1,500"},
        {"name": "Reward", "price": "N13,500"},
        {"name": "Each Cycle", "price": "N15,000"},
      ]
    },
    {
      "image": "assets/premium.png",
      "header": {"name": "Premium Package", "price": "N6000"},
      "items": [
        {"name": "Welcome Bonus", "price": "N3,000"},
        {"name": "Reward", "price": "N27,000"},
        {"name": "Each Cycle", "price": "N30,000"},
      ]
    },
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: SizeConfig.safeBlockHorizontal! * 2.4,
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
                        var item = items[index];
                        return GestureDetector(
                          onTap: () => setState(() {
                            selectedIndex = index;
                          }),
                          child: AnimatedContainer(
                            duration: Duration(
                              milliseconds: 200,
                            ),
                            padding: EdgeInsets.only(
                              top: 23,
                              left: SizeConfig.blockSizeHorizontal! * 5,
                              right: SizeConfig.blockSizeHorizontal! * 5,
                              bottom: 17,
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: selectedIndex == index
                                  ? Border.all(
                                      color: HexColor("#415CA0"),
                                    )
                                  : null,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade100.withOpacity(0.4),
                                  offset: Offset(3, 3),
                                )
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(item['image']),
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal! * 4),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          bottom: 16,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item['header']['name'],
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              item['header']['price'],
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      ...item["items"].map((e) {
                                        return Container(
                                          padding: EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                e['name'],
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: HexColor("#8D9091"),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                e['price'],
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: HexColor("#8D9091"),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }).toList()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: SizeConfig.blockSizeVertical! * 2,
                      ),
                      itemCount: items.length,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 4,
                    ),
                    InkWell(
                        onTap: () => {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => const AppPageController()))
                              Navigator.of(context)
                                  .pushNamed(Crowd365Dashboard.path)
                            },
                        child: luxButton(HexColor("#415CA0"), Colors.white,
                            "Subscribe", double.infinity,
                            fontSize: 16, height: 50, radius: 8)),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
