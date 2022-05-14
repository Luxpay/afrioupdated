import 'package:flutter/material.dart';
import 'package:luxpay/podos/notifications.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';

class NotificationWidget extends StatelessWidget {
  final Notifications notification;
  const NotificationWidget({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return notificationItem(notification);
  }

  Widget notificationItem(Notifications item) {
    return Column(
      children: [
        Text(
          "${item.notificationTime.hour.toString()}:${item.notificationTime.toString().split(":")[1]}",
          style: TextStyle(
              color: HexColor("#8D9091"),
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical! * .5,
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 21.0, right: 11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 1.4,
                ),
                Text(
                  item.title,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * .8,
                ),
                Text(
                  item.msg,
                  style: TextStyle(
                    fontSize: 13,
                    color: HexColor("#8D9091"),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 2.1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
