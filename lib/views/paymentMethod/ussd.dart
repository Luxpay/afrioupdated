import 'package:flutter/material.dart';
import 'package:luxpay/podos/banks.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/utils/toaster.dart';
import 'package:luxpay/widgets/lux_textfield.dart';
import 'package:luxpay/widgets/payment/lux_account.dart';
import 'package:luxpay/widgets/ussd/processing_ussd.dart';

class UssdTransfer extends StatefulWidget {
  const UssdTransfer({Key? key}) : super(key: key);

  @override
  _UssdTransferState createState() => _UssdTransferState();
}

class _UssdTransferState extends State<UssdTransfer> {
  TextEditingController amountController = TextEditingController();
  List<Bank> items = [
    new Bank(0, "UBA", "*919#", "assets/paymentMethod/bankLogos/uba.png",
        "assets/paymentMethod/bankLogos/uba.png"),
    new Bank(
        1,
        "Zenith Bank",
        "*966#",
        "assets/paymentMethod/bankLogos/zenith.png",
        "assets/paymentMethod/bankLogos/uba.png"),
    new Bank(
        2,
        "Access Bank",
        "*901#",
        "assets/paymentMethod/bankLogos/access.png",
        "assets/paymentMethod/bankLogos/uba.png"),
    new Bank(3, "Wema Bank", "*945#", "assets/paymentMethod/bankLogos/wema.png",
        "assets/paymentMethod/bankLogos/uba.png"),
    new Bank(4, "GT Bank", "*737#", "assets/paymentMethod/bankLogos/gtb.png",
        "assets/paymentMethod/bankLogos/uba.png"),
    new Bank(
        5,
        "First Bank",
        "*894#",
        "assets/paymentMethod/bankLogos/first-bank.png",
        "assets/paymentMethod/bankLogos/uba.png"),
    new Bank(
        6,
        "Eco Bank",
        "*326#",
        "assets/paymentMethod/bankLogos/eco-bank.png",
        "assets/paymentMethod/bankLogos/uba.png"),
    new Bank(
        7,
        "Heritage Bank",
        "*770#",
        "assets/paymentMethod/bankLogos/hb.png",
        "assets/paymentMethod/bankLogos/uba.png"),
    new Bank(
        8,
        "Union Bank",
        "*826#",
        "assets/paymentMethod/bankLogos/union.png",
        "assets/paymentMethod/bankLogos/uba.png"),
    new Bank(
        9,
        "Fidelity Bank",
        "*826#",
        "assets/paymentMethod/bankLogos/fidelity.png",
        "assets/paymentMethod/bankLogos/uba.png"),
    new Bank(
        10,
        "Stanbic IBTC",
        "*826#",
        "assets/paymentMethod/bankLogos/stanbic.png",
        "assets/paymentMethod/bankLogos/uba.png"),
    new Bank(11, "FCMB", "*826#", "assets/paymentMethod/bankLogos/fcmb.png",
        "assets/paymentMethod/bankLogos/uba.png"),
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: const Icon(Icons.arrow_back_ios_new),
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal! * 2.4,
                  ),
                  const Text(
                    "Top up via USSD",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 2.3,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "You can also fund your LuxPay wallet with your bank's USSD code. Enter the amount you want to deposit, then select your Bank's USSD from the list below. ",
                      style: TextStyle(
                          color: HexColor("#8D9091"),
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 1.6,
                    ),
                    LuxAccount(),
                    //amount
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: LuxTextField(
                        hint: "Amount ( N )",
                        hintColour: HexColor("#8D9091"),
                        hintWeight: FontWeight.w400,
                        controller: amountController,
                        innerHint: "N 5,000",
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Text(
                        "Select a funding source",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: HexColor("#8D9091")),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0, bottom: 28.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            index == items.length - 1
                                ? Container()
                                : const SizedBox(
                                    height: 28,
                                  ),
                        itemBuilder: (context, index) => BankWidget(
                          bank: items[index],
                        ),
                        itemCount: items.length,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget BankWidget({required Bank bank}) {
    return InkWell(
      onTap: () => {
        if (amountController.text.isNotEmpty)
          {
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0)),
              ),
              backgroundColor: Colors.white,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return ProcessingBottomSheet(
                  bank: bank,
                  amount: double.parse(amountController.text),
                );
              },
            )
          }
        else
          {LuxToast.show(msg: "Please enter amount to proceed!")}
      },
      child: Row(
        children: [
          Image.asset(
            "${bank.img}",
            height: 45,
            width: 45,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 37.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${bank.name}",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 13)),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "${bank.ussdCode}",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
