import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/widgets/airtime/confirmation.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';

import '../../viewModels/rechargeAndBills/airtime_vm.dart';

class Plans {
  String charge;
  String desc;

  Plans(this.charge, this.desc);
}

class Airtime extends StatefulWidget {
  const Airtime({Key? key}) : super(key: key);

  @override
  _AirtimeState createState() => _AirtimeState();
}

class _AirtimeState extends State<Airtime> {
  AirtimeVM airtimeVM = new AirtimeVM();
  TextEditingController controller = TextEditingController();
  TextEditingController amountController = TextEditingController();
  List<Plans> plans = [];

  @override
  void initState() {
    
    super.initState();
    plans = airtimeVM.getAllPlans();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final orientation = MediaQuery.of(context).orientation;
    final double itemHeight = SizeConfig.safeBlockVertical! * .95;
    final double itemWidth = SizeConfig.safeBlockHorizontal! * 3;
    final double ratio = (itemWidth / itemHeight - 0.2);
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
                    "Airtime",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Network provider",
                      style: TextStyle(color: HexColor("#8D9091")),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 1.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/rechargeBills/airtime/mtn.png",
                            height: 50,
                            width: 52,
                          ),
                          Image.asset(
                            "assets/rechargeBills/airtime/9mobile.png",
                            height: 50,
                            width: 52,
                          ),
                          Image.asset(
                            "assets/rechargeBills/airtime/airtel.png",
                            height: 50,
                            width: 52,
                          ),
                          Image.asset(
                            "assets/rechargeBills/airtime/glo.png",
                            height: 50,
                            width: 52,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 3,
                    ),
                    //phone number
                    LuxTextField(
                        hint: "Phone number",
                        hintColour: HexColor("#8D9091"),
                        hintWeight: FontWeight.w400,
                        controller: controller,
                        enabled: true,
                        innerHint: "e.g 08123456789",
                        maxLength: 11,
                        textInputType: TextInputType.phone,
                        suffixIcon: InkWell(
                            onTap: () => {Navigator.pop(context)},
                            child: Image.asset(
                              "assets/rechargeBills/airtime/user-id-card.png",
                              height: 17,
                              scale: 2,
                            ))),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 3,
                    ),
                    //amount
                    LuxTextField(
                      hint: "Enter an amount",
                      hintColour: HexColor("#8D9091"),
                      hintWeight: FontWeight.w400,
                      controller: amountController,
                      innerHint: "Enter amount",
                      textInputType: TextInputType.number,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 3,
                    ),
                    Text(
                      "Select airtime amount",
                      style: TextStyle(
                          color: HexColor("#8D9091"),
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 1,
                    ),
                    GridView.builder(
                      // scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      // padding: EdgeInsets.only(top: 18),
                      itemCount: plans.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext ctxt, int index) {
                        return planCard(plans[index], context, index);
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: (ratio),
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 10,
                          crossAxisCount:
                              (orientation == Orientation.portrait) ? 3 : 3),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 4.5,
                    ),
                    InkWell(
                        onTap: () => {
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
                                  return ConfirmationBottomSheet();
                                },
                              )
                            },
                        child: luxButton(
                            HexColor("#D70A0A"), Colors.white, "Continue", 325,
                            fontSize: 16, height: 50, radius: 8))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget planCard(Plans plan, BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
          color: HexColor("#E8E8E8"), borderRadius: BorderRadius.circular(14)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${plan.charge}",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.9),
                  fontWeight: FontWeight.w700,
                  fontSize: 13)),
          SizedBox(
            height: 4,
          ),
          Text(
            "${plan.desc}",
            style: TextStyle(
                color: HexColor("#8D9091E5").withOpacity(0.9),
                fontWeight: FontWeight.w600,
                fontSize: 8),
          )
        ],
      ),
    );
  }
}
