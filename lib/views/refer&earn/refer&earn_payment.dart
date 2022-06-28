import 'package:flutter/material.dart';
import 'package:luxpay/views/refer&earn/referDebit.dart';

import '../../podos/payment_methods.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';

class ReferEarnPaymentMethod extends StatefulWidget {
  const ReferEarnPaymentMethod({Key? key}) : super(key: key);

  @override
  State<ReferEarnPaymentMethod> createState() => _ReferEarnPaymentMethodState();
}

class _ReferEarnPaymentMethodState extends State<ReferEarnPaymentMethod> {
  List<PaymentMethodObj> items = [
    new PaymentMethodObj(
        1,
        "Wallet Balance",
        "From bank app or internet banking",
        "assets/paymentMethod/bank.png",
        HexColor("#F4752E").withOpacity(.20)),
    new PaymentMethodObj(2, "Debit Card", "Top up with a debit card",
        "assets/paymentMethod/card.png", HexColor("#22B02E").withOpacity(.20)),
    // new PaymentMethodObj(3, "USSD", "With your other bank’s USSD code",
    //     "assets/paymentMethod/hash.png", HexColor("#144DDE").withOpacity(.20)),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Payment Method",
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
              Container(
                color: HexColor("#FBFBFB"),
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          index == items.length - 1
                              ? Container()
                              : const SizedBox(
                                  height: 16,
                                ),
                      padding: const EdgeInsets.symmetric(horizontal: 24).add(
                        const EdgeInsets.only(top: 27, bottom: 32),
                      ),
                      itemBuilder: (context, index) => PaymentMethodWidget(
                        paymentMethodObj: items[index],
                      ),
                      itemCount: items.length,
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

  PaymentMethodWidget({required PaymentMethodObj paymentMethodObj}) {
    return InkWell(
      onTap: () => {
        if (paymentMethodObj.id == 1)
          {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => BankTransfer()))
          }
        else
          {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ReferrerDebitCard()))
          }
        // else
        //   {
        //     // Navigator.push(context,
        //     //     MaterialPageRoute(builder: (context) => UssdTransfer()))
        //   }
      },
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, top: 30.5, bottom: 30.5, right: 22.67),
          child: Row(
            children: [
              Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: paymentMethodObj.colour,
                      borderRadius: BorderRadius.circular(16)),
                  child: Image.asset(
                    "${paymentMethodObj.img}",
                    scale: 2,
                  )),
              SizedBox(
                width: 21,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${paymentMethodObj.title}"),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${paymentMethodObj.subTitle}",
                    style: TextStyle(
                        color: HexColor("#8D9091"),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: HexColor("#8D9091"),
                      size: 14,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
