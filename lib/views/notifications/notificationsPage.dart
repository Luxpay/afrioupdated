import 'package:flutter/material.dart';
import 'package:luxpay/podos/notifications.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/notifications/paymentsNotification.dart';

import '../../services/notification_database.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  List<Notifications> notification = [];

  Future refreshNotes() async {
    setState(() async {
      await NotificationDatabase.instance.readAllNotification();
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();

    refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // final double width = MediaQuery.of(context).size.width;
    // final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: const Icon(Icons.arrow_back_ios_new)),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal! * 2.4,
                ),
                const Text(
                  "Notifications",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )
              ],
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical! * 2.1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: TabBar(
                controller: tabController,
                indicatorColor: HexColor("#D70A0A"),
                unselectedLabelColor: Colors.black,
                labelColor: HexColor("#200E32"),
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(
                    text: "Payments",
                  ),
                  Tab(
                    text: "Messages",
                  ),
                  Tab(
                    text: "News",
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: HexColor("#FBFBFB"),
                child: TabBarView(
                  children: [
                    PaymentsNotification(
                      items: notification,
                    ),
                    Text("data"),
                    Text("data"),
                  ],
                  controller: tabController,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
