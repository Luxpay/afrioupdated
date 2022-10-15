import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

Color borderColor = HexColor("#E8E8E8").withOpacity(0.35);
Color textfieldColor = HexColor("#FFFFFF");
Color textColor = Colors.black;

class LuxPickerData {
  final String title;
  final dynamic value;

  LuxPickerData({required this.title, required this.value});
}

class LuxTextField extends StatelessWidget {
  final String? hint;
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
  final Icon? prefixIcon;

  const LuxTextField(
      {Key? key,
      this.hint,
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
      this.prefixIcon,
      this.boaderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$hint",
          style: TextStyle(
              fontSize: 13,
              fontWeight: hintWeight != null ? hintWeight : FontWeight.w600,
              color: hintColour != null ? hintColour : HexColor("#1E1E1E")),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          constraints: BoxConstraints(
            maxHeight: multiline ? SizeConfig.blockSizeVertical! * 12 : 50,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor),
              color: textfieldColor),
          child: TextField(
            maxLines: multiline ? null : 1,
            controller: controller,
            inputFormatters: formatters,
            onChanged: (v) => onChanged?.call(v),
            obscureText: obscureText,
            enabled: enabled,
            maxLength: maxLength,
            keyboardType: textInputType,
            expands: multiline,
            decoration: InputDecoration(
                hintText: innerHint != null ? innerHint : "",
                counterText: "",
                hintStyle: TextStyle(
                    fontSize: 13,
                    color: HexColor("#333333").withOpacity(0.25),
                    fontWeight: FontWeight.w300),
                contentPadding: suffixIcon != null
                    ? EdgeInsets.only(left: 17, top: 12)
                    : EdgeInsets.only(left: 17, top: multiline ? 10 : 0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(
                    color: HexColor("#1E1E1E").withOpacity(0.01),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(
                    color: boaderColor ?? HexColor("#1E1E1E").withOpacity(0.01),
                  ),
                ),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                errorStyle: const TextStyle(fontSize: 14),
                fillColor: HexColor("#E8E8E8").withOpacity(0.35),
                filled: true,
                prefix: prefixIcon != null ? prefixIcon : null,
                suffixIcon: suffixIcon != null ? suffixIcon : null),
          ),
        ),
      ],
    );
  }
}

class LuxTextFieldNumber extends StatelessWidget {
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

  const LuxTextFieldNumber(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: multiline ? SizeConfig.blockSizeVertical! * 12 : 50,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor),
              color: textfieldColor),
          child: TextField(
            maxLines: multiline ? null : 1,
            controller: controller,
            inputFormatters: formatters,
            onChanged: (v) => onChanged?.call(v),
            obscureText: obscureText,
            enabled: enabled,
            maxLength: maxLength,
            keyboardType: textInputType,
            expands: multiline,
            decoration: InputDecoration(
                hintText: innerHint != null ? innerHint : "",
                counterText: "",
                hintStyle: TextStyle(
                    fontSize: 13,
                    color: HexColor("#333333").withOpacity(0.25),
                    fontWeight: FontWeight.w300),
                contentPadding: suffixIcon != null
                    ? EdgeInsets.only(left: 17, top: 12)
                    : EdgeInsets.only(left: 17, top: multiline ? 10 : 0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(
                    color: HexColor("#1E1E1E").withOpacity(0.01),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(
                    color: boaderColor ?? HexColor("#1E1E1E").withOpacity(0.01),
                  ),
                ),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                errorStyle: const TextStyle(fontSize: 14),
                fillColor: HexColor("#E8E8E8").withOpacity(0.35),
                filled: true,
                suffixIcon: suffixIcon != null ? suffixIcon : null),
          ),
        ),
      ],
    );
  }
}

class LuxPicker extends StatelessWidget {
  final String? hint;
  final String? value;
  final Widget? suffixIcon;
  final FontWeight? hintWeight;
  final Color? hintColour;
  final List<LuxPickerData> values;
  final ValueChanged<LuxPickerData> onChanged;

