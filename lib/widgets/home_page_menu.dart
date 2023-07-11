import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final String menuName;
  final String imageName;
  final Color? backgroundColor;
  MenuWidget(
      {Key? key,
      required this.menuName,
      required this.imageName,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: backgroundColor != null ? EdgeInsets.all(2) : null,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius:
                  backgroundColor != null ? BorderRadius.circular(16) : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Image.asset(
              imageName,
              width: 46,
              height: 47,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            menuName,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
