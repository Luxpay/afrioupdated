import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BorderlessTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? formatters;
  const BorderlessTextField({
    Key? key,
    this.hint,
    this.controller,
    this.formatters,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      inputFormatters: formatters,
      onChanged: (v) => onChanged?.call(v),
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: hint ?? "",
      ),
    );
  }
}
