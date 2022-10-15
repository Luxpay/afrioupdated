import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';

class FQAs extends StatefulWidget {
  const FQAs({Key? key}) : super(key: key);

  @override
  State<FQAs> createState() => _FQAsState();
}

class _FQAsState extends State<FQAs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: HexColor("#333333").withOpacity(0.3),
                      width: 0.5,
                    ),
                  )),
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () => {Navigator.maybePop(context)},
                            icon: const Icon(Icons.arrow_back_ios_new)),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal! * 2,
                        ),
                        const Text(
                          "FQAs",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 100),
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView(children: [
                          Card1(),
                          Card2(),
                          Card3(),
                          Card4(),
                          Card5(),
                          Card6(),
                          Card7(),
                          Card8(),
                          Card9(),
                          SizedBox(height: 20)
                        ]),
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}

class Card1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // buildItem(String label) {
    //   return Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Text(label),
    //   );
    // }

    buildList() {
      return Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(left: 20),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "1. What does bvn means ?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "BVN is short for Bank Verification Number. It is an 11 digits biometric identification set of numbers that give each Nigerian bank account owner a unique identity that can be verified across the Nigerian Banking Industry."),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "2. Why is my bank verification number (BVN) required?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "Your BVN is used to confirm your identity and complete your KYC verification. Providing your BVN also allows us to increase your transaction limits on LuxPay. "),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "3. I don’t know my BVN. What do I do?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "To find out your BVN, you can dial *565*0# on your mobile phone. Please note that this will only work if you make the request on the same mobile number currently linked to your bank account."),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "4. 	Can I access LuxPay from any location?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "LuxPay is accessible from any part of the world as long as you have an active internet connection."),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "5.  Which card types are supported?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "LuxPay supports payments from and transfers to Mastercard, Verve and Visa cards. "),
                      ),
                    ],
                  ),
                ],
              ))
        ],
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  height: 40,
                  color: HexColor("#5DADEC"),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "General Information",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 8),
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: IconlyLight.arrowRightCircle,
                            collapseIcon: IconlyLight.arrowDownCircle,
                            iconColor: Colors.white,
                            iconSize: 20.0,
                            //iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: buildList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Card2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // buildItem(String label) {
    //   return Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Text(label),
    //   );
    // }

    buildList() {
      return Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height - 450,
              margin: EdgeInsets.only(left: 20),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "•	What is a KYC Tier?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "LuxPay separates users into two different levels, KYC Tier 1 and KYC Tier 2, which provide different account limits."),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "•	How much money can I send?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "LuxPay has two account tiers:\n– Tier 1 has a transaction limit of ₦50,000 and balance limit of ₦400,000\n– Tier 2 has a transaction limit of ₦200,000 and a balance limit of ₦1,000,000\nYou can upgrade by verifying your bank account from the profile screen."),
                      ),
                    ],
                  ),
                ],
              ))
        ],
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  height: 40,
                  color: HexColor("#5DADEC"),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Pricing and limits",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 8),
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: IconlyLight.arrowRightCircle,
                            collapseIcon: IconlyLight.arrowDownCircle,
                            iconColor: Colors.white,
                            iconSize: 20.0,
                            //iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: buildList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Card3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // buildItem(String label) {
    //   return Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Text(label),
    //   );
    // }

    buildList() {
      return Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height - 200,
              margin: EdgeInsets.only(left: 20),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "•	What is my card CVV?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "Your CVV is the three-digit number printed on the signature panel located on the back of your card. It is usually under the magnetic strip, to the right of the signature box."),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "•	Why does LuxPay ask for the CVV code when I carry out transactions?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "This is an extra layer of security to ensure the card information being used has not been lifted from the internet or other non-authorised channels."),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "•	Why do you need my card details?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "LuxPay only requires your card details when using a bank card for payment; this includes funding your balance or making a transfer. Since card details are very confidential, LuxPay recruits the latest security protocols to protect and encrypt every activity on its platform. "),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "•	I am running into issues trying to add a bank card to my account.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "LuxPay only requires your card details when using a bank card for payment; this includes funding your balance or making a transfer. Since card details are very confidential, LuxPay recruits the latest security protocols to protect and encrypt every activity on its platform. "),
                      ),
                    ],
                  ),
                ],
              ))
        ],
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  height: 40,
                  color: HexColor("#5DADEC"),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Card Setup",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 8),
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: IconlyLight.arrowRightCircle,
                            collapseIcon: IconlyLight.arrowDownCircle,
                            iconColor: Colors.white,
                            iconSize: 20.0,
                            //iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: buildList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Card4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // buildItem(String label) {
    //   return Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Text(label),
    //   );
    // }

    buildList() {
      return Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height - 600,
              margin: EdgeInsets.only(left: 20),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "•	How do I get the latest version of the app?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "To get the best user experience, we insist that you constantly update your app to the latest version. To do this, search for “LuxPay” on your device’s app store, then click the “Update” button. If this doesn’t work, try uninstalling then reinstalling the app."),
                      ),
                    ],
                  ),
                ],
              ))
        ],
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  height: 40,
                  color: HexColor("#5DADEC"),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "LuxPay App",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 8),
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: IconlyLight.arrowRightCircle,
                            collapseIcon: IconlyLight.arrowDownCircle,
                            iconColor: Colors.white,
                            iconSize: 20.0,
                            //iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: buildList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Card5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // buildItem(String label) {
    //   return Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Text(label),
    //   );
    // }

    buildList() {
      return Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height - 450,
              margin: EdgeInsets.only(left: 20),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "•	What is a referral link?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "LuxPay offers a reward program that allows you to earn LuxPoints for referring other users to our service. Your referral link is a unique invitation code you share with your friends which they’ll use to signup on the LuxPay platform. "),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "•	I’ve referred a friend, but did not earn a bonus – what happened?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "Your friend has to register via your referral link or with your referral code for you to earn your reward. If they are already members of LuxPay, we won't credit you with any reward. Don't hesitate to contact Customer Care if you believe that LuxPoints have not been awarded correctly."),
                      ),
                    ],
                  ),
                ],
              ))
        ],
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  height: 40,
                  color: HexColor("#5DADEC"),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Referral Program",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 8),
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: IconlyLight.arrowRightCircle,
                            collapseIcon: IconlyLight.arrowDownCircle,
                            iconColor: Colors.white,
                            iconSize: 20.0,
                            //iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: buildList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Card6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // buildItem(String label) {
    //   return Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Text(label),
    //   );
    // }

    buildList() {
      return Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(left: 20),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "•	What do I do when my wallet gets debited twice for one bank transfer but the transfer is only shown once in the receiver's account?\nKindly reach out to us via the support tab with the following information:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Text("•	LuxPay account number",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text("•	Bank account number that was credited",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text("•	Bank name",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text("•	Transfer amount",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text("•	Transaction reference(s)",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "•	What do I do when I mistakenly transfer money to a wrong account number?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "Suppose you credit the wrong account; we suggest you reach out to the account owner to recover your funds. We can do nothing to help recover funds after a wrong transfer. "),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "•	What do I do when my wallet gets debited for a transfer but the receiver did not get a transaction alert?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "Note that most transactions could take a while, from minutes to days before the notifications show up. We advise that you plead with the customer to (keep) recheck their LuxPay balance."),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "•	What do I do when my wallet gets debited and the person did not receive the money I sent?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "In such situations, open the Transaction details page and tap the CHAT WITH LUXPAY SUPPORT BUTTON. The details of the transaction would automatically be uploaded on the chat screen. Hit the SEND BUTTON.\nAlso, you can add a comment to enable our support representative to help you better.\nOn rare occasions, most transactions could take a while before reflecting on the user's account. In such cases, plead with the customer to be a bit patient as a network connection issue might be the culprit."),
                      ),
                    ],
                  ),
                ],
              ))
        ],
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  height: 40,
                  color: HexColor("#5DADEC"),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Transfer to bank",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 8),
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: IconlyLight.arrowRightCircle,
                            collapseIcon: IconlyLight.arrowDownCircle,
                            iconColor: Colors.white,
                            iconSize: 20.0,
                            //iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: buildList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Card7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // buildItem(String label) {
    //   return Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Text(label),
    //   );
    // }

    buildList() {
      return Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height - 400,
              margin: EdgeInsets.only(left: 20),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "•	What do I do when I receive a debit alert but there is no credit in my wallet? \nPlease visit our support site at ng-supportluxpay-inc.com and send the following details:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Text("•	Transaction number.",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text(
                          "•	A screenshot of the SMS or email alert from your bank.",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text(
                          "•	Including your ATM card's first six and last four digits in a message. (Please do not give your full card details to anybody, including LuxPay staff)",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "•	What do I do when I am debited more than what is in my wallet?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "Please send your bank statement with the time period to ng-support@luxpay-inc.com."),
                      ),
                    ],
                  ),
                ],
              ))
        ],
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  height: 40,
                  color: HexColor("#5DADEC"),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Wallet top-up",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 8),
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: IconlyLight.arrowRightCircle,
                            collapseIcon: IconlyLight.arrowDownCircle,
                            iconColor: Colors.white,
                            iconSize: 20.0,
                            //iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: buildList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Card8 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // buildItem(String label) {
    //   return Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Text(label),
    //   );
    // }

    buildList() {
      return Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height - 450,
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "•	What is LuxPay?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "LuxPay is a mobile payment platform designed to create a rewarding financial experience for users. It is the First digital Ecosystem, an all-in-one digital ecosystems solution.\n\nYour LuxPay account allows you to control your money and make transactions with friends and family, buy airtime, or pay bills. LuxPay also offers rewards via LuxPoints which can be redeemed or saved for later use."),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "•	Where can I download the LuxPay app?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "The LuxPay App is available on Google Play store for Android and iOS App Store for Apple devices."),
                      ),
                    ],
                  ),
                ],
              ))
        ],
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  height: 40,
                  color: HexColor("#5DADEC"),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "About LuxPay",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 8),
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: IconlyLight.arrowRightCircle,
                            collapseIcon: IconlyLight.arrowDownCircle,
                            iconColor: Colors.white,
                            iconSize: 20.0,
                            //iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: buildList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Card9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // buildItem(String label) {
    //   return Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Text(label),
    //   );
    // }

    buildList() {
      return Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(left: 20),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "	LuxPay to LuxPay transfer (Tag-Fund)",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Text("•	Launch your LuxPay app",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text("•	Tap the Send Tag-Fund icon",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text("•	Tap the ‘To Tag’ icon",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text(
                          "•	Enter in the users LuxPay ‘Tag-Fund’ and Tap ‘Next’",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text(
                          "•	Enter ‘Amount’ to be transferred and Tap ‘Transfer’",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text("•	Enter your transaction PIN.",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text("•	You should then receive a confirmation message.",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text("•	Tap ‘Complete’ to return to the home screen.",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "LuxPay to Bank Transfer (Send Money)",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Text("•	Launch your LuxPay app",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text("•	Tap the Send Money icon",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text("•	Tap the ‘Bank Account’ icon",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text(
                          "•	Select the Bank, enter the account number and amount then tap ‘Next’.",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text(
                          "•	Confirm the details, select your payment method and tap ‘Pay’",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text("•	Enter your LuxPay PIN",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text(
                          "•	You should then receive a confirmation message when the transfer is confirmed.",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text("•	Tap ‘Complete’ to return to the home screen.",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text(
                          "•	Can I make payments to friends who do not have LuxPay accounts?",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "•	Can I make payments to friends who do not have LuxPay accounts?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 8),
                        child: Text(
                            "Yes, you can send or request money from your friends via Facebook or SMS. After receiving the request, your friend will be required to register on LuxPay to carry out any transaction."),
                      ),
                    ],
                  ),
                ],
              ))
        ],
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  height: 40,
                  color: HexColor("#5DADEC"),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Sending and Receiving Money",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 8),
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: IconlyLight.arrowRightCircle,
                            collapseIcon: IconlyLight.arrowDownCircle,
                            iconColor: Colors.white,
                            iconSize: 20.0,
                            //iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: buildList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
