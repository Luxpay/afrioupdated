import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/models/errors/authError.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import '../../models/about_wallet.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../utils/constants.dart';
import '../../utils/hexcolor.dart';
import '../../widgets/lux_buttons.dart';
import '../../widgets/methods/showDialog.dart';
import 'crow365pin.dart';


class Crowd365PaymentMethod extends StatefulWidget {
  final String packageName,
      packagePrice,
      packageWelcomeBonus,
      packageReward,
      packageEachCycle;
  Crowd365PaymentMethod(
      {Key? key,
      required this.packageName,
      required this.packagePrice,
      required this.packageWelcomeBonus,
      required this.packageReward,
      required this.packageEachCycle})
      : super(key: key);

  @override
  State<Crowd365PaymentMethod> createState() => _Crowd365PaymentMethodState();
}

class _Crowd365PaymentMethodState extends State<Crowd365PaymentMethod> {
  bool selectPackageCheck = false;
  int selectedIndex = -1;
  String? walletBalance;
  bool checkdata = false;

  bool _isLoading = false;
  var errors;
  String? price, welcomeBonus, reward, eachCycle, name;

  @override
  void initState() {
    super.initState();
    getWallets();
    setState(() {
      price = widget.packagePrice;
      name = widget.packageName;
      welcomeBonus = widget.packageWelcomeBonus;
      reward = widget.packageReward;
      eachCycle = widget.packageEachCycle;
      debugPrint(price);
      debugPrint(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 16, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              "Subscribe package",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                        "Confirm Package",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      )),
                  WalletCard(balance: walletBalance ?? "..."),
                  SizedBox(height: 50),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () => setState(() {
                        // selectedIndex = index;
                        // selectPackageCheck = true;
                      }),
                      child: AnimatedContainer(
                        duration: Duration(
                          milliseconds: 200,
                        ),
                        padding: EdgeInsets.only(
                          top: 23,
                          left: SizeConfig.blockSizeHorizontal! * 5,
                          right: SizeConfig.blockSizeHorizontal! * 5,
                          bottom: 17,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: HexColor("#415CA0"),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade100.withOpacity(0.4),
                              offset: Offset(3, 3),
                            )
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset("assets/${name}.png"),
                            SizedBox(
                                width: SizeConfig.blockSizeHorizontal! * 4),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      bottom: 16,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          name!,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "N${price}",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Welcome Bonus",
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: HexColor("#8D9091"),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "Reward",
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: HexColor("#8D9091"),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "Each Cycle",
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: HexColor("#8D9091"),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "N${welcomeBonus}",
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: HexColor("#8D9091"),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "N${reward}",
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: HexColor("#8D9091"),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "N${eachCycle}",
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: HexColor("#8D9091"),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Crowd365Pin(name: name)));
                        },
                        child: _isLoading
                            ? luxButtonLoading(
                                HexColor("#415CA0"), double.infinity)
                            : luxButton(HexColor("#415CA0"), Colors.white,
                                "Pay", double.infinity,
                                fontSize: 16, height: 50, radius: 8)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  // Container(
                  //     child: Image.asset(
                  //   "assets/fprint_blue.png",
                  //   height: 50,
                  //   width: 50,
                  //   fit: BoxFit.cover,
                  // )),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Future<bool> getWallets() async {
    try {
      var response = await dio.get(
        base_url + "/v1/wallets/details/",
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        var walletData = await AboutWallet.fromJson(data);
        setState(() {
          checkdata = true;
          walletBalance = walletData.data.balance;
        });
        //debugPrint('Wallet Data : ${walletData.data.length}');

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          showExpiredsessionDialog(
              context, "Please Login again\nThanks", "Expired Session");
          return false;
        } else {
          var errorData = e.response?.data;
          var errorMessage = await AuthError.fromJson(errorData);
          errors = errorMessage.message;
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}

class WalletCard extends StatelessWidget {
  final String balance;
  const WalletCard({Key? key, required this.balance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    {
      return Container(
        margin: EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Image.asset(
                    "assets/fund-tag.png",
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Wallet Balance",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text(
                        "${balance}",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
