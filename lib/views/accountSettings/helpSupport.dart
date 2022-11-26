import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:luxpay/views/accountSettings/fqas.dart';

import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/navigate_route.dart';
import 'customer_service.dart';

class HelpandSupport extends StatefulWidget {
  const HelpandSupport({Key? key}) : super(key: key);

  @override
  State<HelpandSupport> createState() => _HelpandSupportState();
}

class _HelpandSupportState extends State<HelpandSupport> {
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
              decoration: BoxDecoration(color: Colors.white
                  //     border: Border(
                  //   bottom: BorderSide(
                  //     color: HexColor("#333333").withOpacity(0.3),
                  //     width: 0.5,
                  //   ),
                  // )
                  ),
              child: Container(
                //margin: EdgeInsets.only(top: 20),
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
                      "Help & Support",
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
              margin: EdgeInsets.only(top: 100, left: 24, right: 24),
              child: Column(
                children: [
                  ProfileAction(
                    title: "Customer Service",
                    icon: IconlyLight.chat,
                    onTap: () {
                      Navigator.push(
                          context, SizeTransition4(CustomerService()));
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ProfileAction(
                    title: "FAQ",
                    icon: IconlyLight.infoSquare,
                    onTap: () {
                      Navigator.push(context, SizeTransition4(FAQ()));
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

class ProfileAction extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  const ProfileAction(
      {Key? key, required this.title, required this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 59,
        padding: EdgeInsets.symmetric(
          horizontal: 18,
        ),
        decoration: BoxDecoration(
          color: HexColor("#E8E8E8").withOpacity(0.35),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: HexColor("#343434"),
                  size: 30,
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal! * 3,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: HexColor("#343434"),
                  ),
                ),
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: HexColor(
                "#CCCCCC",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
