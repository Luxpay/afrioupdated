import 'package:flutter/material.dart';

import '../utils/hexcolor.dart';

class Gender extends StatefulWidget {
  const Gender({Key? key}) : super(key: key);

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  String dropdownValue = 'Gender';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 300,
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
          color: HexColor("#E8E8E8").withOpacity(0.35),
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
            print(newValue);
          });
        },
        items: <String>['Female', 'Male']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
