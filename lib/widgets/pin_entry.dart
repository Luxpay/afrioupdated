

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';

final pinEntryProvier = StateNotifierProvider.family
    .autoDispose<PinEntryNotifier, List<String>, String>((ref, value) {
  return PinEntryNotifier([]);
});

class PinEntry extends ConsumerStatefulWidget {
  final String tag;
  final ValueChanged<int?> onPinChanged;
  const PinEntry({Key? key, required this.onPinChanged, required this.tag})
      : super(key: key);

  @override
  ConsumerState<PinEntry> createState() => _PinEntryState();
}

class _PinEntryState extends ConsumerState<PinEntry> {
  List<String> list = [];
  @override
  Widget build(BuildContext context) {
    var pinEntry = ref.watch(pinEntryProvier(widget.tag));
    ref.listen<List<String>>(pinEntryProvier(widget.tag), (a, b) {
      if (b.length >= 0 && b.length < 5) {
        widget.onPinChanged(int.tryParse(b.join("")));
      }
    });
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal! * 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: HexColor("#ECECEC"),
                  ),
                  color: pinEntry.length > 0
                      ? HexColor("#D70A0A")
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: HexColor("#ECECEC"),
                  ),
                  color: pinEntry.length > 1
                      ? HexColor("#D70A0A")
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: HexColor("#ECECEC"),
                  ),
                  color: pinEntry.length > 2
                      ? HexColor("#D70A0A")
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: HexColor("#ECECEC"),
                  ),
                  color: pinEntry.length > 3
                      ? HexColor("#D70A0A")
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical! * 9,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal! * 15,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                  ),
                  buildButton("0"),
                  InkWell(
                    onTap: () {
                      ref.read(pinEntryProvier(widget.tag).notifier).remove();
                    },
                    borderRadius: BorderRadius.circular(30),
                    splashColor: HexColor("#E8E8E8").withOpacity(0.35),
                    child: Container(
                      height: 60,
                      width: 60,
                      alignment: Alignment.center,
                      child: Icon(Icons.arrow_back, color: Colors.grey),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildButton(String value) {
    return InkWell(
      onTap: () {
        ref.read(pinEntryProvier(widget.tag).notifier).append(value);
        list.add(value);
      },
      borderRadius: BorderRadius.circular(30),
      splashColor: HexColor("#D70A0A").withOpacity(0.35),
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: HexColor("#E8E8E8").withOpacity(0.35),
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class PinEntryNotifier extends StateNotifier<List<String>> {
  PinEntryNotifier(List<String> state) : super(state);

  void append(String value) {
    if (state.length < 4) {
      state = [...state, value];
    }
    print(state.length);
  }

  void remove() {
    if (state.length > 0) {
      var temp = state.map((e) => e).toList();
      temp.removeLast();
      state = [...temp];
    }
  }

  void set(int v) {
    state = [...v.toString().split("")];
  }
}
