import 'package:flutter/material.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/colors.dart';
import '../utils/hexcolor.dart';

class PasswordTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;

  PasswordTextField({Key? key, required this.hint, required this.controller})
      : super(key: key);
 
  bool hidePassword = true;
  Color passwordStrengthColor = red6;
  var passwordController = TextEditingController();
  var finished = false;

  var showPasswordHint = false;

  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${hint}",
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: HexColor("#1E1E1E")),
          ),
          SizedBox(height: 15),
          TextField(
            controller: controller,
            onChanged: (value) {
              hidePassword = !hidePassword;
            },
            obscureText: hidePassword,
                    decoration: InputDecoration(
                        //labelText: ' password',
                        hintText:"*************",
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        fillColor: grey1,
                        filled: true,
                        // suffixIcon: IconButton(
                        //   onPressed: () {
                            
                        //       hidePassword = !hidePassword;
                             
                            
                        //   },
                        //   icon: Icon(
                        //       hidePassword
                        //           ? Icons.remove_red_eye_outlined
                        //           : FontAwesomeIcons.eyeSlash,
                        //       size: hidePassword ? 20 : 15),
                        // )
                        ),
                  ),
          
        ],
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  
  final IconData iconData;

  const CircleButton({Key? key, required this.onTap, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 40.0;

    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: new Icon(
          iconData,
          color: Colors.black,
        ),
      ),
    );
  }
}

class CallNumberButton extends StatelessWidget {
  final String phoneNumber;

  CallNumberButton({required this.phoneNumber});

  void _callNumber() async {
    String add = "#";
    String url = "tel://" + this.phoneNumber+add;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => _callNumber(),
        child: luxButton(HexColor("#D70A0A"), Colors.white, "Dail Code", 350)),
    );
  }
}


class MyProfile extends StatelessWidget {
  const MyProfile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Stack(
      children: [
        Container(
           width: 128,
          height: 128,
          decoration: BoxDecoration(
            color: Colors.red,
             shape: BoxShape.circle,
          ),
        ),
        Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),

      ],
    );
  }
}

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
