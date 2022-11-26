import 'dart:async';

import 'package:flutter/material.dart';
import 'package:luxpay/podos/notifications.dart';

import '../../services/notification_database.dart';
import '../../utils/colors.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';

// ignore: must_be_immutable
class PaymentsNotification extends StatefulWidget {
  PaymentsNotification({
    Key? key,
  }) : super(key: key);

  @override
  _PaymentsNotificationState createState() => _PaymentsNotificationState();
}

class _PaymentsNotificationState extends State<PaymentsNotification> {
  List<Notifications> items = [];

  get grey3 => null;
  Future refreshNotes() async {
    items = await NotificationDatabase.instance.readAllNotification();
  }

  @override
  void initState() {
    super.initState();

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        refreshNotes();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? Center(
            child: InkWell(
              onTap: () {
                setState(() {
                  refreshNotes();
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh),
                  Text(
                    'No Notification yet',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ],
              ),
            ),
          )
        : ListView.separated(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int position) {
              var item = items[position];
              return Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Text(
                      "${item.createdTime.hour.toString()}:${item.createdTime.toString().split(":")[1]}",
                      style: TextStyle(
                          color: HexColor("#8D9091"),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * .5,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical! * 1.4,
                                ),
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical! * .8,
                                ),
                              ],
                            ),
                            Text(
                              item.body,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: HexColor("#8D9091"),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical! * 2.1,
                            ),
                            InkWell(
                              onTap: () async {
                                await NotificationDatabase.instance
                                    .delete(item.id);
                                setState(() {
                                  items.removeAt(position);
                                });
                              },
                              child: Icon(
                                Icons.delete,
                                color: grey6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 20,
              );
            });
  }
}
