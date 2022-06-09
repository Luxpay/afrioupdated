import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final spinKit = SpinKitWave(
  type: SpinKitWaveType.start,
  size: 20,
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.white : Colors.white,
      ),
    );
  },
);

Widget luxButtonLoading(Color fillColour, double width) {
  return Container(
    width: width,
    height: 43,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: Offset(
              0.0,
              1.0,
            ),
          ),
        ],
        color: fillColour),
    child: Center(
      child: spinKit,
    ),
  );
}

Widget luxButton(Color? fillColour, Color textColour, String text, double width,
    {double fontSize = 16,
    double radius = 5,
    Color? borderColour,
    bool hasIcon = false,
    double height = 43}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: fillColour,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          blurRadius: 5.0,
          spreadRadius: 3.0,
          offset: Offset(
            0.0,
            1.0,
          ),
        ),
      ],
      border:
          Border.all(color: borderColour != null ? borderColour : fillColour!),
    ),
    width: width,
    height: height,
    child: Center(
      child: !hasIcon
          ? Text(
              text,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  color: textColour),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/map-store.png",
                  width: 31,
                  height: 25,
                ),
                Text(
                  text,
                  style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                      color: textColour),
                )
              ],
            ),
    ),
  );
}

// Widget backButton(BuildContext context, bool isLogOut) {
//   return InkWell(
//     onTap: () {
//       isLogOut? _logout(context) : Navigator.pop(context);
//     },
//     child: Container(
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       child: Container(
//         padding: EdgeInsets.only(left: 18, top:0, bottom: 25),
//         child: isLogOut? Icon(Icons.logout): Image.asset("assets/ortho-back.png"),
//       ),
//     ),
//   );
// }

// void _logout(BuildContext context) {
//   Navigator.pop(context);
//   Navigator.push(
//       context, MaterialPageRoute(builder: (context) => StoreUserLoginPage()));
// //    FirebaseAuth.instance.signOut();
// }
