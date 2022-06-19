import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  String menuName;
  String imageName;
  MenuWidget({Key? key, required this.menuName, required this.imageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
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
