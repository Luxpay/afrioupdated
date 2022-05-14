import 'package:flutter/material.dart';
import 'package:luxpay/podos/notifications.dart';
import 'package:luxpay/widgets/notificationWidget.dart';


class PaymentsNotification extends StatefulWidget {
  final List<Notifications> items;
  const PaymentsNotification({Key? key, required this.items}) : super(key: key);

  @override
  _PaymentsNotificationState createState() => _PaymentsNotificationState();
}

class _PaymentsNotificationState extends State<PaymentsNotification> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => index == widget.items.length - 1
          ? Container()
          : const SizedBox(
        height: 16,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24).add(
        const EdgeInsets.only(top: 27, bottom: 32),
      ),
      itemBuilder: (context, index) =>
          NotificationWidget(notification: widget.items[index],),
      itemCount: widget.items.length,
    );
  }
}
