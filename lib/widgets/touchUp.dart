import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/colors.dart';
import '../utils/hexcolor.dart';

class PasswordTextField extends StatefulWidget {
  final String? hint;
  final TextEditingController? controller;

  PasswordTextField({Key? key, required this.hint, required this.controller})
      : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
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
            "${widget.hint}",
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: HexColor("#1E1E1E")),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: borderColor),
                color: textfieldColor),
            child: TextField(
              controller: widget.controller,
              onChanged: (value) {
                hidePassword = !hidePassword;
              },
              obscureText: hidePassword,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(
                      color: HexColor("#1E1E1E").withOpacity(0.01),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(
                      color: HexColor("#D70A0A"),
                    ),
                  ),
                  //labelText: ' password',
                  hintText: "*************",
                  hintStyle: TextStyle(
                      fontSize: 13,
                      color: HexColor("#333333").withOpacity(0.25),
                      fontWeight: FontWeight.w300),
                  contentPadding: EdgeInsets.only(left: 17, top: 12),
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  fillColor: grey1,
                  filled: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: Icon(
                        hidePassword
                            ? Icons.remove_red_eye_outlined
                            : FontAwesomeIcons.eyeSlash,
                        size: hidePassword ? 20 : 15),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

Widget popUp(context) {
  return Container(
    height: 130,
    width: 300,
    decoration: BoxDecoration(
      color: white,
      // borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Exit App",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 20),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => {Navigator.of(context).pop()},
                child: Container(
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.red,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "No",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () async {
                  SystemNavigator.pop();
                },
                child: Container(
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.red,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Yes",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical! * 2.5,
        ),
      ],
    ),
  );
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
    String url = "tel://" + this.phoneNumber + add;
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
          child:
              luxButton(HexColor("#D70A0A"), Colors.white, "Dail Code", 350)),
    );
  }
}

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

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

class crowd360Rules extends StatelessWidget {
  const crowd360Rules({Key? key, required this.question, required this.answer})
      : super(key: key);

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 35,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: HexColor("#415CA0"),
          ),
          child: Center(
            child: Text(question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: white,
                  fontSize: 15,
                )),
          ),
        ),
        SizedBox(height: 15),
        Container(
          width: double.infinity,
          child: Row(
            children: [
              Flexible(
                child: Text(answer),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class PhoneNumberField extends StatelessWidget {
  final String? innerHint;
  final Color? hintColour;
  final FontWeight? hintWeight;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? formatters;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool enabled;
  final TextInputType? textInputType;
  final bool multiline;
  final int? maxLength;
  final Color? boaderColor;
  const PhoneNumberField(
      {Key? key,
      this.multiline = false,
      this.controller,
      this.formatters,
      this.onChanged,
      this.obscureText = false,
      this.hintColour,
      this.hintWeight,
      this.innerHint,
      this.suffixIcon,
      this.enabled = true,
      this.textInputType,
      this.maxLength,
      this.boaderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "$innerHint",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: HexColor("#1E1E1E")),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 50,
            width: double.infinity,
            // margin: EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: borderColor),
                color: HexColor("#E8E8E8").withOpacity(0.35)),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLines: multiline ? null : 1,
                    controller: controller,
                    inputFormatters: formatters,
                    onChanged: (v) => onChanged?.call(v),
                    obscureText: obscureText,
                    enabled: enabled,
                    maxLength: maxLength,
                    keyboardType: TextInputType.number,
                    expands: multiline,
                    decoration: InputDecoration(
                        hintText: innerHint != null ? innerHint : "",
                        counterText: "",
                        hintStyle: TextStyle(
                            fontSize: 13,
                            color: HexColor("#333333").withOpacity(0.25),
                            fontWeight: FontWeight.w300),
                        contentPadding: suffixIcon != null
                            ? EdgeInsets.only(left: 17, top: 15)
                            : EdgeInsets.only(
                                left: 17, top: multiline ? 10 : 0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: HexColor("#1E1E1E").withOpacity(0.01),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: boaderColor ??
                                HexColor("#1E1E1E").withOpacity(0.01),
                          ),
                        ),
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        errorStyle: const TextStyle(fontSize: 14),
                        fillColor: HexColor("#E8E8E8").withOpacity(0.35),
                        filled: true,
                        prefixIcon:
                            //  Container(
                            //   height: 20,
                            //   width: 20,
                            //   child: Image.asset(
                            //     "assets/nigeria.png",
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),

                            Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text("(+234)"),
                        ),
                        // Icon(Icons.arrow_drop_down)

                        suffixIcon: suffixIcon != null ? suffixIcon : null),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
