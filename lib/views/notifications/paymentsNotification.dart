import 'dart:async';

import 'package:flutter/material.dart';
import 'package:luxpay/podos/notifications.dart';
import 'package:luxpay/widgets/notificationWidget.dart';

import '../../services/notification_database.dart';

// ignore: must_be_immutable
class PaymentsNotification extends StatefulWidget {
 
  PaymentsNotification({Key? key, }) : super(key: key);

  @override
  _PaymentsNotificationState createState() => _PaymentsNotificationState();
}

class _PaymentsNotificationState extends State<PaymentsNotification> {
   List<Notifications>? items;
  Future refreshNotes() async {
    items = await NotificationDatabase.instance.readAllNotification();
  }

  @override
  void initState() {
    super.initState();

    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      refreshNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return items == null
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
            itemCount: items!.length,
            itemBuilder: (BuildContext context, int position) {
              return NotificationWidget(notification: items![position]);
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 20,
              );
            });
  }
}
