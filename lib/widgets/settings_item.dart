import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const SettingsItem({Key? key, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 53,
        padding: EdgeInsets.symmetric(horizontal: 24),
        width: double.infinity,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: HexColor("#343434"),
              ),
            ),
            Icon(
              Icons.chevron_right_outlined,
              color: Colors.grey,
              size: 29,
            )
          ],
        ),
      ),
    );
  }
}
