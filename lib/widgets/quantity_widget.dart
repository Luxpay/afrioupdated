import 'package:flutter/material.dart';

import '../utils/hexcolor.dart';

class QuantityWidget extends StatelessWidget {
  final int amount;
  final ValueChanged<int> onChange;
  const QuantityWidget({Key? key, required this.amount, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onChange(amount - 1),
          child: Container(
            height: 27,
            width: 27,
            decoration: BoxDecoration(
                color: HexColor("#E8E8E8").withOpacity(0.35),
                borderRadius: BorderRadius.circular(6)),
            child: Icon(
              Icons.remove,
              color: HexColor("#8D9091"),
            ),
          ),
        ),
        const SizedBox(
          width: 18,
        ),
        Text(
          "$amount",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: HexColor("#D70A0A"),
          ),
        ),
        const SizedBox(
          width: 18,
        ),
        GestureDetector(
          onTap: () => onChange(amount + 1),
          child: Container(
            height: 27,
            width: 27,
            decoration: BoxDecoration(
                color: HexColor("#E8E8E8").withOpacity(0.35),
                borderRadius: BorderRadius.circular(6)),
            child: Icon(
              Icons.add,
              color: HexColor("#8D9091"),
            ),
          ),
        ),
      ],
    );
  }
}
