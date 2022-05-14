import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:luxpay/popups/product_order_confirmation_popup.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/reused_widgets.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/widgets/lux_buttons.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  // late PageController pageController;
  late TabController tabController;
  @override
  void initState() {
    // pageController = PageController();
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Product Details",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        leading: GestureDetector(
          child: const Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 35,
          ),
          onTap: Navigator.of(context).pop,
        ),
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 0.5,
            ),
            buildDivider,
            Stack(
              children: [
                Container(
                  height: SizeConfig.blockSizeVertical! * 25,
                  width: double.infinity,
                  color: Colors.white,
                  child: TabBarView(
                    controller: tabController,
                    children: [Container(), Container(), Container()],
                  ),
                ),
                Positioned(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TabPageSelector(
                          controller: tabController,
                          indicatorSize: 8,
                          color: HexColor("#D70A0A").withOpacity(0.1),
                          selectedColor: HexColor("#D70A0A"),
                        )
                      ],
                    ),
                    bottom: 12,
                    left: 0,
                    right: 0)
              ],
            ),
            buildDivider,
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Apple Airpod Pro 3",
                    style: TextStyle(
                      color: HexColor("#1E1E1E"),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal! * 2,
                  ),
                  Row(
                    children: [
                      Text(
                        "N95,000",
                        style: TextStyle(
                          color: HexColor("#1E1E1E"),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "+",
                        style: TextStyle(
                          color: HexColor("#1E1E1E"),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "450 pts",
                        style: TextStyle(
                          color: HexColor("#1E1E1E"),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "34",
                        style: TextStyle(
                          color: HexColor("#8D9091"),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  Text(
                    "N128,000",
                    style: TextStyle(
                      color: HexColor("#8D9091"),
                      fontSize: 14,
                      decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                """This is one phenomenal audio device. Its spatial audio feature makes it sound like speakers surround you by creating a three-dimensional listening experience. 
Its Adaptive EQ adjusts the music to fit your ear, while its inward-facing microphone catches what your listening to and delivers every detail in the song's lyrics and beats. 
These Airpods have a unique acoustic mesh that reduces wind noise on calls while maximizing your voice so you can be heard clearly.""",
                style: TextStyle(
                  color: HexColor(
                    "#8D9091",
                  ),
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: buildSingleItemDescription("Color", "White"),
            ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 25.0),
            //   child: Divider(),
            // ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: MultipleItemsWidget(header: "Description", items: [
                ["Brand name", "vacusg"],
                ["Style", "vacusg"],
                ["Certification", "vacusg"],
                ["Vocalism Principle", "vacusg"],
                ["Communication", "vacusg"],
                ["Noise cancellation", "vacusg"],
                ["Volume Control", "vacusg"],
                ["Wireless Type", "vacusg"],
              ]),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      useRootNavigator: false,
                      useSafeArea: false,
                      builder: (context) {
                        return Scaffold(
                          backgroundColor: Colors.black.withOpacity(0.2),
                          body: const ProductOrderConfirmationPopup(),
                        );
                      });
                },
                child: luxButton(HexColor("#D70A0A"), Colors.white, "Redeem",
                    double.infinity,
                    height: 50, fontSize: 16),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSingleItemDescription(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title:",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: HexColor("#1E1E1E"),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          description,
          style: TextStyle(
            fontSize: 13,
            color: HexColor("#8D9091"),
          ),
        ),
      ],
    );
  }
}

class MultipleItemsWidget extends StatefulWidget {
  final String header;
  final List<List<String>> items;
  const MultipleItemsWidget(
      {Key? key, required this.header, required this.items})
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
    return ExpansionTile(
      title: Text(
        widget.header,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 13,
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
      children: widget.items
          .asMap()
          .entries
          .map((e) => Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  border: e.key != widget.items.length - 1
                      ? Border(
                          bottom: BorderSide(
                            color: HexColor("#E4E9F2"),
                          ),
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      e.value[0],
                      style: TextStyle(
                        fontSize: 13,
                        color: HexColor("#8D9091"),
                      ),
                    )),
                    Expanded(
                      child: Text(
                        e.value[1],
                        style: TextStyle(
                          fontSize: 13,
                          color: HexColor("#1E1E1E"),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
