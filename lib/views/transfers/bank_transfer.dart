import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:luxpay/networking/dio.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';

class BankTransfer extends StatefulWidget {
  static const String path = '/bank_transfer';
  const BankTransfer({Key? key}) : super(key: key);

  @override
  State<BankTransfer> createState() => _BankTransferState();
}

class _BankTransferState extends State<BankTransfer> {
  List<LuxPickerData> data = [];
  LuxPickerData? selectedData;
  String userName = "";
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  bool loading = false;

  Future<void> getBanks() async {
    try {
      var response = await unAuthDio.get(
        "/api/finance/transfer/getBanks/",
      );
      var info = response.data['data'];
      data = (info as List)
          .map((e) => LuxPickerData(
                title: e['name'],
                value: e['code'],
              ))
          .toList();
      if (mounted) {
        setState(() {});
      }
    } on DioError catch (e) {
      print(e.response?.data);
      if (e.response != null) {
      } else {}
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUserName() async {
    if (selectedData == null || controller.text.trim().length != 10) {
      setState(() {
        userName = "";
      });
      return;
    }
    try {
      setState(() {
        userName = "-";
      });
      var response = await unAuthDio.get(
        "/api/finance/transfer/verifyBank/?bankCode=${selectedData!.value}&accountNumber=${controller.text.trim()}/",
      );
      var info = response.data['data'];
      setState(() {
        userName = info['accountName'];
      });
    } on DioError catch (e) {
      setState(() {
        userName = "";
      });
      print(e.response?.data);
      if (e.response != null) {
      } else {}
    } catch (e) {
      setState(() {
        userName = "";
      });
      print(e);
    }
  }

  Future<void> send() async {
    try {
      setState(() {
        loading = true;
      });
      Map<String, dynamic> data = {
        "accountNumber": "${controller.text.trim()}", // required
        "bankCode": "${selectedData!.value}", // required
        "amount": "${controller2.text.trim()}", // required
        "currency": "NGN", // required
      };
      if (controller3.text.trim().isNotEmpty) {
        data['description'] = controller3.text.trim();
      }
      await dio.post(
        "/api/finance/transfer/toBank/",
        data: data,
      );
      setState(() {
        loading = false;
      });
      Navigator.of(context).pop();
    } on DioError catch (e) {
      setState(() {
        loading = false;
      });
      print(e.response?.data);
      if (e.response != null) {
      } else {}
    } catch (e) {
      setState(() {
        loading = false;
      });
      ;
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getBanks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new)),
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal! * 2,
                  ),
                  const Text(
                    "Transfer to Bank account",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    top: SizeConfig.safeBlockVertical! * 4,
                    bottom: SizeConfig.safeBlockVertical! * 10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: [
                      LuxPicker(
                        suffixIcon: Icon(IconlyLight.paper),
                        hint: "Select Bank",
                        values: data,
                        value: selectedData?.title,
                        onChanged: (value) {
                          selectedData = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 2,
                      ),
                      LuxTextField(
                        suffixIcon: Icon(IconlyLight.addUser),
                        hint: "Enter account number",
                        controller: controller,
                        innerHint: "142*****73",
                        onChanged: (v) {
                          if (v.trim().length == 10) {
                            getUserName();
                          }
                          setState(() {});
                        },
                        textInputType: TextInputType.number,
                        formatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            userName,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 2,
                      ),
                      LuxTextField(
                        suffixIcon: Icon(IconlyLight.paper),
                        hint: "Enter amount",
                        innerHint: "2000.00",
                        controller: controller2,
                        onChanged: (v) {
                          setState(() {});
                        },
                        textInputType: TextInputType.number,
                        formatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 5,
                      ),
                      LuxTextField(
                        multiline: true,
                        hint: "Reason for withdrawal? (optional)",
                        innerHint: "Enter  message",
                        controller: controller3,
                        textInputType: TextInputType.number,
                        formatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 7,
                      ),
                      !loading
                          ? GestureDetector(
                              onTap: () {
                                if (selectedData == null ||
                                    userName == "" ||
                                    userName == "-" ||
                                    controller.text.trim().length != 10 ||
                                    (controller2.text.trim().isEmpty ||
                                        double.parse(controller2.text.trim()) <
                                            100)) {
                                  return;
                                }
                                send();
                              },
                              child: luxButton(
                                HexColor("#D70A0A").withOpacity(
                                  selectedData == null ||
                                          userName == "" ||
                                          userName == "-" ||
                                          controller.text.trim().length != 10 ||
                                          (controller2.text.trim().isEmpty ||
                                              double.parse(
                                                      controller2.text.trim()) <
                                                  100)
                                      ? 0.5
                                      : 1,
                                ),
                                HexColor("#FFFFFF"),
                                "Continue",
                                double.infinity,
                              ),
                            )
                          : luxButtonLoading(
                              HexColor("#D70A0A"), double.infinity),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
