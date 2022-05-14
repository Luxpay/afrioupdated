import 'package:flutter/material.dart';

import '../utils/hexcolor.dart';

class DescriptionAndDetails extends StatelessWidget {
  final String description;
  final Widget details;
  final double? fontSize;
  final bool? bold;
  final bool? black;
  const DescriptionAndDetails(
      {Key? key,
      required this.description,
      required this.details,
      this.fontSize,
      this.bold,
      this.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          description,
          style: TextStyle(
            fontSize: fontSize ?? 12,
            color: black == true ? HexColor("#1E1E1E") : HexColor("#8D9091"),
          ),
        ),
        details
      ],
    );
  }
}
