import 'package:flutter/material.dart';
import 'package:luxpay/podos/banks.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/paymentMethod/transferInstuctionsPage.dart';
import 'package:luxpay/widgets/payment/lux_account.dart';

class BankTransfer extends StatefulWidget {
  final String? accountNumber, accountName, bankName;
  const BankTransfer(
      {Key? key, this.accountNumber, this.accountName, this.bankName})
      : super(key: key);

  @override
  _BankTransferState createState() => _BankTransferState();
}

class _BankTransferState extends State<BankTransfer> {
  List<Bank> items = [
    new Bank(0, "UBA", "*919#", "assets/paymentMethod/bankLogos/uba.png",
        "assets/paymentMethod/bankWallpaper/uba-wallpaper-logo.png"),
    new Bank(
        1,
        "Zenith Bank",
        "*966#",
        "assets/paymentMethod/bankLogos/zenith.png",
        "assets/paymentMethod/bankWallpaper/uba.png"),
    new Bank(
        2,
        "Access Bank",
        "*901#",
        "assets/paymentMethod/bankLogos/access.png",
        "assets/paymentMethod/bankWallpaper/uba.png"),
    new Bank(3, "Wema Bank", "*945#", "assets/paymentMethod/bankLogos/wema.png",
        "assets/paymentMethod/bankWallpaper/uba.png"),
    new Bank(4, "GT Bank", "*737#", "assets/paymentMethod/bankLogos/gtb.png",
        "assets/paymentMethod/bankWallpaper/uba.png"),
    new Bank(
        5,
        "First Bank",
        "*894#",
        "assets/paymentMethod/bankLogos/first-bank.png",
        "assets/paymentMethod/bankWallpaper/uba.png"),
    new Bank(
        6,
        "Eco Bank",
        "*326#",
        "assets/paymentMethod/bankLogos/eco-bank.png",
        "assets/paymentMethod/bankWallpaper/uba.png"),
    new Bank(
        7,
        "Heritage Bank",
        "*770#",
        "assets/paymentMethod/bankLogos/hb.png",
        "assets/paymentMethod/bankWallpaper/uba.png"),
    new Bank(
        8,
        "Union Bank",
        "*826#",
        "assets/paymentMethod/bankLogos/union.png",
        "assets/paymentMethod/bankWallpaper/uba.png"),
    new Bank(
        9,
        "Fidelity Bank",
        "*826#",
        "assets/paymentMethod/bankLogos/fidelity.png",
        "assets/paymentMethod/bankWallpaper/uba.png"),
    new Bank(
        10,
        "Stanbic IBTC",
        "*826#",
        "assets/paymentMethod/bankLogos/stanbic.png",
        "assets/paymentMethod/bankWallpaper/uba.png"),
    new Bank(11, "FCMB", "*826#", "assets/paymentMethod/bankLogos/fcmb.png",
        "assets/paymentMethod/bankWallpaper/uba.png"),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final orientation = MediaQuery.of(context).orientation;
    final double itemHeight = SizeConfig.safeBlockVertical! * .95;
    final double itemWidth = SizeConfig.safeBlockHorizontal! * 2.5;
    final double ratio = (itemWidth / itemHeight - 0.5);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 15),
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
                      "Top up via Bank transfer",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 1.6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          "You can credit your LuxPay account via bank transfer. This is similar to transacting with a regular bank account number. ",
                          style: TextStyle(
                              color: HexColor("#8D9091"),
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 2.3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Text(
                          "Note: This is an example format to transfer with bank",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 2.3,
                      ),
                      LuxAccount(
                        bankName: widget.bankName,
                        bankNumber: widget.accountNumber,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 28.0),
                        child: Text(
                          "Select a bank below and follow the onscreen instructions. ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: HexColor("#8D9091")),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 28.0, bottom: 28.0, left: 15, right: 15),
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: (ratio),
                                  crossAxisSpacing: 80,
                                  mainAxisSpacing: 33,
                                  crossAxisCount:
                                      (orientation == Orientation.portrait)
                                          ? 3
                                          : 3),
                          physics: const NeverScrollableScrollPhysics(),
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
      ),
    );
  }

  Widget BankWidget({required Bank bank}) {
    return InkWell(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TransferInstructions(
                      bank: bank,
                    )))
      },
      child: Image.asset(
        "${bank.img}",
        height: 45,
        width: 45,
      ),
    );
  }
}
