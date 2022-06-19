import 'dart:async';

import 'package:flutter/material.dart';
import 'package:luxpay/podos/notifications.dart';
import 'package:luxpay/widgets/notificationWidget.dart';

import '../../services/notification_database.dart';

class PaymentsNotification extends StatefulWidget {
  List<Notifications> items;
  PaymentsNotification({Key? key, required this.items}) : super(key: key);

  @override
  _PaymentsNotificationState createState() => _PaymentsNotificationState();
}

class _PaymentsNotificationState extends State<PaymentsNotification> {
  Future refreshNotes() async {
    widget.items = await NotificationDatabase.instance.readAllNotification();
  }

  //Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // timer = Timer.periodic(Duration(seconds: 5), (_) {

    refreshNotes();

    //});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    setState(() {
      // timer!.cancel();
      // timer!.cancel();
      print("cancelButton");
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.items.isEmpty
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
            itemCount: widget.items.length,
            itemBuilder: (BuildContext context, int position) {
              return NotificationWidget(notification: widget.items[position]);
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 20,
              );
            });
  }
}
