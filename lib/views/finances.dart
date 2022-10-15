import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/finances/transactionPage_details.dart';
import 'package:luxpay/views/finances/transfer_withdraw.dart';
import '../models/errors/authError.dart';
import '../models/trans_history.dart';
import '../models/withdralbeneficiary.dart';
import '../networking/DioServices/dio_client.dart';
import '../networking/DioServices/dio_errors.dart';
import '../widgets/methods/showDialog.dart';
import '../widgets/touchUp.dart';
import '../widgets/transfer_card.dart';
import 'accountSettings/transaction_details.dart';
import 'finances/transfer_toLuxpay.dart';

class FinancesPage extends StatefulWidget {
  const FinancesPage({Key? key}) : super(key: key);

  @override
  _FinancesPageState createState() => _FinancesPageState();
}

final storage = new FlutterSecureStorage();

class _FinancesPageState extends State<FinancesPage> {
  List<Result> transferList = [];
  bool fetchTransaction = false;
  var errors;
  String query = '';
  List<Results> beneficiaryList = [];
  bool fetchwithdrawalbene = false;

  Future<bool> _willPopCallback() async {
    showDialog(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.black,
            alignment: Alignment.center,
            child: popUp(context),
          );
        });
    return true; // return true if the route to be popped
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getTransactionHistory();
      getWithdrawalBeneficiary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, top: 15, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // IconButton(
                //     onPressed: () => {Navigator.pop(context)},
                //     icon: const Icon(Icons.arrow_back_ios_new)),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal! * 5,
                ),
                const Text(
                  "Transfer",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockHorizontal! * 5,
                    ),
                    child: Row(
                      children: [
                        TransferCard(
                          onTap: () {
                            //Navigator.pushNamed(context, WalletTransfer.path);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TransferToLuxpayAccount()));
                          },
                          color: "#339502",
                          title: "Transfer to \nLuxPay account",
                          image: "assets/ptransfer.png",
                        ),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal! * 2,
                        ),
                        TransferCard(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Withdrawal()));
                          },
                          color: "#395185",
                          title: "Transfer to \nBank account",
                          image: "assets/btransfer.png",
                        ),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal! * 2,
                        ),
                        TransferCard(
                          onTap: () {},
                          color: "#FB9B0B",
                          title: "International \nTransfer",
                          image: "assets/itransfer.png",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockHorizontal! * 6,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recent Transactions",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AccountTransactions()));
                              },
                              child: Text(
                                "See all",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 150, 148, 148),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 3,
                        ),
                        Container(
                            //color: Colors.blue,
                            height: 200,
                            child: transferList.isEmpty
                                ? Center(
                                    child: Text("No transfer records",
                                        style: TextStyle(
                                          color: HexColor("#CCCCCC"),
                                        )),
                                  )
                                : ListView.separated(
                                    itemCount: transferList.length < 3
                                        ? transferList.length
                                        : 3,
                                    itemBuilder: (context, index) {
                                      var transfers = transferList[index];
                                      var arr = transfers.amount.split('.');
                                      var amount = arr[0];
                                      var ref = transfers.reference;
                                      var dateValue = new DateFormat(
                                              "yyyy-MM-dd HH:mm:ss")
                                          .parse("${transfers.createdAt}", true)
                                          .toLocal();
                                      String formattedDate =
                                          DateFormat("MMMd h:mma")
                                              .format(dateValue);
                                      debugPrint(
                                          "formattedDate = " + formattedDate);
                                      return TransferHistoryCard(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TransactionDetailsPage(
                                                          reference: ref,
                                                        )));
                                          },
                                          amount: amount,
                                          status: transfers.status,
                                          date: formattedDate,
                                          type: transfers.type);
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider(color: Colors.black45);
                                    },
                                  )),
                        // SizedBox(
                        //   height: SizeConfig.safeBlockVertical! * 20,
                        // ),
                      ],
                    ),
                  ),
                  Divider(
                    color: HexColor("#E8E8E8").withOpacity(0.35),
                    thickness: 12,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockHorizontal! * 6,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Beneficiaries",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 150, 148, 148),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 4,
                        ),
                        Container(
                          //color: Colors.blue,
                          height: 300,
                          child: beneficiaryList.isEmpty
                              ? Center(
                                  child: Text("No transfer records",
                                      style: TextStyle(
                                        color: HexColor("#CCCCCC"),
                                      )),
                                )
                              : ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          Divider(height: 1),
                                  itemCount: beneficiaryList.length,
                                  itemBuilder: (context, index) {
                                    final tag = beneficiaryList[index];
                                    return ListTile(
                                      title: Text(tag.accountName),
                                      subtitle: Text(tag.accountNumber),
                                    );
                                  },
                                ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> getWithdrawalBeneficiary() async {
    try {
      var response = await dio.get(
        "/v1/finances/withdraw/beneficiaries/",
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        var accountData = await WithdrawalBeneficiary.fromJson(data);
        setState(() {
          beneficiaryList = accountData.data.results;

          fetchwithdrawalbene = true;
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
        //showChoiceDialog(context, errors, "Banks");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

  Future<bool> getTransactionHistory() async {
    try {
      var response = await dio.get(
        "/v1/finances/withdraw/history/?start=&stop=&status=SUCCESS&limit=10&offset=",
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        var transactionData = await TransactionHistory.fromJson(data);
        setState(() {
          transferList = transactionData.data.results;
          fetchTransaction = true;
        });
        debugPrint("OutPut ${transactionData.data.results.length}");
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
        showErrorDialog(context, errors, "Luxpay");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}

class TransferCard extends StatelessWidget {
  final VoidCallback onTap;
  final String color;
  final String title;
  final String image;
  const TransferCard({
    Key? key,
    required this.onTap,
    required this.color,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: SizeConfig.blockSizeVertical! * 12,
          decoration: BoxDecoration(
            color: HexColor(color),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                scale: 0.8,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
