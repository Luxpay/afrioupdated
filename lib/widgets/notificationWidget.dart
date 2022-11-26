// import 'package:flutter/material.dart';
// import 'package:luxpay/utils/colors.dart';
// import 'package:luxpay/utils/hexcolor.dart';
// import 'package:luxpay/utils/sizeConfig.dart';
// import '../podos/notifications.dart';
// import '../services/notification_database.dart';

// class NotificationWidget extends StatefulWidget {
//   final Notifications notification;
//   final VoidCallback? onTap;

//   NotificationWidget({
//     Key? key,
//     required this.notification,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   State<NotificationWidget> createState() => _NotificationWidgetState();
// }

// class _NotificationWidgetState extends State<NotificationWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return notificationItem(widget.notification);
//   }

//   Widget notificationItem(Notifications item) {
//     return Container(
//       margin: const EdgeInsets.only(left: 20, right: 20),
//       child: Column(
//         children: [
//           Text(
//             "${item.createdTime.hour.toString()}:${item.createdTime.toString().split(":")[1]}",
//             style: TextStyle(
//                 color: HexColor("#8D9091"),
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600),
//           ),
//           SizedBox(
//             height: SizeConfig.safeBlockVertical! * .5,
//           ),
//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.white,
//             ),
//             child: Container(
//               margin: const EdgeInsets.only(left: 15, right: 15),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: SizeConfig.safeBlockVertical! * 1.4,
//                       ),
//                       Text(
//                         item.title,
//                         style: const TextStyle(
//                             fontSize: 13, fontWeight: FontWeight.w700),
//                       ),
//                       SizedBox(
//                         height: SizeConfig.safeBlockVertical! * .8,
//                       ),
//                     ],
//                   ),
//                   Text(
//                     item.body,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: HexColor("#8D9091"),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   SizedBox(
//                     height: SizeConfig.safeBlockVertical! * 2.1,
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       await NotificationDatabase.instance.delete(item.id);
//                     },
//                     child: Icon(
//                       Icons.delete,
//                       color: grey3,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
