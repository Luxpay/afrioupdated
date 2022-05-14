import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';

class OTPFields extends StatefulWidget {
  final int count;
  final ValueChanged<String> onVerified;
  const OTPFields({Key? key, required this.count, required this.onVerified})
      : super(key: key);

  @override
  State<OTPFields> createState() => _OTPFieldsState();
}

class _OTPFieldsState extends State<OTPFields> {
  late List<TextEditingController> _controllers = List.generate(
      widget.count, (index) => TextEditingController(text: "\u200B"));
  late List<FocusNode> _nodes =
      List.generate(widget.count, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ..._controllers
            .asMap()
            .entries
            .map((e) => OTPField(
                controller: e.value,
                node: _nodes[e.key],
                onChanged: (v) {
                  if (v.length == 0) {
                    _controllers[e.key].value = TextEditingValue(
                      text: "\u200B",
                      selection: TextSelection.collapsed(
                          offset: _controllers[e.key].text.length),
                    );
                    if (e.key > 0) {
                      _nodes[e.key - 1].requestFocus();
                    }
                  } else if (v.length == 1) {
                    if (e.key > 0) {
                      _nodes[e.key - 1].requestFocus();
                    }
                  } else if (v.length > 2) {
                    _controllers[e.key].text =
                        "\u200B${_controllers[e.key].text.substring(1, 2)}";
                    if (e.key < _controllers.length - 1) {
                      _nodes[e.key + 1].requestFocus();
                    } else {
                      widget.onVerified(
                          _controllers.map((v) => v.text.trim()).join());
                    }
                  } else {
                    if (e.key < _controllers.length - 1) {
                      _nodes[e.key + 1].requestFocus();
                    } else {
                      widget.onVerified(
                          _controllers.map((v) => v.text.trim()).join());
                    }
                  }
                }))
            .toList()
      ],
    );
  }
}

class OTPField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode node;
  final ValueChanged<String> onChanged;
  const OTPField(
      {Key? key,
      required this.controller,
      required this.node,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49,
      width: 46,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: HexColor("#E8E8E8").withOpacity(0.35),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        width: 12,
        child: TextField(
          controller: controller,
          focusNode: node,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(0),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
          ),
          onChanged: (v) {
            onChanged(v);
          },
        ),
      ),
    );
  }
}