  const LuxPicker({
    Key? key,
    this.value,
    this.hint,
    this.suffixIcon,
    this.hintWeight,
    this.hintColour,
    required this.values,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$hint",
          style: TextStyle(
              fontSize: 13,
              fontWeight: hintWeight != null ? hintWeight : FontWeight.w600,
              color: hintColour != null ? hintColour : HexColor("#1E1E1E")),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            showGeneralDialog(
                context: context,
                useRootNavigator: false,
                barrierDismissible: false,
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  print("Dialog: ${values.length}");
                  return LuxPayDialog(
                    values: values,
                    onChanged: onChanged,
                  );
                });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor),
              color: textfieldColor,
            ),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: borderColor),
                color: HexColor("#E8E8E8").withOpacity(0.35),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 17),
                      child: Text(
                        value != null ? value! : hint ?? "",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: value != null
                              ? HexColor("#1E1E1E")
                              : HexColor("#333333").withOpacity(0.25),
                        ),
                      ),
                    ),
                  ),
                  suffixIcon != null
                      ? suffixIcon is Icon
                          ? (suffixIcon! as Icon).withColor(
                              value == null
                                  ? HexColor("#8D9091")
                                  : HexColor("#D70A0A"),
                            )
                          : suffixIcon!
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LuxPayDialog extends StatefulWidget {
  final List<LuxPickerData> values;
  final ValueChanged<LuxPickerData> onChanged;

  const LuxPayDialog({Key? key, required this.values, required this.onChanged})
      : super(key: key);

  @override
  State<LuxPayDialog> createState() => _LuxPayDialogState();
}

class _LuxPayDialogState extends State<LuxPayDialog> {
  @override
  void initState() {
    print(widget.values.length);
    super.initState();
  }

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: SafeArea(
        bottom: false,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.7,
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select Bank"),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: HexColor("#EDF1F7"),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.blockSizeVertical! * 0.1),
                LuxTextField(
                  controller: _controller,
                  innerHint: "Search Bank",
                  onChanged: (v) {
                    setState(() {});
                  },
                  hint: "",
                ),
                SizedBox(height: SizeConfig.blockSizeVertical! * 0.1),
                Expanded(
                  child: ListView.separated(
                      padding: EdgeInsets.only(top: 17),
                      itemBuilder: (context, index) {
                        LuxPickerData item = widget.values
                            .where((element) => element.title
                                .toLowerCase()
                                .contains(
                                    _controller.text.trim().toLowerCase()))
                            .toList()[index];
                        return GestureDetector(
                          onTap: () {
                            widget.onChanged(item);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              item.title,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: HexColor("#E4E9F2"),
                          thickness: 1,
                        );
                      },
                      itemCount: widget.values
                          .where((element) => element.title
                              .toLowerCase()
                              .contains(_controller.text.trim().toLowerCase()))
                          .length),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension IconOverride on Icon {
  Icon withColor(Color color) {
    return Icon(
      this.icon,
      color: color,
    );
  }
}

class LuxpayTextFieldNumber extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;

  final String? innerHint;
  final Color? hintColour;
  final FontWeight? hintWeight;

  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? formatters;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool enabled;
  final TextInputType? textInputType;
  final bool multiline;
  final int? maxLength;

  LuxpayTextFieldNumber({
    Key? key,
    required this.hint,
    required this.controller,
    this.multiline = false,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$hint",
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: HexColor("#1E1E1E")),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            constraints: BoxConstraints(
              maxHeight: SizeConfig.blockSizeVertical! * 20,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: borderColor),
                color: textfieldColor),
            child: IntlPhoneField(
              controller: controller,
              obscureText: obscureText,
              enabled: enabled,
              decoration: InputDecoration(
                  hintText: innerHint != null ? innerHint : "",
                  counterText: "",
                  hintStyle: TextStyle(
                      fontSize: 13,
                      color: HexColor("#333333").withOpacity(0.25),
                      fontWeight: FontWeight.w300),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  //errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  errorStyle: const TextStyle(fontSize: 14),
                  fillColor: HexColor("#E8E8E8").withOpacity(0.35),
                  filled: true,
                  suffixIcon: suffixIcon != null ? suffixIcon : null),
              onChanged: (phone) {
                //print(phone.completeNumber);
              },
              onCountryChanged: (country) {
                //print('Country changed to: ' + country.name);
              },
            ))
      ],
    ));
  }
}
