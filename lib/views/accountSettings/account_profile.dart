import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/views/accountSettings/kyc.dart';
import 'package:luxpay/views/accountSettings/verifyId_card.dart';
import 'package:luxpay/views/accounts_subviews/upgrade_kyc_listpage.dart';

import '../../models/aboutUser.dart';
import '../../models/errors/authError.dart';
import '../../models/kycModel.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/lux_buttons.dart';
import '../../widgets/methods/showDialog.dart';
import '../../widgets/navigate_route.dart';
import 'edit_profile.dart';

class AccountProfile extends StatefulWidget {
  const AccountProfile({Key? key}) : super(key: key);

  @override
  State<AccountProfile> createState() => _AccountProfileState();
}

class _AccountProfileState extends State<AccountProfile> {
  var errors;

  String? firstname, lastname, email, phone, userAvatar;

  int? kycLevel;
  List<Datum> kycList = [];

  String? cummuLimit, dailyLimit, maxLimit, singleTransactionLimit;

  bool? checkAdmin;
  Future refreshChecks() async {
    await aboutUser();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      aboutUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: refreshChecks,
        child: SingleChildScrollView(
          child: firstname == null
              ? Container(
                  margin:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical! * 45),
                  child: Center(child: CircularProgressIndicator()))
              : Column(
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Container(
                              //margin: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () => {Navigator.pop(context)},
                                      icon:
                                          const Icon(Icons.arrow_back_ios_new)),
                                  const Text(
                                    "Profile Details",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: EdgeInsets.only(
                              top: 90,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 40.5,
                                      backgroundImage:
                                          NetworkImage("${userAvatar}"),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    SizedBox(height: 15),
                                    Container(
                                        height: 30,
                                        width: 130,
                                        decoration: BoxDecoration(
                                            color: grey1,
                                            border: Border.all(color: grey5),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                            child: Text(
                                                "Level ${kycLevel ?? "..."}"))),
                                    SizedBox(height: 10),
                                    Text(
                                      "${lastname ?? "...."} ${firstname ?? "...."}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "${email ?? "...."}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "${phone ?? "...."}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    SizedBox(height: 8),
                                    button(
                                      title: "Edit details",
                                      onTap: () {
                                        Navigator.push(context,
                                            SizeTransition4(EditProfile()));
                                      },
                                      active: true,
                                    ),
                                    SizedBox(height: 15),
                                    kyc_card(
                                      levels: "${kycLevel ?? "0.0"}",
                                      singleTransactionLimit:
                                          '${singleTransactionLimit ?? "0.0"}',
                                      dailyLimit: "${dailyLimit ?? "0.0"}",
                                      cummuLimit:
                                          "${cummuLimit ?? "unlimited"}",
                                      maxLimit: "${maxLimit ?? "0.0"}",
                                    ),
                                    SizedBox(height: 5),
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              SizeTransition4(KYCPage()));
                                        },
                                        child: Text("See All")),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 3.2,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: kycLevel == 3
                          ? Container()
                          : InkWell(
                              onTap: () {
                                Navigator.push(
                                    context, SizeTransition4(ValidIDCard()));
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => VerifyMeForUpgrade()));
                              },
                              child: luxButton(
                                  HexColor("#D70A0A"),
                                  Colors.white,
                                  "Upgrade Account",
                                  double.infinity,
                                  fontSize: 16),
                            ),
                    ),
                    SizedBox(height: 20),
                    Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: checkAdmin == true
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      SizeTransition4(UpgradeKYCListPage()));
                                },
                                child: luxButton(
                                    HexColor("#000000"),
                                    Colors.white,
                                    "Admin Dashboard",
                                    double.infinity,
                                    fontSize: 16),
                              )
                            : Container()),
                    SizedBox(height: 20),
                  ],
                ),
        ),
      )),
    );
  }

  Widget button(
      {required String title, VoidCallback? onTap, bool active = true}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        width: SizeConfig.blockSizeHorizontal! * 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: HexColor("#D70A0A"),
          boxShadow: [
            BoxShadow(
              color: grey3.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: active ? Colors.white : Colors.black,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Future<bool> aboutUser() async {
    try {
      var response = await dio.get(
        "/user/profile/",
      );
      debugPrint('Data Code ${response.statusCode}');

      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('Check Data ${data}');

        var user = await AboutUser.fromJson(data);

        setState(() {
          firstname = user.data.firstName;
          lastname = user.data.lastName;
          email = user.data.email;
          phone = user.data.phone;
          userAvatar = user.data.avatar;
          kycLevel = user.data.kycLevel;
          checkAdmin = user.data.isAdmin;
        });
        await aboutKyc(kycLevel);

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
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
        errors = errorMessage;
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

  Future<bool> aboutKyc(level) async {
    try {
      var response = await dio.get(
        "/wallet/levels/",
      );
      debugPrint('Data Code ${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('Check Data ${data}');

        var kycLevelData = await AllKycLevels.fromJson(data);

        setState(() {
          kycList = kycLevelData.data;
          int index = level - 1;
          cummuLimit = kycList[index].cummulativeLimit;
          dailyLimit = kycList[index].dailyLimit;
          maxLimit = kycList[index].single.credit;
          singleTransactionLimit = kycList[index].single.debit;
        });

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
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
        errors = errorMessage;
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}

class kyc_card extends StatelessWidget {
  final String singleTransactionLimit, dailyLimit, cummuLimit, maxLimit, levels;
  const kyc_card(
      {Key? key,
      required this.cummuLimit,
      required this.dailyLimit,
      required this.maxLimit,
      required this.singleTransactionLimit,
      required this.levels})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(
          milliseconds: 200,
        ),
        height: 280,
        width: MediaQuery.of(context).size.width - 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: grey3),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100.withOpacity(0.4),
              offset: Offset(3, 3),
            )
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              "Level ${levels}",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
            SizedBox(height: 5),
            Text(
              "Current Limit",
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Single transaction limit",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "N${singleTransactionLimit.replaceAllMapped(reg, mathFunc)}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Daily transaction limit",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "N${dailyLimit.replaceAllMapped(reg, mathFunc)}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Cumulative transaction\nlimit",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "N${cummuLimit.replaceAllMapped(reg, mathFunc)}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Maximum account\nbalance",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "N${maxLimit.replaceAllMapped(reg, mathFunc)}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Benefits",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "Domestic transactions",
                      style: TextStyle(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
